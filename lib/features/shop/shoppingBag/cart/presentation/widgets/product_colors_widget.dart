import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safirah/core/extension/string.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../productManagement/detailsProducts/data/model/color_data.dart';

class ProductColorsWidget extends StatelessWidget {
  final List<ColorOfProductData> productsColors;
  final int colorId;
  String colorName;
  final Function(int, int, String) onSelect;

  ProductColorsWidget({
    super.key,
    required this.productsColors,
    required this.colorId,
    required this.onSelect,
    this.colorName = '',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: AutoSizeTextWidget(
            text: "${S.of(context).colors}: $colorName ",
            colorText: AppColors.fontColor,
            fontWeight: FontWeight.w500,
            fontSize: 12.5.sp,
          ),
        ),
        8.h.verticalSpace,
        SizedBox(
          height: 28.h,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            itemCount: productsColors.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () => onSelect(
                  productsColors[index].idColor!,
                  index,
                  productsColors[index].colorName!,
                ),
                child: Row(
                  children: [
                    Container(
                      width: 32.w,
                      decoration: BoxDecoration(
                        color: productsColors[index].colorHex!.toColor(),
                        borderRadius: BorderRadius.circular(6.r),
                        boxShadow: productsColors[index].idColor == colorId
                            ? [
                                BoxShadow(
                                  color: AppColors.secondaryColor,
                                  spreadRadius: 1.5,
                                ),
                                const BoxShadow(
                                  color: Colors.white,
                                  spreadRadius: 1.0,
                                ),
                              ]
                            : [],
                      ),
                    ),
                    10.w.horizontalSpace,
                  ],
                ),
              );
            },
          ),
        ),
        8.h.verticalSpace,
      ],
    );
  }
}
