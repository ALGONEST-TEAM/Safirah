import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safirah/core/widgets/auto_size_text_widget.dart';
import 'package:safirah/core/theme/app_colors.dart';

class testpage extends StatefulWidget {
  const testpage({Key? key}) : super(key: key);

  @override
  State<testpage> createState() => _testpageState();
}

class _testpageState extends State<testpage> {
  final List<_RuleItem> _rules = [
    _RuleItem(
      text:
          'عدد اللاعبين: - يتكون كل فريق من 11 لاعبا، بما في ذلك حارس المرمى. - يجب أن يكون لدى الفريق عدد كافٍ من اللاعبين للعب المباراة (عادة ما بين 7 و11 لاعبًا).',
    ),
    _RuleItem(
        text: 'مدة المباراة: - تكون المباراة من شوطين، مدة كل شوط 45 دقيقة.'),
    _RuleItem(
        text:
            'ملعب المباراة: - يجب أن يكون الملعب مستطيلاً، طوله يتراوح بين 90 مترًا و120 مترًا.'),
    _RuleItem(
        text:
            'الكرة: - يجب أن تكون الكرة كروية الشكل وذات محيط يتراوح بين 68 و70 سم.'),
  ];

  final TextEditingController _newRuleController = TextEditingController();

  @override
  void dispose() {
    _newRuleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.h),
          child: AppBar(
            backgroundColor: AppColors.secondaryColor,
            elevation: 0,
            centerTitle: true,
            title: AutoSizeTextWidget(
              text: 'إنشاء الدوري',
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              colorText: AppColors.whiteColor,
              maxLines: 1,
              textAlign: TextAlign.center,
            ),
            // put the arrow on the right side for RTL look
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 12.w),
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.whiteColor,
                  size: 18.w,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: AppColors.scaffoldColor,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 6.h),

                // Rules list container (white card)
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Column(
                    children: [
                      // list of checkable rules
                      for (int i = 0; i < _rules.length; i++) ...[
                        _buildRuleTile(i),
                        SizedBox(height: 8.h),
                      ],

                      SizedBox(height: 8.h),

                      // Additional rule input label
                      Align(
                        alignment: Alignment.centerRight,
                        child: AutoSizeTextWidget(
                          text: 'قواعد اضافية',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          colorText: AppColors.fontColor,
                          maxLines: 1,
                          textAlign: TextAlign.right,
                        ),
                      ),

                      SizedBox(height: 8.h),

                      // Input field for additional rule (no hint text to avoid using Text())
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: AppColors.scaffoldColor,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: TextField(
                          controller: _newRuleController,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.fontColor,
                            fontFamily: 'IBMPlexSansArabic',
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),

                      SizedBox(height: 10.h),

                      // Add rule button
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            final text = _newRuleController.text.trim();
                            if (text.isNotEmpty) {
                              setState(() {
                                _rules.add(_RuleItem(text: text));
                                _newRuleController.clear();
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.whiteColor,
                            foregroundColor: AppColors.primaryColor,
                            elevation: 0,
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.w, vertical: 10.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                              side: BorderSide(color: AppColors.primaryColor),
                            ),
                          ),
                          icon: Icon(Icons.add,
                              color: AppColors.primaryColor, size: 18.w),
                          label: AutoSizeTextWidget(
                            text: 'إضافة قاعدة جديدة',
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            colorText: AppColors.primaryColor,
                            maxLines: 1,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 18.h),

                // Start/End date row (placeholder)
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.calendar_month,
                          color: AppColors.fontColor2, size: 20.w),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            AutoSizeTextWidget(
                              text: 'بداية ونهاية الدوري',
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              colorText: AppColors.fontColor,
                              maxLines: 1,
                              textAlign: TextAlign.right,
                            ),
                            SizedBox(height: 4.h),
                            AutoSizeTextWidget(
                              text:
                                  'السبت، 15 فبراير 2025 - الاحد، 20 فبراير 2025',
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              colorText: AppColors.fontColor2,
                              maxLines: 1,
                              textAlign: TextAlign.right,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 18.h),

                // Create league button
                SizedBox(
                  width: double.infinity,
                  height: 56.h,
                  child: ElevatedButton(
                    onPressed: () {
                      // UI-only: no business logic
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: AutoSizeTextWidget(
                            text: 'إنشاء الدوري (محاكاة واجهة فقط)',
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            colorText: AppColors.whiteColor,
                            maxLines: 1,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r)),
                    ),
                    child: AutoSizeTextWidget(
                      text: 'إنشاء الدوري',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      colorText: AppColors.whiteColor,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),

                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRuleTile(int index) {
    final item = _rules[index];
    return InkWell(
      onTap: () => setState(() => item.checked = !item.checked),
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: AppColors.scaffoldColor,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // checkbox (placed first so in RTL it appears at the right)
            Container(
              width: 26.w,
              height: 26.w,
              decoration: BoxDecoration(
                color: item.checked ? AppColors.primaryColor : AppColors.whiteColor,
                borderRadius: BorderRadius.circular(6.r),
                border: Border.all(color: AppColors.fontColor2),
              ),
              child: item.checked
                  ? Icon(Icons.check, color: AppColors.whiteColor, size: 18.w)
                  : SizedBox.shrink(),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: AutoSizeTextWidget(
                text: item.text,
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
                colorText: AppColors.fontColor,
                maxLines: 5,
                textAlign: TextAlign.right,
              ),
            ),
            SizedBox(width: 8.w),
          ],
        ),
      ),
    );
  }
}

class _RuleItem {
  String text;
  bool checked;

  _RuleItem({required this.text}) : checked = false;
}
