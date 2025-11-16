import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../../core/constants/app_icons.dart';
import '../../../../../../core/helpers/navigateTo.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/buttons/icon_button_widget.dart';
import '../../../../../../core/widgets/text_form_field.dart';
import '../../../../category/presentation/pages/subcategory_product_filter_page.dart';
import '../state_mangment/riverpod.dart';

AppBar appBarSearchWidget({
  required BuildContext context,
  required TextEditingController search,
  required Function(String) onSearchChanged,
  required bool isTypingStarted,
}) {
  return AppBar(
    elevation: 0,
    toolbarHeight: 50,
    automaticallyImplyLeading: false,
    leading: const IconButtonWidget(),
    titleSpacing: 0,
    title: Consumer(
      builder: (context, ref, child) => SizedBox(
        height: 33.h,
        width: double.infinity,
        child: TextFormFieldWidget(
          controller: search,
          autofocus: true,
          borderSide: BorderSide(
            color: AppColors.secondaryColor,
          ),
          onSubmit: (value) {
            navigateTo(
                context,
                SubcategoryProductFilterPage(
                  isSearchPage: true,
                  nameCategoryForHintSearch: value,
                  nameSearch: value,
                ));
            ref.read(searchHistoryProvider.notifier).addSearchHistory(value);
            // clearProductFilters(
            //   context: context,
            //   ref: ref,
            //   categoryId: widget.idCategory,
            // );
          },
          contentPadding:
              EdgeInsets.only(bottom: 10.sp, left: 10.sp, right: 10.sp),
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              isTypingStarted
                  ? InkWell(
                      onTap: () {
                        search.clear();
                        onSearchChanged('');
                      },
                      child: Icon(
                        Icons.close,
                        size: 20.sp,
                        color: AppColors.dangerSwatch.shade400,
                      ),
                    )
                  : const SizedBox.shrink(),
              5.horizontalSpace,
              SvgPicture.asset(
                AppIcons.search,
                color: AppColors.secondaryColor,
                height: 17.5.h,
              ),
              8.w.horizontalSpace,
            ],
          ),
          onChanged: onSearchChanged,
        ),
      ),
    ),
    actions: [
      14.w.horizontalSpace,
    ],
  );
}
