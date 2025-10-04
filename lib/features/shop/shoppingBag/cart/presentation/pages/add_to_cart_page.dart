import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../productManagement/detailsProducts/presentation/state_mangment/riverpod_details.dart';
import '../../../../productManagement/detailsProducts/presentation/widget/list_of_colors_product_widget.dart';
import '../../../../productManagement/detailsProducts/presentation/widget/list_of_number_product_widget.dart';
import '../../../../productManagement/detailsProducts/presentation/widget/list_of_size_product_widget.dart';
import '../../../../productManagement/detailsProducts/presentation/widget/printing_on_the_product_widget.dart';
import '../widgets/add_to_cart_or_favorites_widget.dart';
import '../widgets/loading_design_to_display_product_details_to_add_to_cart_widget.dart';
import '../widgets/name_description_and_price_of_the_product_widget.dart';
import '../widgets/photo_list_widget.dart';

class AddToCartPage extends ConsumerStatefulWidget {
  final int productId;
  final bool showWishlistIcon;

  const AddToCartPage({
    super.key,
    required this.productId,
    this.showWishlistIcon = true,
  });

  @override
  ConsumerState<AddToCartPage> createState() => _AddToCartPageState();
}

class _AddToCartPageState extends ConsumerState<AddToCartPage> {
  bool isSizeIdValid = false;
  bool isNumberIdValid = false;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(detailsProvider(widget.productId));

    return Container(
      margin: EdgeInsets.only(top: 80.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.sp),
          topRight: Radius.circular(8.sp),
        ),
      ),
      child: CheckStateInGetApiDataWidget(
        state: state,
        widgetOfLoading:
            const LoadingDesignToDisplayProductDetailsToAddToCartWidget(),
        widgetOfData: Consumer(
          builder: (context, ref, child) {
            var price = ref.watch(changePriceProvider(state.data));
            var indexColorImage =
                ref.watch(changeIndexOfColorImageAndSizeProvider);

            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      if (state.data.colorsProduct!.isNotEmpty ||
                          state.data.allImage!.isNotEmpty)
                        PhotoListWidget(
                          image: state.data.colorHasImage == false
                              ? state.data.allImage!
                              : state
                                  .data.colorsProduct![indexColorImage!].image!,
                        ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            NameDescriptionAndPriceOfTheProductWidget(
                              idProduct: state.data.id!,
                              image: state.data.allImage,
                              name: state.data.name.toString(),
                              description: state.data.description.toString(),
                              price: price ?? state.data.price!,
                              discountModel: state.data.discountModel,
                            ),
                            Visibility(
                              visible:
                                  state.data.colorsProduct?.isNotEmpty == true,
                              child: ListOfColorsProductWidget(
                                colorsProduct: state.data,
                              ),
                            ),
                            if (isSizeIdValid)
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 2.h),
                                child: AutoSizeTextWidget(
                                  text: S.of(context).pleaseSelectASize,
                                  fontSize: 11.sp,
                                  colorText: AppColors.dangerColor,
                                ),
                              ),
                            Visibility(
                              visible: state.data.sizeProduct!.isNotEmpty,
                              child: ListOfSizeProductWidget(
                                sizeProduct: state.data,
                              ),
                            ),
                            if (isNumberIdValid)
                              Padding(
                                padding: EdgeInsets.only(top: 6.h),
                                child: AutoSizeTextWidget(
                                  text: S.of(context).pleaseSelectANumber,
                                  fontSize: 11.sp,
                                  colorText: AppColors.dangerColor,
                                ),
                              ),
                            Visibility(
                              visible: state.data.numbersOfProduct!.isNotEmpty,
                              child: ListOfNumberProductWidget(
                                product: state.data,
                              ),
                            ),
                            Visibility(
                              visible: state.data.isPrintable == true,
                              child: Padding(
                                padding:  EdgeInsets.only(top: 12.h),
                                child: PrintingOnTheProductWidget(
                                  stateKey: 'details:${widget.productId}',
                                  printingPrice: state.data.productPrintingPrice.toString(),
                                  color: AppColors.scaffoldColor,
                                ),
                              ),
                            ),
                            14.h.verticalSpace,
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                AddToCartOrFavoritesWidget(
                  productId: widget.productId,
                  isPrintable: state.data.isPrintable! ,
                  showWishlistIcon: widget.showWishlistIcon,
                  onFavoriteLocalToggle: () {
                    setState(() => state.data.favorite = !state.data.favorite!);
                  },
                  handleInvalidSelection: null,
                  markSizeInvalid: () => setState(() => isSizeIdValid = true),
                  markNumberInvalid: () =>
                      setState(() => isNumberIdValid = true),
                  clearValidation: () => setState(() {
                    isSizeIdValid = false;
                    isNumberIdValid = false;
                  }),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
