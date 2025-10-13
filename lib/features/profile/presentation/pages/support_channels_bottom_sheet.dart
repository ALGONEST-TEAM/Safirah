import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:safirah/core/theme/app_colors.dart';
import 'package:safirah/core/widgets/auto_size_text_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/constants/app_icons.dart';
import '../../../../../generated/l10n.dart';

class SupportChannelsBottomSheet extends StatelessWidget {
  const SupportChannelsBottomSheet({super.key});

  Future<void> _launchWhatsApp(String phone) async {
    final url = Uri.parse("https://wa.me/$phone");
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> _launchPhone(String phone) async {
    final url = Uri.parse("tel:$phone");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  Future<void> _launchEmail(String email) async {
    final url = Uri.parse("mailto:$email");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    final items = [
      {
        "title": "773551738",
        "icon": AppIcons.whatsapp,
        "onTap": () => _launchWhatsApp("773551738"),
      },
      {
        "title": "777111686",
        "icon": AppIcons.whatsapp,
        "onTap": () => _launchWhatsApp("777111686"),
      },
      {
        "title": "0139034",
        "icon": AppIcons.phone,
        "onTap": () => _launchPhone("0139034"),
      },
      {
        "title": "mraed225588@gmail.com",
        "icon": AppIcons.email,
        "onTap": () => _launchEmail("mraed225588@gmail.com"),
      },
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 8.h,
        children: [
          AutoSizeTextWidget(
            text: S.of(context).supportDescription,
            fontSize: 11.6.sp,
            colorText: AppColors.fontColor.withValues(alpha: 0.7),
            maxLines: 3,
          ),
          2.h.verticalSpace,
          ...items.map(
            (item) => ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Material(
                color: AppColors.scaffoldColor,
                child: ListTile(
                  leading: SvgPicture.asset(item["icon"].toString()),
                  title: AutoSizeTextWidget(
                    text: item["title"] as String,
                    fontSize: 12.sp,
                    colorText: AppColors.fontColor,
                    fontWeight: FontWeight.w400,
                  ),
                  dense: true,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 1.h, horizontal: 12.w),
                  onTap: item["onTap"] as VoidCallback,
                ),
              ),
            ),
          ),
          2.h.verticalSpace,
        ],
      ),
    );
  }
}
