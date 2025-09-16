import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../productManagement/detailsProducts/data/model/product_data.dart';

class ProductsSizesWidget extends StatefulWidget {
  final ProductData data;
  final int sizeId;
  final Function(int, String) onSelect;
  final ValueChanged<int> onCounterChanged;
  dynamic sizeTypeName;

  ProductsSizesWidget({
    super.key,
    required this.data,
    required this.sizeId,
    required this.onSelect,
    required this.onCounterChanged,
    this.sizeTypeName = '',
  });

  @override
  State<ProductsSizesWidget> createState() => _ProductsSizesWidgetState();
}

class _ProductsSizesWidgetState extends State<ProductsSizesWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeTextWidget(
            text:"${S.of(context).size}: ${widget.sizeTypeName.toString()}",
            colorText: AppColors.fontColor,
            fontWeight: FontWeight.w500,
            fontSize: 12.5.sp,
          ),
          8.h.verticalSpace,
          Wrap(
            spacing: 10.0.w,
            runSpacing: 6.0,
            children: widget.data.sizeProduct!.map((items) {
              return InkWell(
                onTap: () => widget.onSelect(items.id!, items.sizeTypeName),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 10.h,
                  ),
                  margin: EdgeInsets.only(bottom: 6.h),
                  decoration: BoxDecoration(
                    color: items.id == widget.sizeId
                        ? AppColors.secondaryColor
                        : Colors.white,
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: AppColors.greySwatch.shade200),
                  ),
                  child: AutoSizeTextWidget(
                    text: items.sizeTypeName.toString(),
                    fontSize: 12.sp,
                    colorText: items.id == widget.sizeId
                        ? AppColors.whiteColor
                        : AppColors.fontColor,
                    fontWeight: items.id == widget.sizeId
                        ? FontWeight.w500
                        : FontWeight.w400,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
