// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../../../../../core/state/check_state_in_get_api_data_widget.dart';
// import '../../../../../core/theme/app_colors.dart';
// import '../../../../../core/widgets/auto_size_text_widget.dart';
// import '../../data/model/team_model.dart';
// import '../state_mangment/riverpod.dart';
//
// class CategoryDropdownFieldWidget extends ConsumerWidget {
//   const CategoryDropdownFieldWidget({
//     super.key,
//     required this.leagueId,
//     this.value,
//     this.onChanged,
//     this.hintText,
//     this.validator,
//     this.enabled = true,
//   });
//
//   final int leagueId;
//   final TeamPlayerCategoryModel? value;
//   final ValueChanged<TeamPlayerCategoryModel?>? onChanged;
//   final String? hintText;
//   final FormFieldValidator<TeamPlayerCategoryModel?>? validator;
//   final bool enabled;
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final state = ref.watch(categoriesProvider(leagueId));
//     final selectedId = value?.id;
//
//     return CheckStateInGetApiDataWidget(
//       state: state,
//       widgetOfData: Container(
//         padding: const EdgeInsets.all(12),
//
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(12.r),
//           color: Colors.white,
//
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             AutoSizeTextWidget(text: 'تحديد الفئة'),
//             4.h.verticalSpace,
//             Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10.r),
//                 color:AppColors.scaffoldColor,
//
//               ),
//               padding: EdgeInsets.all(10.w),
//               child: DropdownButtonFormField<int>(
//                 dropdownColor: Colors.white,
//                 value: selectedId != null && state.data.any((e) => e.id == selectedId) ? selectedId : null,
//                 items: state.data
//                     .map((e) => DropdownMenuItem<int>(
//                   value: e.id!,
//                   child: Text(e.name),
//                 ))
//                     .toList(),
//                 onChanged: !enabled
//                     ? null
//                     : (id) {
//                   final picked = state.data.firstWhere((e) => e.id == id, orElse: () => state.data.first);
//                   onChanged?.call(picked);
//                 },
//                 validator: validator == null
//                     ? null
//                     : (id) {
//                   final picked = id == null ? null : state.data.firstWhere((e) => e.id == id, orElse: () => state.data.first);
//                   return validator!(picked);
//                 },
//                 hint: AutoSizeTextWidget(text: 'اسم الفئة',colorText: AppColors.fontColor2,fontSize: 13.sp,),
//                 decoration: InputDecoration(
//
//                   //hintText: hintText ?? 'اسم الفئة',
//                   border: InputBorder.none,
//                   isDense: true,
//                 ),
//                 isExpanded: true,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// category_dropdown_field_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../../data/model/team_model.dart';
import '../state_mangment/riverpod.dart';
import 'label_drop_down_widget.dart';

class CategoryDropdownFieldWidget extends ConsumerWidget {
  const CategoryDropdownFieldWidget({
    super.key,
    required this.leagueId,
    this.value,
    this.onChanged,
    this.validator,
    this.enabled = true,
    this.hintText,
  });

  final int leagueId;
  final TeamPlayerCategoryModel? value;
  final ValueChanged<TeamPlayerCategoryModel?>? onChanged;
  final String? Function(TeamPlayerCategoryModel?)? validator;
  final bool enabled;
  final String? hintText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(categoriesProvider(leagueId));
    return CheckStateInGetApiDataWidget(
      state: state,
      widgetOfData: LabeledDropdownField<TeamPlayerCategoryModel>(
        title: 'تحديد الفئة',
        items: state.data,
        idOf: (c) => c.id,
        labelOf: (c) => c.name,
        selectedId: value?.id,
        onChanged: onChanged,
        validator: validator,
        hintText: hintText ?? 'اسم الفئة',
        enabled: enabled,
      ),
    );
  }
}
