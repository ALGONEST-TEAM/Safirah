// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import '../../../../core/constants/app_icons.dart';
// import '../../../../core/widgets/auto_size_text_widget.dart';
// import '../../../../generated/l10n.dart';
//
// class ExclusiveDiscountAndBenefitsWidget extends StatelessWidget {
//   const ExclusiveDiscountAndBenefitsWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(4.sp),
//       color: const Color(0xfff7eccb),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           Column(
//             children: [
//               SvgPicture.asset(
//                 AppIcons.discount,
//                 height: 18.h,
//               ),
//               2.h.verticalSpace,
//               AutoSizeTextWidget(
//                 text: S.of(context).discount,
//                 fontSize: 8.sp,
//                 maxLines: 2,
//                 textAlign: TextAlign.center,
//                 fontWeight: FontWeight.w600,
//               ),
//             ],
//           ),
//           Column(
//             children: [
//               SvgPicture.asset(
//                 AppIcons.j,
//                 height: 17.h,
//               ),
//               2.h.verticalSpace,
//               AutoSizeTextWidget(
//                 text: S.of(context).exclusiveBenefits,
//                 fontSize: 8.sp,
//                 maxLines: 2,
//                 textAlign: TextAlign.center,
//                 fontWeight: FontWeight.w600,
//               ),
//
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
