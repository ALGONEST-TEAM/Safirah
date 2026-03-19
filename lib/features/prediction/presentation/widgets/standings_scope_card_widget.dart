import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../core/widgets/show_modal_bottom_sheet_widget.dart';
import '../../../../generated/l10n.dart';
import '../../data/model/standings_model.dart';
import '../riverpod/prediction_riverpod.dart';
import 'standings_sort_widget.dart';

class StandingsScopeCardWidget extends ConsumerWidget {
  final List<RankingPeriods> scopes;

  const StandingsScopeCardWidget({
    super.key,
    required this.scopes,
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
  Widget build(BuildContext context,ref) {
    final scope = ref.watch(standingsScopeProvider);

    return InkWell(
      onTap: (){
        scrollShowModalBottomSheetWidget(
          context: context,
          title: S.of(context).title,
          page: StandingsSortWidget(
            scopes: scopes,
          ),
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
                text: _scopeLabel(context, scope??scopes[0].name),
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
