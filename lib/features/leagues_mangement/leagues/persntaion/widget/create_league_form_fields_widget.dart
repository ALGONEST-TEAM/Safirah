import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/show_modal_bottom_sheet_widget.dart';
import '../../../../../core/widgets/text_form_field.dart';
import '../../data/model/league_model.dart';
import 'selector_filed_widget.dart';

class CreateLeagueFormFieldsWidget extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController teamsController;
  final TextEditingController mainPlayersController;
  final TextEditingController subPlayersController;
  final TextEditingController subscriptionPriceController;
  final LeagueModel state;
  final dynamic notifier; // LeagueFormNotifier، يُمرر من الصفحة الأصلية

  const CreateLeagueFormFieldsWidget({
    super.key,
    required this.nameController,
    required this.teamsController,
    required this.mainPlayersController,
    required this.subPlayersController,
    required this.subscriptionPriceController,
    required this.state,
    required this.notifier,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeTextWidget(
          text: 'إنشاء الدوري الخاص بك!',
          fontSize: 16.sp,
        ),
        SizedBox(height: 16.h),
        AutoSizeTextWidget(
          text: 'اسم الدوري',
          fontSize: 12.sp,
          colorText: Colors.black,
        ),
        SizedBox(height: 6.h),
        TextFormFieldWidget(
          controller: nameController,
          hintText: 'اسم الدوري',
          onChanged: notifier.updateName,
          hintTextColor: Colors.grey[600],
          labelTextColor: Colors.grey[600],
          fieldValidator: (value) {
            if (value == null || value.toString().isEmpty) {
              return 'ادخل اسم الدوري';
            }
            return null;
          },
        ),
        SizedBox(height: 12.h),
        AutoSizeTextWidget(
          text: 'عدد الفرق',
          fontSize: 12.sp,
          colorText: Colors.black,
        ),
        SizedBox(height: 6.h),
        TextFormFieldWidget(
          controller: teamsController,
          hintText: 'عدد الفرق',
          type: TextInputType.number,
          onChanged: (v) => notifier.updateMaxTeams(int.tryParse(v) ?? 0),
          hintTextColor: Colors.grey[600],
          fieldValidator: (value) {
            if (value == null || value.toString().isEmpty) {
              return 'ادخل عدد الفرق في الدوري';
            }
            return null;
          },
        ),
        SizedBox(height: 16.h),
        AutoSizeTextWidget(
          text: 'سعر الاشتراك',
          fontSize: 12.sp,
          colorText: Colors.black,
        ),
        SizedBox(height: 6.h),
        TextFormFieldWidget(
          controller: subscriptionPriceController,
          hintText: 'سعر الاشتراك',
          onChanged: notifier.updateName,
          hintTextColor: Colors.grey[600],
          labelTextColor: Colors.grey[600],
          fieldValidator: (value) {
            if (value == null || value.toString().isEmpty) {
              return 'ادخل سعر الاشتراك';
            }
            return null;
          },
        ),
        SizedBox(height: 12.h),
        SelectorFieldWidget(
          label: 'تخصيص الدوري',
          value: state.isPrivate ? 'خاص' : 'عام',
          onTap: () => showSelectorSheet<bool>(
            context: context,
            title: 'تخصيص الدوري',
            options: const [false, true],
            initialValue: state.isPrivate,
            labelOf: (e) => e ? 'خاص' : 'عام',
            onConfirm: notifier.updatePrivacy,
          ),
        ),
        SizedBox(height: 16.h),
        AutoSizeTextWidget(
          text: 'عدد اللاعبين لكل فريق',
          fontSize: 12.sp,
          colorText: Colors.black,
        ),
        SizedBox(height: 6.h),
        Row(
          children: [
            Expanded(
              child: TextFormFieldWidget(
                controller: mainPlayersController,
                hintText: 'الأساسي',
                type: TextInputType.number,
                hintTextColor: Colors.grey[600],
                onChanged: (v) =>
                    notifier.updateMaxMainPlayers(int.tryParse(v) ?? 0),
                fieldValidator: (value) {
                  if (value == null || value.toString().isEmpty) {
                    return 'ادخل عدد اللاعبين الاساسيين للفريق';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: TextFormFieldWidget(
                controller: subPlayersController,
                hintText: 'الاحتياط',
                type: TextInputType.number,
                hintTextColor: Colors.grey[600],
                onChanged: (v) =>
                    notifier.updateMaxSubPlayers(int.tryParse(v) ?? 0),
                fieldValidator: (value) {
                  if (value == null || value.toString().isEmpty) {
                    return 'ادخل عدد اللاعبين الاحتياط للفريق';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
