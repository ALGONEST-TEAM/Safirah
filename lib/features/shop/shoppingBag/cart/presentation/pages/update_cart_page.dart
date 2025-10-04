import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../../../../../../core/state/check_state_in_post_api_data_widget.dart';
import '../../../../../../core/state/state.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../../core/widgets/buttons/default_button.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../productManagement/detailsProducts/presentation/state_mangment/riverpod_details.dart';
import '../../../../productManagement/detailsProducts/presentation/widget/list_of_colors_product_widget.dart';
import '../../../../productManagement/detailsProducts/presentation/widget/list_of_number_product_widget.dart';
import '../../../../productManagement/detailsProducts/presentation/widget/list_of_size_product_widget.dart';
import '../../../../productManagement/detailsProducts/presentation/widget/printing_on_the_product_widget.dart';
import '../riverpod/cart_riverpod.dart';
import '../widgets/name_description_and_price_of_the_product_widget.dart';
import '../widgets/photo_list_widget.dart';

class UpdateCartPage extends ConsumerStatefulWidget {
  final int id;
  final int productId;
  final int? colorId;
  final int? sizeId;
  final String? sizeTypeName;
  final String? colorName;
  final int? numberId;
  final String? numberName;
  final int quantity;
  final Function onSuccess;
  final int isPrintable;

  const UpdateCartPage({
    super.key,
    required this.id,
    required this.productId,
    required this.quantity,
    required this.onSuccess,
    this.colorId,
    this.sizeId,
    this.sizeTypeName,
    this.colorName,
    this.numberId,
    this.numberName,
    required this.isPrintable,
  });

  @override
  ConsumerState<UpdateCartPage> createState() => _UpdateCartPageState();
}

class _UpdateCartPageState extends ConsumerState<UpdateCartPage> {
  bool isMainInitialized = false;
  bool isSizeIdValid = false;
  bool isNumberIdValid = false;

  /// تحديد الصورة عند تحميل الصفحة لأول مرة
  void _initializeImage(data) {
    if (!isMainInitialized && data.colorsProduct!.isNotEmpty) {
      final mainIndex = data.colorsProduct!
          .indexWhere((color) => color.idColor == widget.colorId);
      isMainInitialized = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref
            .read(changeIndexOfColorImageAndSizeProvider.notifier)
            .setIndexColor(mainIndex);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(detailsProvider(widget.productId));
    var cartState = ref.watch(cartProvider);

    return Container(
      margin: EdgeInsets.only(top: 90.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.sp),
          topRight: Radius.circular(8.sp),
        ),
      ),
      child: CheckStateInGetApiDataWidget(
        state: state,
        widgetOfLoading: Container(
          height: 38.h,
          margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
          decoration: BoxDecoration(
            color: AppColors.secondaryColor,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Center(
            child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 2.5.w,
            ),
          ),
        ),
        widgetOfData: Consumer(
          builder: (context, ref, child) {
            _initializeImage(state.data);
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
                              updateCart: true,
                              discountModel: state.data.discountModel,

                            ),
                            Visibility(
                              visible:
                                  state.data.colorsProduct?.isNotEmpty == true,
                              child: ListOfColorsProductWidget(
                                colorsProduct: state.data,
                                colorIdOfTheCart: widget.colorId,
                                colorNameOfTheCart: widget.colorName,
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
                                sizeIdOfTheCart: widget.sizeId,
                                sizeNameOfTheCart: widget.sizeTypeName,
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
                                numberIdOfTheCart: widget.numberId,
                                numberOfTheCart: widget.numberName,
                              ),
                            ),
                            Visibility(
                              visible: state.data.isPrintable == true &&
                                  widget.isPrintable == 0,
                              child: Padding(
                                padding: EdgeInsets.only(top: 12.h),
                                child: PrintingOnTheProductWidget(
                                  stateKey: 'update:${widget.productId}',
                                  printingPrice: state.data.productPrintingPrice
                                      .toString(),
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
                CheckStateInPostApiDataWidget(
                  state: cartState,
                  hasMessageSuccess: false,
                  functionSuccess: () {
                    widget.onSuccess();
                    if (state.data.isPrintable == true &&
                        widget.isPrintable == 0) {
                      ref
                          .read(activatePrintingOnTheProductProvider(
                                  'update:${widget.productId}')
                              .notifier)
                          .state = false;
                    }
                  },
                  bottonWidget: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: DefaultButtonWidget(
                      text: S.of(context).refresh,
                      background: AppColors.secondaryColor,
                      height: 38.h,
                      textSize: 13.6.sp,
                      isLoading: cartState.stateData == States.loading,
                      onPressed: () {
                        final notifier =
                            ref.read(changePriceProvider(state.data).notifier);

                        final isPrintable = ref.read(
                            activatePrintingOnTheProductProvider(
                                    'update:${widget.productId}')
                                .notifier);
                        final idColor = notifier.getIdColor();
                        final idSize = notifier.getIdSize();
                        final numberId = notifier.getIdNumber();
                        final needsSize = idSize == 0;
                        final needsNumber =
                            (state.data.numbersOfProduct?.isNotEmpty ??
                                    false) &&
                                numberId == 0;

                        if (needsSize) {
                          setState(() => isSizeIdValid = true);
                          return;
                        }
                        if (needsNumber) {
                          setState(() => isNumberIdValid = true);
                          return;
                        }

                        setState(() {
                          isSizeIdValid = false;
                          isNumberIdValid = false;
                        });
                        ref.read(cartProvider.notifier).updateCart(
                              id: widget.id,
                              prodectId: widget.productId,
                              colorId: idColor,
                              sizeId: idSize,
                              price: price ?? state.data.price!,
                              quantity: widget.quantity,
                              numberId: numberId,
                              isPrintable: state.data.isPrintable == true &&
                                      widget.isPrintable == 0 &&
                                      isPrintable.state
                                  ? 1
                                  : widget.isPrintable,
                            );
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
