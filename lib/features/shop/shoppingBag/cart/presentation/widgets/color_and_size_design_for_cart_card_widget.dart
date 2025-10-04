import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safirah/core/extension/string.dart';
import '../../../../../../core/constants/app_icons.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../../core/widgets/show_modal_bottom_sheet_widget.dart';
import '../../../../../../generated/l10n.dart';
import '../pages/update_cart_page.dart';

class ColorAndSizeDesignForCartCardWidget extends StatelessWidget {
  final int id;
  final int productId;
  final int? sizeId;
  final int? colorId;
  final String colorHex;
  final String colorName;
  final String sizeName;
  final int? numberId;
  final String? numberName;
  final int quantity;
  final Function onSuccess;
  final int isPrintable;

  const ColorAndSizeDesignForCartCardWidget({
    super.key,
    required this.productId,
    this.sizeId,
    this.colorId,
    required this.colorHex,
    required this.colorName,
    required this.sizeName,
    required this.id,
    this.numberId,
    this.numberName,
    required this.quantity,
    required this.onSuccess,
    required this.isPrintable,
  });

  @override
  Widget build(BuildContext context) {
    final parts = <String>[];
    if (colorName.isNotEmpty) parts.add(colorName);
    if (sizeName.isNotEmpty) parts.add(sizeName);
    final numLabel = S.of(context).number;
    if ((numberName ?? '').isNotEmpty) parts.add('$numLabel $numberName');
    return InkWell(
      onTap: () {
        showModalBottomSheetWidget(
          backgroundColor: Colors.transparent,
          context: context,
          page: UpdateCartPage(
            id: id,
            productId: productId,
            quantity: quantity,
            onSuccess: onSuccess,
            sizeId: sizeId,
            colorId: colorId,
            sizeTypeName: sizeName,
            colorName: colorName,
            numberId: numberId,
            numberName: numberName,
            isPrintable: isPrintable,
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 6.w,
          vertical: 1.6.h,
        ),
        decoration: BoxDecoration(
          color: AppColors.scaffoldColor,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if(            colorHex.isNotEmpty)
            Container(
              height: 9.6.h,
              width: 9.6.w,
              decoration: BoxDecoration(
                color: colorHex.toString().toColor(),
                borderRadius: BorderRadius.circular(2.6.r),
              ),
            ),
            3.4.w.horizontalSpace,
            Flexible(
              child: AutoSizeTextWidget(
                text: parts.join(' / '),
                colorText: AppColors.fontColor,
                fontSize: 9.2.sp,
                maxLines: 2,
              ),
            ),
            4.w.horizontalSpace,
            SvgPicture.asset(
              AppIcons.arrowBottom2,
              color: AppColors.fontColor,
              height: 9.h,
            ),
          ],
        ),
      ),
    );
  }
}
