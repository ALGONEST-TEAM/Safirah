// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../../../../../../core/theme/app_colors.dart';
// import '../../../../../../core/widgets/auto_size_text_widget.dart';
// import '../../../../../../core/widgets/price_and_currency_widget.dart';
//
// class OrderDetailsCardDataDesignWidget extends StatelessWidget {
//   final String title;
//   final String subTitle;
//   final Color? color;
//   final bool isColor;
//   final bool isPrice;
//   final Color? colorTitleAndPrice;
//
//   const OrderDetailsCardDataDesignWidget({
//     super.key,
//     required this.title,
//     required this.subTitle,
//     this.color,
//     this.isColor = false,
//     this.isPrice = false,
//     this.colorTitleAndPrice,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         AutoSizeTextWidget(
//           text: title,
//           fontSize: 11.5.sp,
//           colorText: colorTitleAndPrice ?? AppColors.fontColor,
//         ),
//         Visibility(
//           visible: isColor,
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 2.w),
//             child: CircleAvatar(
//               backgroundColor: color ?? Colors.transparent,
//               radius: 5.r,
//             ),
//           ),
//         ),
//         isColor ? 0.horizontalSpace : 2.w.horizontalSpace,
//         Flexible(
//           child: Visibility(
//             visible: !isPrice,
//             replacement: PriceAndCurrencyWidget(
//               price: subTitle,
//               fontSize1: 10.5.sp,
//               fontSize2: 9.sp,
//               colorText1: colorTitleAndPrice ?? Colors.black,
//               colorText2: colorTitleAndPrice ?? Colors.black,
//             ),
//             child: AutoSizeTextWidget(
//               text: subTitle,
//               fontSize: 11.5.sp,
//               colorText: AppColors.fontColor,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
