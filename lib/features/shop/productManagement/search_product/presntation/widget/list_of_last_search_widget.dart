import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/helpers/navigateTo.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../category/presentation/pages/subcategory_product_filter_page.dart';
import '../state_mangment/riverpod.dart';

class ListOfLastSearchWidget extends ConsumerWidget {
  const ListOfLastSearchWidget(
      {super.key, required this.isDeleteMode, required this.historySearch});

  final List<String> historySearch;
  final bool isDeleteMode;

  @override
  Widget build(BuildContext context, ref) {
    return Wrap(
      spacing: 6.0.w,
      runSpacing: 6.0.h,
      children: historySearch
          .map(
            (item) => isDeleteMode
                ? InkWell(
                    onTap: () {
                      ref
                          .read(searchHistoryProvider.notifier)
                          .deleteSearchItem(item);
                    },
                    child: Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(4.6.sp),
                          child: Icon(
                            Icons.close,
                            size: 11.r,
                            color: AppColors.dangerColor,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.sp, vertical: 10.sp),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14.r),
                            border: Border.all(color: const Color(0xffE1E1E1)),
                          ),
                          child: AutoSizeTextWidget(
                            text: item,
                            colorText: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  )
                : InkWell(
                    onTap: () {
                      navigateTo(
                        context,
                        SubcategoryProductFilterPage(
                          isSearchPage: true,
                          nameCategoryForHintSearch: item,
                          nameSearch: item,
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 12.sp, vertical: 10.sp),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14.r),
                        border: Border.all(color: const Color(0xffE1E1E1)),
                      ),
                      child: AutoSizeTextWidget(
                        text: item,
                        colorText: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                  ),
          )
          .toList(),
    );
  }
}
