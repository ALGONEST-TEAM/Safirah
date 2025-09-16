// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import '../../../../core/constants/app_icons.dart';
// import '../../../../core/helpers/navigateTo.dart';
// import '../../../../core/theme/app_colors.dart';
// import '../../../../core/widgets/auto_size_text_widget.dart';
// import '../../../../core/widgets/bottomNavbar/bottom_navigation_bar_widget.dart';
// import '../../../../generated/l10n.dart';
//
// class ContinueWithGoogleOrFacebookWidget extends StatefulWidget {
//   const ContinueWithGoogleOrFacebookWidget({super.key});
//
//   @override
//   State<ContinueWithGoogleOrFacebookWidget> createState() =>
//       _ContinueWithGoogleOrFacebookWidgetState();
// }
// class _ContinueWithGoogleOrFacebookWidgetState
//     extends State<ContinueWithGoogleOrFacebookWidget> {
//   final GoogleSignIn _googleSignIn = GoogleSignIn();
//   GoogleSignInAccount? _user;
//
//
//
//   // دالة لتسجيل الخروج
//   Future<void> _signOut() async {
//     await _googleSignIn.signOut();
//     setState(() {
//       _user = null;
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               height: 0.8.h,
//               width: 120.w,
//               color: AppColors.greySwatch.shade300,
//             ),
//             14.w.horizontalSpace,
//             AutoSizeTextWidget(
//               text: S.of(context).or,
//               fontSize: 12.5.sp,
//               colorText: AppColors.fontColor,
//             ),
//             14.w.horizontalSpace,
//             Container(
//               height: 0.8.h,
//               width: 120.w,
//               color: AppColors.greySwatch.shade300,
//             ),
//           ],
//         ),
//         18.h.verticalSpace,
//         ContinueWidget(
//           title: S.of(context).continueWithGoogle,
//           icon: AppIcons.continueToGoogle,
//           onTap: () {
//            // SignService.signInWithGoogle(context);
//             _signIn(context);
//           },
//         ),
//         8.h.verticalSpace,
//         ContinueWidget(
//           title: S.of(context).continueWithFacebook,
//           icon: AppIcons.continueToFacebook,
//           onTap: () {},
//         ),
//       ],
//     );
//   }
// }
//
// class ContinueWidget extends StatelessWidget {
//   final String title;
//   final String icon;
//   final VoidCallback onTap;
//
//   const ContinueWidget({
//     super.key,
//     required this.title,
//     required this.icon,
//     required this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       child: Container(
//         padding: EdgeInsets.all(9.sp),
//         decoration: BoxDecoration(
//           border: Border.all(
//             color: Colors.black26,
//             width: 0.5,
//           ),
//           borderRadius: BorderRadius.circular(2.r),
//         ),
//         child: Row(
//           // mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             14.w.horizontalSpace,
//             SizedBox(
//               width: 64.w,
//               child: SvgPicture.asset(
//                 icon,
//                 height: 23.h,
//               ),
//             ),
//             14.w.horizontalSpace,
//             Flexible(
//               child: AutoSizeTextWidget(
//                 text: title,
//                 fontWeight: FontWeight.w600,
//                 fontSize: 11.sp,
//                 textAlign: TextAlign.center,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// void _signIn(BuildContext context) async {
//   final user = await SignService().signInWithGoogle();
//   if (user != null) {
//     navigateAndFinish(
//       context,
//       const BottomNavigationBarWidget(),
//     );
//   }
//  // signInWithGoogle();
// }