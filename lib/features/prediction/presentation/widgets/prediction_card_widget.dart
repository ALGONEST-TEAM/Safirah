import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:safirah/core/constants/app_icons.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import 'matches_widget.dart';
import 'team_widget.dart';

class PredictionWidget extends StatelessWidget {
  const PredictionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
      itemCount: sections.length,
      itemBuilder: (context, index) {
        final section = sections[index];
        return Padding(
          padding: EdgeInsets.only(top: 6.h),
          child: PredictionCardWidget(section: section),
        );
      },
    );
  }
}

class PredictionCardWidget extends StatefulWidget {
  final MatchSection section;

  const PredictionCardWidget({super.key, required this.section});

  @override
  State<PredictionCardWidget> createState() => _PredictionCardWidgetState();
}

class _PredictionCardWidgetState extends State<PredictionCardWidget> {
  int tempId = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(4.sp),
          child: AutoSizeTextWidget(
            text: widget.section.title,
            fontSize: 10.6.sp,
          ),
        ),
        2.h.verticalSpace,
        Column(
          spacing: 6.h,
          children: List.generate(widget.section.items.length, (i) {
            final item = widget.section.items[i];
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(8.r)),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        tempId = item.id;
                      });
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: tempId == item.id ? 10.w : 6.w,
                              vertical: 3.h),
                          decoration: BoxDecoration(
                            color: const Color(0xffff0c0c),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(8.r),
                              bottomRight: Radius.circular(8.r),
                            ),
                          ),
                          child: Column(
                            spacing: 2.h,
                            children: [
                              Row(
                                spacing: 2.w,
                                children: [
                                  Icon(
                                    Icons.star_rate_rounded,
                                    color: Colors.white,
                                    size: 13.sp,
                                  ),
                                  AutoSizeTextWidget(
                                    text: "4",
                                    fontSize: 9.sp,
                                    colorText: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ],
                              ),
                              Visibility(
                                visible: tempId == item.id,
                                replacement: SvgPicture.asset(
                                  AppIcons.arrowBackEn,
                                  color: Colors.white,
                                  height: 15.h,
                                ),
                                child: AutoSizeTextWidget(
                                  text: "3 - 2",
                                  colorText: Colors.white,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        TeamWidget(
                            name: item.home,
                            image: item.image,
                            alignRight: true),
                        Expanded(
                          child: AutoSizeTextWidget(
                            text: item.time,
                            fontSize: 12.2.sp,
                            fontWeight: FontWeight.w600,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        TeamWidget(
                            name: item.away,
                            image: item.awayImage,
                            alignRight: false),
                      ],
                    ),
                  ),
                  // if (i != widget.section.items.length - 1)
                  //   Divider(
                  //     height: 4.h,
                  //     color: AppColors.fontColor2.withValues(alpha: .14),
                  //   ),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }
}
