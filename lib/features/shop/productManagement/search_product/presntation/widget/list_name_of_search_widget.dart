import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../../core/constants/app_icons.dart';
import '../../../../../../core/helpers/navigateTo.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../category/presentation/pages/subcategory_product_filter_page.dart';
import '../../data/model/search_data.dart';
import '../state_mangment/riverpod.dart';

class ListNameOfSearchWidget extends ConsumerWidget {
  const ListNameOfSearchWidget({super.key, required this.namesSearch});

  final List<SearchData> namesSearch;

  @override
  Widget build(BuildContext context, ref) {
    return ListView.separated(
      itemBuilder: (context, index) => InkWell(
        onTap: () {
          navigateTo(
              context,
              SubcategoryProductFilterPage(
                isSearchPage: true,
                nameCategoryForHintSearch: namesSearch[index].name!,
                nameSearch: namesSearch[index].name!,
              ));
          ref
              .read(searchHistoryProvider.notifier)
              .addSearchHistory(namesSearch[index].name!);
        },
        child: Padding(
          padding: EdgeInsets.all(2.0.sp),
          child: Row(
            children: [
              SvgPicture.asset(
                AppIcons.search,
                color: AppColors.secondaryColor,
                height: 16.h,
              ),
              8.horizontalSpace,
              AutoSizeTextWidget(
                text: namesSearch[index].name!,
                colorText: AppColors.mainColorFont,
                fontSize: 13.4.sp,
              )
            ],
          ),
        ),
      ),
      separatorBuilder: (context, index) => const Divider(
        color: AppColors.fontColor2,
        thickness: 0.1,
      ),
      itemCount: namesSearch.length,
    );
  }
}
