import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/app_icons.dart';
import '../../../../../core/widgets/secondary_app_bar_widget.dart';
import '../../../../../core/widgets/show_modal_bottom_sheet_widget.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../services/auth/auth.dart';
import '../../../main/presentation/widgets/list_tile_profile_widget.dart';
import 'change_currency_bottom_sheet.dart';
import 'language_bottom_sheet.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // void _refresh() {
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SecondaryAppBarWidget(
        title: S.of(context).settings,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12.sp),
        child: Column(
          spacing: 12.h,
          children: [
            ListTileProfileWidget(
              title: S.of(context).currency,
              icon: AppIcons.currency,
              onTap: () {
                scrollShowModalBottomSheetWidget(
                  title: S.of(context).changeCurrency,
                  fontSize: 15.sp,
                  context: context,
                  page: const ChangeCurrencyBottomSheet(),
                );
              },
            ),
            ListTileProfileWidget(
              title: S.of(context).language,
              icon: AppIcons.translate,
              onTap: () {
                scrollShowModalBottomSheetWidget(
                  title: S.of(context).applicationLanguage,
                  fontSize: 15.sp,
                  context: context,
                  page: const LanguageBottomSheet(),
                );
              },
            ),
            Visibility(
              visible: Auth().loggedIn,
              child: Column(
                spacing: 12.h,
                children: [
                  ListTileProfileWidget(
                    title: S.of(context).deleteAccount,
                    icon: AppIcons.trash,
                    onTap: () {
                      // showModalBottomSheetWidget(
                      //   context: context,
                      //   page: LogoutOrDeleteAccountDialog(
                      //     deleteAccount: true,
                      //     onSuccess: _refresh,
                      //   ),
                      // );
                    },
                  ),
                  ListTileProfileWidget(
                    title: S.of(context).changePhoneNumber,
                    icon: AppIcons.phone,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
