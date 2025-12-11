// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:safirah/core/widgets/auto_size_text_widget.dart';
// import 'package:safirah/core/widgets/text_form_field.dart';
//
// import 'date_pickers.dart';
//
// class LeagueDatesWidget extends StatelessWidget {
//   const LeagueDatesWidget({
//     super.key,
//     required this.dateStartCtrl,
//     required this.dateEndCtrl,
//
//   });
//
//   final TextEditingController dateStartCtrl;
//   final TextEditingController dateEndCtrl;
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.white,
//       padding: EdgeInsets.all(8.w),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           AutoSizeTextWidget(text: 'تاريخ بداية الدوري', fontSize: 10.sp),
//           6.h.verticalSpace,
//           InkWell(
//             onTap: () => DatePickers.bindToController(context, dateStartCtrl),
//             child: IgnorePointer(
//               child: TextFormFieldWidget(
//                 controller: dateStartCtrl,
//                 type: TextInputType.number,
//                 fillColor: const Color(0xffF6F7F9),
//                 suffixIcon: const Icon(Icons.date_range),
//               ),
//             ),
//           ),
//           6.h.verticalSpace,
//           AutoSizeTextWidget(text: 'تاريخ نهاية الدوري', fontSize: 10.sp),
//           6.h.verticalSpace,
//           InkWell(
//             onTap: () => DatePickers.bindToController(context, dateEndCtrl),
//             child: IgnorePointer(
//               child: TextFormFieldWidget(
//                 controller: dateEndCtrl,
//                 type: TextInputType.number,
//                 fillColor: const Color(0xffF6F7F9),
//                 suffixIcon: const Icon(Icons.date_range),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
