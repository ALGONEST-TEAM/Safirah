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
// class TeamDropdownFieldWidget extends ConsumerWidget {
//   const TeamDropdownFieldWidget({
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
//   final TeamModel? value;
//   final ValueChanged<TeamModel?>? onChanged;
//   final String? hintText;
//   final FormFieldValidator<TeamModel?>? validator;
//   final bool enabled;
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final state = ref.watch(teamsProvider(leagueId));
//     final selectedId = value?.id;
//
//     return CheckStateInGetApiDataWidget(
//       state: state,
//       widgetOfData: Container(
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(12.r),
//           color: Colors.white,
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const AutoSizeTextWidget(text: 'تحديد الفريق'),
//             4.h.verticalSpace,
//             Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10.r),
//                 color: AppColors.scaffoldColor,
//               ),
//               padding: EdgeInsets.all(10.w),
//               child: DropdownButtonFormField<int>(
//                 dropdownColor: Colors.white,
//                 value: selectedId != null &&
//                     state.data.any((e) => e.id == selectedId)
//                     ? selectedId
//                     : null,
//                 items: state.data
//                     .map((e) => DropdownMenuItem<int>(
//                   value: e.id!,
//                   child: Text(e.teamName),
//                 ))
//                     .toList(),
//                 onChanged: !enabled
//                     ? null
//                     : (id) {
//                   final picked = id == null
//                       ? null
//                       : state.data.firstWhere(
//                         (e) => e.id == id,
//                     orElse: () => state.data.first,
//                   );
//                   onChanged?.call(picked);
//                 },
//                 validator: validator == null
//                     ? null
//                     : (id) {
//                   final picked = id == null
//                       ? null
//                       : state.data.firstWhere(
//                         (e) => e.id == id,
//                     orElse: () => state.data.first,
//                   );
//                   return validator!(picked);
//                 },
//                 hint: AutoSizeTextWidget(
//                   text: hintText ?? 'اسم الفريق',
//                   colorText: AppColors.fontColor2,
//                   fontSize: 13.sp,
//                 ),
//                 decoration: const InputDecoration(
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
// team_dropdown_field_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../../data/model/team_model.dart';
import '../state_mangment/riverpod.dart';
import 'label_drop_down_widget.dart';

class TeamDropdownFieldWidget extends ConsumerWidget {
  const TeamDropdownFieldWidget({
    super.key,
    required this.leagueId,
    this.value,
    this.onChanged,
    this.validator,
    this.enabled = true,
    this.hintText,
  });

  final int leagueId;
  final TeamModel? value;
  final ValueChanged<TeamModel?>? onChanged;
  final String? Function(TeamModel?)? validator;
  final bool enabled;
  final String? hintText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(teamsProvider(leagueId));
    final selectedId = value?.id;

    return CheckStateInGetApiDataWidget(
      state: state,
      widgetOfData: LabeledDropdownField<TeamModel>(
        title: 'تحديد الفريق',
        items: state.data,
        idOf: (t) => t.id,
        labelOf: (t) => t.teamName,
        selectedId: selectedId,
        onChanged: onChanged,
        validator: validator,
        hintText: hintText ?? 'اسم الفريق',
        enabled: enabled,
      ),
    );
  }
}
