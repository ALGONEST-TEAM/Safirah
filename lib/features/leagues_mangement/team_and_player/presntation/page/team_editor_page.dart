import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/state/check_state_in_post_api_data_widget.dart';
import '../../../../../core/state/state.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/buttons/default_button.dart';
import '../../../../../core/widgets/text_form_field.dart';
import '../../data/model/team_model.dart';
import '../state_mangment/riverpod.dart';
import '../widget/edit_team_logo_picker_widget.dart';

class TeamEditorPage extends ConsumerStatefulWidget {
  final int leagueId;
  final TeamModel team;

  const TeamEditorPage({super.key, required this.leagueId, required this.team});

  @override
  ConsumerState<TeamEditorPage> createState() => _TeamEditorPageState();
}

class _TeamEditorPageState extends ConsumerState<TeamEditorPage> {
  @override
  void initState() {
    _nameCtrl.text = widget.team.teamName;
    super.initState();
  }

  final _nameCtrl = TextEditingController();
  String? _logoUrl;
  final ImagePicker _picker = ImagePicker();

  void _onLogoChanged(String? path) {
    setState(() {
      _logoUrl = path;
    });
  }

  @override
  Widget build(BuildContext context) {
    final saver = ref.watch(updateTeamProvider);

    return Scaffold(
      appBar: AppBar(
        title: const AutoSizeTextWidget(
          text: 'تعديل بيانات الفريق',
          colorText: Colors.white,
        ),
        centerTitle: true,
        leading: const BackButton(
          color: Colors.white,
        ),
        backgroundColor: AppColors.secondaryColor,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const AutoSizeTextWidget(
                        text: 'اسم الفريق',
                      ),
                      SizedBox(height: 4.h),
                      TextFormFieldWidget(
                          controller: _nameCtrl, hintText: 'اسم الفريق'),
                      SizedBox(height: 10.h),
                      EditTeamLogoPickerWidget(
                        logoPath: _logoUrl,
                        picker: _picker,
                        onLogoChanged: _onLogoChanged,
                      ),
                      SizedBox(height: 10.h),
                    ],
                  ),
                ),
              ),
              CheckStateInPostApiDataWidget(
                bottonWidget: DefaultButtonWidget(
                  text: 'حفظ الفريق',
                  isLoading: saver.stateData == States.loading,
                  onPressed: () {
                    final team = TeamModel(
                        leagueId: widget.leagueId,
                        teamName: _nameCtrl.text,
                        logoUrl: _logoUrl,
                        id: widget.team.id);
                    if (_nameCtrl.text.trim().isEmpty) return;
                    ref.read(updateTeamProvider.notifier).update(team);
                  },
                ),
                state: saver,
                functionSuccess: () {
                  ref.read(teamsProvider(widget.leagueId).notifier).load();
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
