import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../data/model/section_data.dart';


class TabBarSubSectionWidget extends StatefulWidget {
  const TabBarSubSectionWidget({super.key,required this.sections});

  final List<SectionData> sections;

  @override
  State<TabBarSubSectionWidget> createState() => _TabBarSubSectionWidgetState();

}

class _TabBarSubSectionWidgetState extends State<TabBarSubSectionWidget> with TickerProviderStateMixin {
  late TabController subTabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    subTabController = TabController(
      length:widget.sections.length,
      vsync: this,
    );
  }
  @override
  void dispose() {

    subTabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 360,
      child: Column(
        children: [
          Container(
            height: 40.h,
            color: Colors.white,
            padding: EdgeInsets.symmetric(
                vertical: 2.sp, horizontal: 8.w),
            child: TabBar(
              controller: subTabController,
              unselectedLabelColor: Colors.black,
              labelColor: AppColors.primaryColor ,
              indicator:  UnderlineTabIndicator(
                borderSide: BorderSide(
                  width: 0.8.w,
                  color: AppColors.primaryColor,
                ),
                insets:
               const EdgeInsets.symmetric(vertical: 10),
              ),
              dividerHeight: 0.001,
              tabAlignment: TabAlignment.center,
              labelStyle: TextStyle(
                fontSize: 13.sp,
                fontFamily: 'NotoKufi',

              ),
              isScrollable: true,
              tabs: [
                for (var subCategory
                in widget.sections)
                  Tab(text: subCategory.name,),
              ],
            ),
          ),
          // Expanded(
          //   child: TabBarView(
          //     controller: subTabController,
          //     children:
          //     widget.sections.map((subSection) {
          //       return ListToDisplayCategoriesOnTheHomeWidget(
          //         category: subSection.category,
          //       );
          //     }).toList(),
          //   ),
          // ),
        ],
      ),
    );
  }
}
