import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../../core/constants/app_icons.dart';
import '../../../../../../core/state/data_state.dart';
import '../../../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../../../../../../core/state/state.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/show_modal_bottom_sheet_widget.dart';
import '../../../../shoppingBag/cart/presentation/pages/add_to_cart_page.dart';
import '../../../../shoppingBag/cart/presentation/widgets/add_to_cart_or_favorites_widget.dart';
import '../../data/model/product_data.dart';
import '../helpers/product_whatsapp_share_helper.dart';
import '../state_mangment/riverpod_details.dart';
import '../widget/app_bar_of_details_widget.dart';
import '../widget/product_reviews_widget.dart';
import '../widget/show_details_come_from_card_product_with_shimmer_widget.dart';
import '../widget/wares_part_in_details_widget.dart';

class DetailsPage extends ConsumerStatefulWidget {
  const DetailsPage({
    super.key,
    required this.idProduct,
    this.image,
    required this.name,
    required this.price,
  });

  final int idProduct;
  final List<String>? image;
  final String name;
  final dynamic price;

  @override
  ConsumerState<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends ConsumerState<DetailsPage>
    with TickerProviderStateMixin {
  List<String> get _initialImages => widget.image ?? const <String>[];

  @override
  void initState() {
    super.initState();
  }

  final GlobalKey contentKey = GlobalKey();

  bool _canShareProduct(DataState<ProductData> state) {
    if (state.stateData == States.loaded) return true;

    return widget.name.trim().isNotEmpty || _initialImages.isNotEmpty;
  }

  bool _shouldShowWhatsAppButton(DataState<ProductData> state) {
    return state.data.showWhatsapp == true && _canShareProduct(state);
  }

  String _resolveShareName(ProductData product) {
    final remoteName = product.name?.trim() ?? '';
    if (remoteName.isNotEmpty) return remoteName;
    return widget.name.trim();
  }

  String _resolveSharePrice(ProductData product) {
    final remotePrice = '${product.price ?? ''}'.trim();
    if (remotePrice.isNotEmpty && remotePrice != 'null') return remotePrice;

    final initialPrice = '${widget.price}'.trim();
    return initialPrice == 'null' ? '' : initialPrice;
  }

  String? _resolveShareImage(ProductData product) {
    final candidates = <String>[
      ...?product.mainImage,
      ...?product.allImage,
      ..._initialImages,
    ];

    for (final image in candidates) {
      final normalized = image.trim();
      if (normalized.isNotEmpty) return normalized;
    }

    return null;
  }

  Future<void> _shareProduct(ProductData product) async {
    final shareImage = await cacheProductShareImage(
      productId: widget.idProduct,
      imageUrl: _resolveShareImage(product),
    );
    final message = buildProductWhatsAppMessage(
      productId: widget.idProduct,
      name: _resolveShareName(product),
      price: _resolveSharePrice(product),
      imageUrl: _resolveShareImage(product),
    );

    try {
      if (shareImage != null) {
        await SharePlus.instance.share(
          ShareParams(
            text: message,
            files: [XFile(shareImage.path)],
          ),
        );
      } else {
        await SharePlus.instance.share(
          ShareParams(text: message),
        );
      }
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('حدث خطأ أثناء محاولة مشاركة المنتج'),
        ),
      );
    }
  }

  Future<void> _openSupportWhatsApp() async {
    final launched = await launchUrl(
      buildSupportWhatsAppUri(),
      mode: LaunchMode.externalApplication,
    );

    if (!launched && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تعذر فتح واتساب'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(detailsProvider(widget.idProduct));
    final initialImageForShare = _initialImages.isNotEmpty ? _initialImages[0] : '';

    return Scaffold(
      appBar: AppBarOfDetailsWidget(
        imageForShare: initialImageForShare,
        descriptionForShare: state.data.description ?? '',
        idProductForShare: state.data.id ?? 0,
        nameForShare: state.data.name ?? '',
        price: state.data.price.toString(),
        hideShareButton: !_canShareProduct(state),
        onSharePressed:
            _canShareProduct(state) ? () => _shareProduct(state.data) : null,
      ),
      body: CheckStateInGetApiDataWidget(
        state: state,
        widgetOfLoading: ShowDetailsComeFromCardProductWithShimmerWidget(
          key: contentKey,
          price: widget.price,
          name: widget.name,
          image: _initialImages,
        ),
        widgetOfData: RefreshIndicator(
          color: AppColors.primaryColor,
          backgroundColor: Colors.white,
          onRefresh: () async {
            await ref
                .read(detailsProvider(widget.idProduct).notifier)
                .getDetailsOfProduct();
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                WaresPartInDetailsWidget(
                  key: contentKey,
                  productData: state.data,
                ),
                if (state.data.productReviews?.isNotEmpty == true)
                  ProductReviewsWidget(data: state.data),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: state.stateData == States.loaded
          ? AddToCartOrFavoritesWidget(
              productId: widget.idProduct,
              isPrintable: state.data.isPrintable!,
              onFavoriteLocalToggle: () {
                setState(() => state.data.favorite = !state.data.favorite!);
              },
              handleInvalidSelection: (ctx, ref, data) {
                showModalBottomSheetWidget(
                  backgroundColor: Colors.transparent,
                  context: ctx,
                  page: AddToCartPage(productId: widget.idProduct),
                );
                return true;
              },
              markSizeInvalid: null,
              markNumberInvalid: null,
              clearValidation: null,
            )
          : null,
      floatingActionButton: _shouldShowWhatsAppButton(state)
          ? FloatingActionButton(
              heroTag: 'product-whatsapp-share-${widget.idProduct}',
              onPressed: _openSupportWhatsApp,
              backgroundColor: const Color(0xFF25D366),
              foregroundColor: Colors.white,
              child: SvgPicture.asset(
                AppIcons.whatsapp,
                width: 24,
                height: 24,
              ),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
