import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safirah/core/widgets/price_and_currency_widget.dart';
import '../../../../../../core/constants/app_icons.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../../services/auth/auth.dart';
import '../state_mangment/riverpod_details.dart';

class PrintingOnTheProductWidget extends ConsumerWidget {

  final String stateKey;  final String printingPrice;
  final Color color;

  const PrintingOnTheProductWidget({
    super.key,
    required this.stateKey,
    required this.printingPrice,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final isActivePrintable =
        ref.watch(activatePrintingOnTheProductProvider(stateKey));

    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          8.w.horizontalSpace,
          SvgPicture.asset(AppIcons.printing),
          8.w.horizontalSpace,
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AutoSizeTextWidget(
                text: S.of(context).printingOnTheProduct,
                colorText: Colors.black87,
                fontSize: 11.6.sp,
                fontWeight: FontWeight.w400,
              ),
              6.w.horizontalSpace,
              PriceAndCurrencyWidget(
                price: printingPrice,
              ),
            ],
          ),
          const Spacer(),
          Transform.scale(
            scale: 0.73.r,
            child: Switch(
              value: isActivePrintable,
              padding: EdgeInsets.zero,
              inactiveThumbColor: AppColors.whiteColor,
              inactiveTrackColor: AppColors.fontColor2.withValues(alpha: 0.28),
              activeThumbColor: AppColors.whiteColor,
              activeTrackColor: AppColors.primaryColor,
              onChanged: (value) async {
                final seen = await Auth().getPrintingIntroSeen();
                if (!seen) {
                  final acknowledged =
                      await _showIntroDialog(context, printingPrice);
                  if (acknowledged == true) {
                    await Auth().cachePrintingIntroSeen(true);
                  }
                  return;
                }
                final notifier = ref.read(
                  activatePrintingOnTheProductProvider(stateKey).notifier,
                );
                notifier.state = !notifier.state;
              },
            ),
          ),
          3.w.horizontalSpace,
        ],
      ),
    );
  }

  Future<bool?> _showIntroDialog(BuildContext context, String price) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final List<String> items = isArabic
        ? [
            'يمكنك إضافة طباعة مخصصة على المنتج بما ترغب.',
            'سعر الطباعة ثابت لكل المنتجات: $price.',
            'ستصف تفاصيل الطباعة عند تأكيد الطلب.',
            'يمكنك إلغاء خيار الطباعة من السلة قبل إتمام الشراء.',
          ]
        : [
            'You can add custom printing to this product.',
            'The printing price is fixed for all products: $price.',
            'You will describe the print details at order confirmation.',
            'You can remove the printing option from the cart before checkout.',
          ];

    return showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Row(
          children: [
            SvgPicture.asset(
              AppIcons.printing,
              height: 24.h,
            ),
            4.w.horizontalSpace,
            Text(
              S.of(context).printingOnTheProduct,
              style: TextStyle(
                color: AppColors.mainColorFont,
                fontSize: 16.4.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: items
              .map(
                (e) => Padding(
                  padding: EdgeInsets.only(bottom: 4.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('• ', style: TextStyle(fontSize: 13.sp)),
                      Expanded(
                        child: Text(
                          e,
                          style: TextStyle(
                              fontSize: 12.sp, color: AppColors.fontColor),
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
        backgroundColor: Colors.white,
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(
              S.of(context).cancel,
              style: TextStyle(color: AppColors.secondaryColor),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.secondaryColor,
              foregroundColor: Colors.white,
            ),
            child: Text(S.of(context).understood),
          ),
        ],
      ),
    );
  }
}
