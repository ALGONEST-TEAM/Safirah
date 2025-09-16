// import 'package:flutter/material.dart';
//
// import '../../../../../core/constants/app_icons.dart';
// import '../../../../../core/theme/app_colors.dart';
// import '../../../../../core/widgets/buttons/icon_button_widget.dart';
// import '../../../../../core/widgets/text_form_field.dart';
//
// class EnterThePasswordToChangeItWidget extends StatefulWidget {
//   final TextEditingController controller;
//   final String hintText;
//   final String validator;
//
//   const EnterThePasswordToChangeItWidget({
//     super.key,
//     required this.controller,
//     required this.hintText,
//     required this.validator,
//   });
//
//   @override
//   State<EnterThePasswordToChangeItWidget> createState() =>
//       _EnterThePasswordToChangeItWidgetState();
// }
//
// class _EnterThePasswordToChangeItWidgetState
//     extends State<EnterThePasswordToChangeItWidget> {
//   bool isShow = true;
//
//   @override
//   Widget build(BuildContext context) {
//     return TextFormFieldWidget(
//       controller: widget.controller,
//       hintText: widget.hintText,
//       hintTextColor: Colors.black87,
//       isPassword: isShow,
//       suffixIcon: IconButtonWidget(
//         onPressed: () {
//           setState(() {
//             isShow = !isShow;
//           });
//         },
//         icon: isShow ? AppIcons.hidePassword : AppIcons.showPassword,
//         iconColor: AppColors.primaryColor,
//       ),
//       fieldValidator: (value) {
//         if (value == null || value.toString().isEmpty) {
//           return widget.validator;
//         }
//       },
//     );
//   }
// }
