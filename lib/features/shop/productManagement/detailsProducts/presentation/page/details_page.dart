import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../../core/constants/app_icons.dart';
import '../../../../../../core/state/data_state.dart';
import '../../../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../../../../../../core/state/state.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/auto_size_text_widget.dart';
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

  String _buildProductShareMessage(ProductData product) {
    return buildProductWhatsAppMessage(
      productId: widget.idProduct,
      name: _resolveShareName(product),
      price: _resolveSharePrice(product),
      imageUrl: _resolveShareImage(product),
    );
  }

  Future<void> _openSupportWhatsApp(ProductData product) async {
    final launched = await launchUrl(
      buildSupportWhatsAppUri(
        message: _buildProductShareMessage(product),
      ),
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

  void _showWhatsAppActions(ProductData product) {
    showModalBottomSheetWidget(
      context: context,
      page: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 20.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeTextWidget(
                text: 'خيارات الواتساب',
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
              ),
              12.h.verticalSpace,
              _WhatsAppActionTile(
                iconPath: AppIcons.whatsapp,
                title: 'فتح واتساب مع الرسالة الجاهزة',
                subtitle: '775076388',
                onTap: () async {
                  Navigator.of(context).pop();
                  await _openSupportWhatsApp(product);
                },
              ),
              8.h.verticalSpace,
              _WhatsAppActionTile(
                iconPath: AppIcons.sharing,
                title: 'مشاركة المنتج بالصورة',
                subtitle: 'يفتح صفحة المشاركة مع النص والصورة',
                onTap: () async {
                  Navigator.of(context).pop();
                  await _shareProduct(product);
                },
              ),
            ],
          ),
        ),
      ),
    );
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
              onPressed: () => _showWhatsAppActions(state.data),
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

class _WhatsAppActionTile extends StatelessWidget {
  const _WhatsAppActionTile({
    required this.iconPath,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final String iconPath;
  final String title;
  final String subtitle;
  final Future<void> Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.r),
      child: InkWell(
        borderRadius: BorderRadius.circular(14.r),
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(color: const Color(0xFFE8E8E8)),
          ),
          child: Row(
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: const BoxDecoration(
                  color: Color(0xFFF6F6F6),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    iconPath,
                    width: 20.w,
                    height: 20.w,
                  ),
                ),
              ),
              10.w.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeTextWidget(
                      text: title,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    4.h.verticalSpace,
                    AutoSizeTextWidget(
                      text: subtitle,
                      fontSize: 10.5.sp,
                      colorText: AppColors.fontColor.withValues(alpha: 0.65),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

