// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../../../../../core/state/check_state_in_post_api_data_widget.dart';
// import '../../../../../core/state/state.dart';
// import '../../../../../core/theme/app_colors.dart';
// import '../../../../../core/widgets/auto_size_text_widget.dart';
// import '../../../../../core/widgets/bottomNavbar/button_bottom_navigation_bar_design_widget.dart';
// import '../../../../../core/widgets/buttons/default_button.dart';
// import '../../../../../core/widgets/secondary_app_bar_widget.dart';
// import '../../../../../generated/l10n.dart';
// import '../../../../user/presentation/widgets/conditions_for_input_the_password_widget.dart';
// import '../../../settings/presentation/riverpod/setting_riverpod.dart';
// import '../widgets/enter_the_password_to_change_it_widget.dart';
//
// class ChangePasswordPage extends StatefulWidget {
//   const ChangePasswordPage({super.key});
//
//   @override
//   State<ChangePasswordPage> createState() => _ChangePasswordPageState();
// }
//
// class _ChangePasswordPageState extends State<ChangePasswordPage> {
//   bool isPasswordValid = false;
//   bool passwordDoNotMatch = false;
//
//   TextEditingController newPasswordController = TextEditingController();
//   TextEditingController confirmPasswordController = TextEditingController();
//   TextEditingController oldPasswordController = TextEditingController();
//   final formKey = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.white,
//         appBar: SecondaryAppBarWidget(
//           title: S.of(context).changePassword,
//           centerTitle: false,
//         ),
//         body: Form(
//           key: formKey,
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 18.h.verticalSpace,
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 12.w),
//                   child: EnterThePasswordToChangeItWidget(
//                     controller: oldPasswordController,
//                     hintText: S.of(context).oldPassword,
//                     validator: S.of(context).pleaseEnterOldPassword,
//                   ),
//                 ),
//
//                 3.h.verticalSpace,
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 12.w),
//                   child: ConditionsForInputThePasswordWidget(
//                     passwordController: newPasswordController,
//                     hintText: S.of(context).newPassword,
//                     borderSide: BorderSide.none,
//                     fontSize: 10.sp,
//                     onValidationChanged: (isValid) {
//                       setState(() {
//                         isPasswordValid = isValid;
//                       });
//                     },
//                   ),
//                 ),
//
//                 4.h.verticalSpace,
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 12.w),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       EnterThePasswordToChangeItWidget(
//                         controller: confirmPasswordController,
//                         hintText: S.of(context).confirmPassword,
//                         validator: S.of(context).pleaseConfirmYourPassword,
//                       ),
//                       Visibility(
//                         visible: passwordDoNotMatch,
//                         child: AutoSizeTextWidget(
//                           text: S.of(context).passwordDoNotMatch,
//                           fontSize: 11.sp,
//                           colorText: AppColors.secondarySwatch.shade500,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         bottomNavigationBar: Consumer(
//           builder: (context, ref, child) {
//             var state = ref.watch(manageMyAccountProvider);
//             return CheckStateInPostApiDataWidget(
//               state: state,
//               functionSuccess: () => Navigator.of(context).pop(),
//               bottonWidget: ButtonBottomNavigationBarDesignWidget(
//                 child: DefaultButtonWidget(
//                   text: S.of(context).changePassword,
//                   textSize: 13.2.sp,
//                   height: 41.h,
//                   isLoading: state.stateData == States.loading,
//                   onPressed: isPasswordValid
//                       ? () {
//                           final isValid = formKey.currentState!.validate();
//
//                           if (isValid) {
//                             if (newPasswordController.text !=
//                                 confirmPasswordController.text) {
//                               setState(() {
//                                 passwordDoNotMatch = true;
//                               });
//
//                             } else {
//                               setState(() {
//                                 passwordDoNotMatch = false;
//                               });
//                               FocusManager.instance.primaryFocus?.unfocus();
//                               ref
//                                   .read(manageMyAccountProvider.notifier)
//                                   .changePassword(
//                                     oldPassword: oldPasswordController.text,
//                                     newPassword: newPasswordController.text,
//                                     confirmPassword:
//                                         confirmPasswordController.text,
//                                   );
//                             }
//                           }
//                         }
//                       : null,
//                 ),
//               ),
//             );
//           },
//         ));
//   }
// }
