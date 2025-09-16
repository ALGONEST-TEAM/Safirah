import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../../generated/l10n.dart';

class AddGoodsWidget extends StatelessWidget {
  final int numberOfGoods;

  const AddGoodsWidget({super.key, required this.numberOfGoods});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      margin: EdgeInsets.symmetric(horizontal: 14.w, vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 1.5,
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.primaryColor,
                  radius: 11.sp,
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 15.sp,
                  ),
                ),
                8.w.horizontalSpace,
                Flexible(
                  child: AutoSizeTextWidget(
                    text: S.of(context).addGoods,
                    fontSize: 10.6.sp,
                    colorText: AppColors.greySwatch.shade600,
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          ),
          AutoSizeTextWidget(
            text: "${S.of(context).goods} $numberOfGoods",
            fontSize: 11.sp,
          ),
        ],
      ),
    );
  }
}
