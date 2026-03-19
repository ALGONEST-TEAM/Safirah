import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../../../../../core/state/check_state_in_post_api_data_widget.dart';
import '../../../../../core/state/state.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/buttons/default_button.dart';
import '../../../../../core/widgets/secondary_app_bar_widget.dart';
import '../../../../../core/widgets/text_form_field.dart';
import '../../../leagues/persntaion/page/create_league_page.dart';
import '../../data/model/team_model.dart';
import '../state_mangment/riverpod.dart';
import '../widget/edit_team_logo_picker_widget.dart';

class TeamEditorPage extends ConsumerStatefulWidget {
  final String leagueSyncId;
  final TeamModel team;

  const TeamEditorPage(
      {super.key, required this.leagueSyncId, required this.team});

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
  String? _logoLocalPath;
  final ImagePicker _picker = ImagePicker();
  final String _draftKey = const Uuid().v7();
  final LocalImageStore _imageStore = const LocalImageStore();

  void _onLogoChanged(String? path) {
    setState(() {
      _logoLocalPath = path;
    });
  }

  @override
  Widget build(BuildContext context) {
    final saver = ref.watch(updateTeamProvider);

    return Scaffold(
      appBar:SecondaryAppBarWidget(title: 'تعديل بيانات الفريق',),

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
                        logoLocalPath: _logoLocalPath,
                        picker: _picker,
                        draftKey: _draftKey,
                        imageStore: _imageStore,
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
                    print(_logoLocalPath);

                    final team = TeamModel(
                        leagueSyncId: widget.leagueSyncId,
                        teamName: _nameCtrl.text,
                        logoUrl: _logoLocalPath,
                        syncId: widget.team.syncId,
                        id: widget.team.id);
                    if (_nameCtrl.text.trim().isEmpty) return;
                    ref.read(updateTeamProvider.notifier).update(team);
                  },
                ),
                state: saver,
                functionSuccess: () {
                  ref
                      .read(teamsRefreshProvider(widget.leagueSyncId).notifier)
                      .refresh();
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
