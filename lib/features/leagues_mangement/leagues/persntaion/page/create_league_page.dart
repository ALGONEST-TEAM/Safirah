import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:safirah/core/helpers/navigateTo.dart';
import 'package:safirah/core/widgets/buttons/default_button.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../riverpod/riverpod.dart';
import '../widget/create_league_form_fields_widget.dart';
import '../widget/create_league_logo_picker_widget.dart';
import 'add_rule_league_page.dart';

class CreateLeaguePage extends ConsumerStatefulWidget {
  const CreateLeaguePage({super.key});

  @override
  ConsumerState<CreateLeaguePage> createState() => _LeagueFormPageState();
}

class _LeagueFormPageState extends ConsumerState<CreateLeaguePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController teamsController = TextEditingController();
  final TextEditingController mainPlayersController = TextEditingController();
  final TextEditingController subPlayersController = TextEditingController();
  final TextEditingController subscriptionPriceController =
      TextEditingController();

  final formKey = GlobalKey<FormState>();
  String? _logoUrl;
  final ImagePicker _picker = ImagePicker();

  void _onLogoChanged(String? path) {
    setState(() {
      _logoUrl = path;
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(leagueFormProvider);
    final notifier = ref.read(leagueFormProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.secondaryColor,
        elevation: 0,
        leading: const BackButton(color: Colors.white),
        title: const AutoSizeTextWidget(
          text: 'انشاء دوري',
          colorText: Colors.white,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16.w),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CreateLeagueFormFieldsWidget(
                        nameController: nameController,
                        teamsController: teamsController,
                        mainPlayersController: mainPlayersController,
                        subPlayersController: subPlayersController,
                        subscriptionPriceController:
                            subscriptionPriceController,
                        state: state,
                        notifier: notifier,
                      ),
                      SizedBox(height: 12.h),
                      CreateLeagueLogoPickerWidget(
                        logoPath: _logoUrl,
                        picker: _picker,
                        onLogoChanged: _onLogoChanged,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.0.w, right: 16.w),
              child: DefaultButtonWidget(
                text: 'متابعة',
                background: AppColors.primaryColor,
                onPressed: () {
                  final isValid = formKey.currentState!.validate();

                  if (isValid) {
                    navigateTo(
                      context,
                      LeagueRulesPage(
                        name: nameController.text,
                        maxTeams: int.tryParse(teamsController.text),
                        maxSubPlayers:
                            int.tryParse(subPlayersController.text),
                        maxMainPlayers:
                            int.tryParse(mainPlayersController.text),
                        isPrivate: state.isPrivate,
                        type: state.type,
                        scope: state.scope,
                        subscriptionPrice: subscriptionPriceController.text,
                        logoPath: _logoUrl,
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
