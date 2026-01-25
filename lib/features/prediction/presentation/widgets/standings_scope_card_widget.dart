import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/app_icons.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../core/widgets/show_modal_bottom_sheet_widget.dart';
import '../../../../generated/l10n.dart';
import 'standings_sort_widget.dart';

class StandingsScopeCardWidget extends StatelessWidget {
  final String scope;

  const StandingsScopeCardWidget({
    super.key,
    required this.scope,
  });

  String _scopeLabel(BuildContext context, String scope) {
    switch (scope) {
      case 'week':
        return S.of(context).weekly;
      case 'month':
        return S.of(context).monthly;
      case 'season':
        return S.of(context).season;
      default:
        return S.of(context).weekly;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        scrollShowModalBottomSheetWidget(
          context: context,
          title: S.of(context).title,
          page: const StandingsSortWidget(),
        );
      },
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        elevation: 0,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AutoSizeTextWidget(
                text: _scopeLabel(context, scope),
                fontSize: 13.sp,
                colorText: AppColors.fontColor,
              ),
              SvgPicture.asset(
                AppIcons.arrowBottom,
                color: AppColors.secondaryColor,
                height: 18.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
