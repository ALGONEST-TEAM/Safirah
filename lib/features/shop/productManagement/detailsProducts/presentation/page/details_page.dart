import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../../../../../../core/state/state.dart';
import '../../../../../../core/widgets/show_modal_bottom_sheet_widget.dart';
import '../../../../shoppingBag/cart/presentation/pages/add_to_cart_page.dart';
import '../../../../shoppingBag/cart/presentation/widgets/add_to_cart_or_favorites_widget.dart';
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
  @override
  void initState() {
    super.initState();
  }

  final GlobalKey contentKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(detailsProvider(widget.idProduct));

    return Scaffold(
      appBar: AppBarOfDetailsWidget(
        imageForShare: widget.image!.isNotEmpty ? widget.image![0] : '',
        descriptionForShare: state.data.description ?? '',
        idProductForShare: state.data.id ?? 0,
        nameForShare: state.data.name ?? '',
        price: state.data.price.toString(),
        hideShareButton: false,
      ),
      body: CheckStateInGetApiDataWidget(
        state: state,
        widgetOfLoading: ShowDetailsComeFromCardProductWithShimmerWidget(
          key: contentKey,
          price: widget.price,
          name: widget.name,
          image: widget.image!,
        ),
        widgetOfData: SingleChildScrollView(
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
    );
  }
}
