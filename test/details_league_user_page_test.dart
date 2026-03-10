// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../../../../../../../core/theme/app_colors.dart';
// import '../../../../../../../core/widgets/auto_size_text_widget.dart';
//
// class LeagueHeaderAdBanner extends StatelessWidget {
//   const LeagueHeaderAdBanner({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(12.r),
//       child: Container(
//         height: 68.h,
//         width: double.infinity,
//         color: AppColors.secondarySwatch.shade50,
//         child: Stack(
//           children: [
//             Positioned.fill(
//               child: DecoratedBox(
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     begin: Alignment.centerLeft,
//                     end: Alignment.centerRight,
//                     colors: [
//                       AppColors.secondarySwatch.shade50,
//                       AppColors.primarySwatch.shade50,
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         AutoSizeTextWidget(
//                           text: '',
//                           fontSize: 10.sp,
//                           fontWeight: FontWeight.w600,
//                           colorText: AppColors.fontColor2,
//                         ),
//                         2.h.verticalSpace,
//                         AutoSizeTextWidget(
//                           text: '   ',
//                           fontSize: 12.sp,
//                           fontWeight: FontWeight.w700,
//                           colorText: AppColors.mainColorFont,
//                           maxLines: 1,
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     height: 42.h,
//                     width: 54.w,
//                     decoration: BoxDecoration(
//                       color: AppColors.whiteColor.withValues(alpha: 0.85),
//                       borderRadius: BorderRadius.circular(10.r),
//                     ),
//                     child: Center(
//                       child: AutoSizeTextWidget(
//                         text: '50%',
//                         fontSize: 18.sp,
//                         fontWeight: FontWeight.w800,
//                         colorText: AppColors.primaryColor,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
