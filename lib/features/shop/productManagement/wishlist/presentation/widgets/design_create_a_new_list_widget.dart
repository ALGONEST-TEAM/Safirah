import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../../core/widgets/show_modal_bottom_sheet_widget.dart';
import '../../../../../../generated/l10n.dart';
import 'create_a_new_list_dialog_widget.dart';

class DesignCreateANewListWidget extends StatelessWidget {
  final String? title;
  final Color? colorTitle;
  final double? fontSize;
  final Color? backgroundColor;
  final Color? addIconColor;
  final double? horizontal;
  final double? vertical;
  final bool navigator;
  final bool navigateToProductSelectionPage;

  const DesignCreateANewListWidget({
    super.key,
    this.title,
    this.backgroundColor,
    this.addIconColor,
    this.horizontal,
    this.vertical,
    this.colorTitle,
    this.fontSize,
    this.navigator = true,
    this.navigateToProductSelectionPage = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (navigator) {
          Navigator.of(context).pop();
        }
        showModalBottomSheetWidget(
          context: context,
          page: CreateANewListDialogWidget(
            navigateToProductSelectionPage: navigateToProductSelectionPage,
          ),
        );
      },
      child: Container(
        color: Colors.transparent,
        margin: EdgeInsets.symmetric(
          horizontal: horizontal ?? 14.w,
          vertical: vertical ?? 16.h,
        ),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.12),
                    spreadRadius: 1,
                    blurRadius: 1,
                  ),
                ],
              ),
              child: CircleAvatar(
                backgroundColor: backgroundColor ?? Colors.white,
                radius: 17.4.sp,
                child: Icon(
                  Icons.add,
                  color: addIconColor ?? Colors.black,
                ),
              ),
            ),
            8.w.horizontalSpace,
            AutoSizeTextWidget(
              text: title ?? S.of(context).createANewList,
              fontSize: fontSize ?? 10.8.sp,
              colorText: colorTitle ?? Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
