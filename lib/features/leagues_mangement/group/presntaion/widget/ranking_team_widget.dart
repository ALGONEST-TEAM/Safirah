import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safirah/core/widgets/auto_size_text_widget.dart';

import '../../data/model/model.dart';

class RankingTeamWidget extends StatelessWidget {
  const RankingTeamWidget({
    super.key,
    required this.groupName,
    required this.rows, // مرتبة مسبقًا
    this.topQualifiers = 2, // شريط أخضر للأوائل
  });

  final String groupName;
  final List<QualifiedTeamModel> rows;
  final int topQualifiers;

  String _signed(int v) => v > 0 ? '+$v' : v.toString();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: Colors.white,
      ),
      child: Column(
        children: [
          // رأس الجدول
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 8.h),
            child: Row(
              children: [
                Expanded(
                  child: AutoSizeTextWidget(
                    text: 'مجموعة $groupName',
                    textAlign: TextAlign.right,
                    fontSize: 12.sp,
                  ),
                ),
                _headCell(context, 'لعب'),
                _headCell(context, '-/+'),
                _headCell(context, 'فارق'),
                _headCell(context, 'نقاط'),
              ],
            ),
          ),
          const Divider(
            height: 0.7,
            thickness: 0.5,
            color: Color(0xffF3F1FB),
          ),

          // الصفوف
          ...List.generate(rows.length, (i) {
            final qt = rows[i];
            final rank = i + 1;
            final gd = qt.goalsFor - qt.goalsAgainst;

            return Column(
              children: [
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 32.w,
                        child: Row(
                          children: [
                            Container(
                              width: 3,
                              height: 14,
                              color: rank <= topQualifiers
                                  ? Colors.green
                                  : Colors.transparent,
                            ),
                            const SizedBox(width: 6),
                            AutoSizeTextWidget(
                              text: '$rank',
                              fontSize: 11.sp,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: AutoSizeTextWidget(
                          text: qt.teamName ?? '#${qt.teamId}',
                          textAlign: TextAlign.right,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      _dataCell('${qt.played}'),
                      _dataCell('${qt.goalsFor}:${qt.goalsAgainst}'),
                      _dataCell(_signed(gd)),
                      _dataCell('${qt.points}'),
                    ],
                  ),
                ),
                i != rows.length - 1
                    ? const Divider(
                  height: 0.7,
                  thickness: 0.5,
                  color: Color(0xffF3F1FB),
                )
                    : const SizedBox(),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _headCell(BuildContext ctx, String text) => SizedBox(
    width: 35.w,
    child: AutoSizeTextWidget(
      text: text,
      textAlign: TextAlign.center,
      fontSize: 11.sp,
    ),
  );

  Widget _dataCell(String text) => SizedBox(
    width: 35.w,
    child: AutoSizeTextWidget(
      text: text,
      textAlign: TextAlign.center,
      fontSize: 11.sp,
    ),
  );
}
