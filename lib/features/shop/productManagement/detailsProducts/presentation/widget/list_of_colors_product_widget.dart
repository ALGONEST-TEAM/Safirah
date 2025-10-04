import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safirah/core/widgets/online_images_widget.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../../generated/l10n.dart';
import '../../data/model/product_data.dart';
import '../state_mangment/riverpod_details.dart';

class ListOfColorsProductWidget extends ConsumerStatefulWidget {
  final ProductData colorsProduct;
  final int? colorIdOfTheCart;
  final String? colorNameOfTheCart;

  const ListOfColorsProductWidget({
    super.key,
    required this.colorsProduct,
    this.colorIdOfTheCart,
    this.colorNameOfTheCart,
  });

  @override
  ConsumerState<ListOfColorsProductWidget> createState() =>
      _ListOfColorsProductWidgetState();
}

class _ListOfColorsProductWidgetState
    extends ConsumerState<ListOfColorsProductWidget> {
  @override
  void initState() {
    ref.read(changePriceProvider(widget.colorsProduct).notifier).setIdColor(
        widget.colorsProduct.colorsProduct!.isEmpty
            ? 0
            : widget.colorIdOfTheCart ??
                widget.colorsProduct.colorsProduct![0].idColor!);
    ref.read(changePriceProvider(widget.colorsProduct).notifier).setNameColor(
        widget.colorsProduct.colorsProduct!.isEmpty
            ? ''
            : widget.colorNameOfTheCart ??
                widget.colorsProduct.colorsProduct![0].colorName!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeTextWidget(
          text:
              "${S.of(context).colors}: ${ref.read(changePriceProvider(widget.colorsProduct).notifier).getNameColor()} ",
          colorText: AppColors.fontColor,
          fontWeight: FontWeight.w400,
          fontSize: 12.5.sp,
        ),
        10.verticalSpace,
        Wrap(
          spacing: 10.0.w,
          runSpacing: 6.0.h,
          children: widget.colorsProduct.colorsProduct!
              .asMap()
              .map(
                (index, item) {
                  return MapEntry(
                    index,
                    Consumer(
                      builder: (context, ref, child) {
                        final selectedIdColor = ref
                            .read(changePriceProvider(widget.colorsProduct)
                                .notifier)
                            .getIdColor();
                        return GestureDetector(
                          onTap: () {
                            ref
                                .read(changeIndexOfColorImageAndSizeProvider
                                    .notifier)
                                .setIndexColor(index);

                            ref.read(changePriceProvider(widget.colorsProduct)
                                .notifier)
                              ..setIdColor(item.idColor!)
                              ..setNameColor(item.colorName!);

                            ref
                                .read(showNumberOfScrollImageProvider.notifier)
                                .setIndexColorImage(1);

                            // إعادة تعيين المقاس إذا كان فيه قيمة
                            final sizeName = ref
                                    .read(changePriceProvider(
                                            widget.colorsProduct)
                                        .notifier)
                                    .selectedSizeName ??
                                '';
                            if (sizeName.isNotEmpty&&widget.colorsProduct.sizeProduct!.isNotEmpty &&
                            widget.colorsProduct.sizeProduct!.length != 1 ) {
                              ref.read(changePriceProvider(widget.colorsProduct)
                                  .notifier)
                                ..setNameSize('')
                                ..setIdSize(0);
                            }

                            // إعادة تعيين الرقم إذا كان فيه قيمة
                            if (widget
                                .colorsProduct.numbersOfProduct!.isNotEmpty) {
                              final selectedNumber = ref
                                      .read(changePriceProvider(
                                              widget.colorsProduct)
                                          .notifier)
                                      .selectedNumber ??
                                  '';
                              if (selectedNumber.isNotEmpty) {
                                ref.read(
                                    changePriceProvider(widget.colorsProduct)
                                        .notifier)
                                  ..setNumber('')
                                  ..setIdNumber(0);
                              }
                            }
                          },
                          child: Container(
                            height: 34.h,
                            width: 36.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6.r),
                              color: hexToColor(item.colorHex!),
                              boxShadow: selectedIdColor == item.idColor
                                  ? [
                                      BoxShadow(
                                        color: item.image!.isEmpty
                                            ? AppColors.secondaryColor
                                            : hexToColor(item.colorHex!),
                                        spreadRadius: 1,
                                      ),
                                      const BoxShadow(
                                        color: Colors.white,
                                        spreadRadius: 0.5,
                                      ),
                                    ]
                                  : [],
                              border: Border.all(
                                color: AppColors.greySwatch.shade100,
                              ),
                            ),
                            child: item.image!.isEmpty
                                ? const SizedBox.shrink()
                                : OnlineImagesWidget(
                                    imageUrl: item.image![0],
                                    size: Size(36.w, 34.h),
                                    borderRadius: 4.r,
                                  ),
                          ),
                        );
                      },
                    ),
                  );
                },
              )
              .values
              .toList(),
        ),
        10.verticalSpace,
      ],
    );
  }
}

Color hexToColor(String hex) {
  hex = hex.replaceAll('#', '');
  if (hex.length == 6) {
    hex = 'FF$hex';
  }
  return Color(int.parse('0x$hex'));
}
