import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../../../../../../core/state/check_state_in_post_api_data_widget.dart';
import '../../../../../../core/state/state.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/buttons/default_button.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../productManagement/detailsProducts/presentation/state_mangment/riverpod_details.dart';
import '../riverpod/cart_riverpod.dart';
import '../widgets/name_description_and_price_of_the_product_widget.dart';
import '../widgets/photo_list_widget.dart';
import '../widgets/product_colors_widget.dart';
import '../widgets/products_sizes_widget.dart';

class UpdateCartPage extends ConsumerStatefulWidget {
  final int id;
  final int productId;
  dynamic colorId;
  int? sizeId;
  String? sizeTypeName;
  String? colorName;
  final int quantity;
  final Function onSuccess;

  UpdateCartPage({
    super.key,
    required this.id,
    required this.productId,
    required this.quantity,
    required this.onSuccess,
    this.colorId,
    this.sizeId,
    this.sizeTypeName,
    this.colorName,
  });

  @override
  ConsumerState<UpdateCartPage> createState() => _UpdateCartPageState();
}

class _UpdateCartPageState extends ConsumerState<UpdateCartPage> {
  int mainIndex = 0;
  bool isMainInitialized = false;

  /// تحديد اللون الأساسي عند تحميل الصفحة لأول مرة
  void _initializeMainColor(data) {
    if (!isMainInitialized && data.colorsProduct!.isNotEmpty) {
      mainIndex = data.colorsProduct!
          .indexWhere((color) => color.idColor == widget.colorId);
      isMainInitialized = true;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(changePriceProvider(data).notifier).setIdColor(widget.colorId!);
      ref
          .read(changePriceProvider(data).notifier)
          .setNameSize(widget.sizeTypeName!);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(detailsProvider(widget.productId));
    var cartState = ref.watch(cartProvider);

    return Container(
      margin: EdgeInsets.only(top: 140.h),
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
            var price = ref.watch(changePriceProvider(state.data));

            _initializeMainColor(state.data);

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
                              : state.data.colorsProduct![mainIndex].image!,
                        ),
                      NameDescriptionAndPriceOfTheProductWidget(
                        idProduct: state.data.id!,
                        image: state.data.allImage,
                        name: state.data.name.toString(),
                        description: state.data.description.toString(),
                        price: price ?? state.data.price!,
                        updateCart: true,
                      ),
                      if (state.data.colorsProduct!.isNotEmpty)
                        ProductColorsWidget(
                          productsColors: state.data.colorsProduct!,
                          colorId: widget.colorId!,
                          colorName: widget.colorName.toString(),
                          onSelect: (int colorId, int index, String colorName) {
                            setState(() {
                              widget.colorId = colorId;
                              mainIndex = index;
                              widget.colorName = colorName;
                            });
                            ref
                                .read(changePriceProvider(state.data).notifier)
                                .setIdColor(colorId);
                          },
                        ),
                      ProductsSizesWidget(
                        data: state.data,
                        sizeId: widget.sizeId!,
                        sizeTypeName: widget.sizeTypeName,
                        onSelect: (int sizeId, String sizeTypeName) {
                          setState(() {
                            widget.sizeId = sizeId;
                            widget.sizeTypeName = sizeTypeName;
                          });
                          ref
                              .read(changePriceProvider(state.data).notifier)
                              .setNameSize(sizeTypeName);
                        },
                        onCounterChanged: (int value) {},
                      ),
                      10.h.verticalSpace,
                    ],
                  ),
                ),
                CheckStateInPostApiDataWidget(
                  state: cartState,
                  hasMessageSuccess: false,
                  functionSuccess: widget.onSuccess,
                  bottonWidget: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: DefaultButtonWidget(
                      text: S.of(context).refresh,
                      background: AppColors.secondaryColor,
                      height: 38.h,
                      textSize: 12.sp,
                      isLoading: cartState.stateData == States.loading,
                      onPressed: () {
                        ref.read(cartProvider.notifier).updateCart(
                              id: widget.id,
                              prodectId: widget.productId,
                              colorId: widget.colorId ?? '',
                              sizeId: widget.sizeId!,
                              price: price ?? state.data.price!,
                              quantity: widget.quantity,
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
