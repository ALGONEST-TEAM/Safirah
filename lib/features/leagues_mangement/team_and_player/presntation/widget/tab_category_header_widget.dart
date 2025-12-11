import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safirah/core/widgets/auto_size_text_widget.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../data/model/team_model.dart';

class TabsCategoryHeaderWidget extends StatefulWidget {
  const TabsCategoryHeaderWidget(
      {super.key,
      required this.leagueId,
      required this.categories,
      required this.controller});

  final TabController controller;

  final int leagueId;
  final List<TeamPlayerCategoryModel> categories;

  @override
  State<TabsCategoryHeaderWidget> createState() =>
      _TabsCategoryHeaderWidgetState();
}

class _TabsCategoryHeaderWidgetState extends State<TabsCategoryHeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0.h),
      child: AnimatedBuilder(
        animation: widget.controller.animation!,
        builder: (_, __) {
          final anim = widget.controller.animation!;
          return TabBar(
            controller: widget.controller,
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            dividerColor: Colors.transparent,
            indicator: const BoxDecoration(),
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: List.generate(widget.categories.length, (i) {
              // t بين 0 و1 تمثل قرب المؤشر من هذا التبويب
              final t = (1 - (anim.value - i).abs()).clamp(0.0, 1.0);
              final bg = Color.lerp(Colors.white, AppColors.primaryColor,
                  Curves.easeOut.transform(t))!;
              final fg = t > 0.5 ? Colors.white : AppColors.secondaryColor;

              return Tab(
                child: Container(
                 height: 30.h,
                  width: 50.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: bg,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: AutoSizeTextWidget(
                   text:  widget.categories[i].name ?? '',
                    maxLines: 1,
                  colorText: fg,
                  ),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
