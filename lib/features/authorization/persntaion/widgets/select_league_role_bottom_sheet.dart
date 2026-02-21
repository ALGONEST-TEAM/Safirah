import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:safirah/core/state/check_state_in_post_api_data_widget.dart';
import 'package:safirah/core/state/state.dart';

import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../core/widgets/buttons/icon_button_widget.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../leagues_mangement/leagues/persntaion/widget/radio_dot_widget.dart';
import '../../data/model/authorization_models.dart';
import '../riverpod/riverpod.dart';

enum LeagueRoleChoice {
  referee,
  media,
}

extension LeagueRoleChoiceX on LeagueRoleChoice {
  String get labelAr {
    switch (this) {
      case LeagueRoleChoice.referee:
        return 'حكم';
      case LeagueRoleChoice.media:
        return 'اعلامي';
    }
  }

  /// قيمة ثابتة يمكن إرسالها للـ API لاحقاً
  int get key {
    switch (this) {
      case LeagueRoleChoice.referee:
        return 2;
      case LeagueRoleChoice.media:
        return 3;
    }
  }
}

class SelectLeagueRoleBottomSheet extends ConsumerStatefulWidget {
  final LeagueRoleChoice? initial;
  final void Function(LeagueRoleChoice choice) onConfirm;

  final UserModelForAuthorization userModelForAuthorization;

  const SelectLeagueRoleBottomSheet(
      {super.key,
      this.initial,
      required this.onConfirm,
      required this.userModelForAuthorization});

  @override
  ConsumerState<SelectLeagueRoleBottomSheet> createState() =>
      _SelectLeagueRoleBottomSheetState();
}

class _SelectLeagueRoleBottomSheetState
    extends ConsumerState<SelectLeagueRoleBottomSheet> {
  LeagueRoleChoice? _temp;

  @override
  void initState() {
    super.initState();
    _temp = widget.initial;
  }

  @override
  Widget build(BuildContext context) {
    final assignUserState = ref.watch(assignRoleForUserProvider);

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(16.r),
          topLeft: Radius.circular(16.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AutoSizeTextWidget(
                text: 'اختر الدور',
                fontSize: 12.sp,
                colorText: Colors.grey[700],
              ),
              const Spacer(),
              IconButtonWidget(
                icon: AppIcons.close,
                height: 15.h,
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          ...LeagueRoleChoice.values.map((opt) {
            final selected = _temp == opt;
            return GestureDetector(
              onTap: () => setState(() => _temp = opt),
              child: Container(
                margin: EdgeInsets.only(bottom: 10.h),
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
                decoration: BoxDecoration(
                  color: selected ? const Color(0xFFEFF3FF) : Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AutoSizeTextWidget(text: opt.labelAr),
                    RadioDotWidget(selected: selected),
                  ],
                ),
              ),
            );
          }),
          SizedBox(height: 6.h),
          CheckStateInPostApiDataWidget(
            functionSuccess: () {
              Navigator.of(context).pop();

              FlushbarHelper.createSuccess(
                message: 'تم تعيين الدور بنجاح',
              ).show(context);
            },
            hasMessageSuccess: false,
            state: assignUserState,
            bottonWidget: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E1846),
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                ),
                onPressed: () {
                  ref.read(assignRoleForUserProvider.notifier).load(widget
                      .userModelForAuthorization
                      .copyWith(authorizationType: _temp!.key));
                },
                child: assignUserState.stateData == States.loading
                    ? SpinKitCircle(
                        color: Colors.white,
                        size: 20.r,
                      )
                    : AutoSizeTextWidget(
                        text: 'تم',
                        fontSize: 15.sp,
                        colorText: Colors.white,
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
