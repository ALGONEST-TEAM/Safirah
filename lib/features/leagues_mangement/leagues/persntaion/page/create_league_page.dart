import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:safirah/core/helpers/navigateTo.dart';
import 'package:safirah/core/helpers/localized_number_helper.dart';
import 'package:safirah/core/widgets/buttons/default_button.dart';
import 'package:uuid/uuid.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/secondary_app_bar_widget.dart';
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
    final state = ref.watch(leagueFormProvider);
    final notifier = ref.read(leagueFormProvider.notifier);

    return Scaffold(
      appBar:  SecondaryAppBarWidget(
      title: 'انشاء الدوري',
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
                      // CreateLeagueLogoPickerWidget(
                      //   logoPath: _logoUrl,
                      //   picker: _picker,
                      //   onLogoChanged: _onLogoChanged,
                      // ),
                      CreateLeagueLogoPickerWidget(
                        logoLocalPath: _logoLocalPath,
                        picker: _picker,
                        onLogoChanged: _onLogoChanged,
                        imageStore: _imageStore,
                        draftKey: _draftKey,
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
                  print(_logoLocalPath);

                  final isValid = formKey.currentState!.validate();

                  if (isValid) {
                    final normalizedTeams = LocalizedNumberHelper.parseInt(
                      teamsController.text,
                    );
                    final normalizedMainPlayers =
                        LocalizedNumberHelper.parseInt(
                      mainPlayersController.text,
                    );
                    final normalizedSubPlayers = LocalizedNumberHelper.parseInt(
                      subPlayersController.text,
                    );
                    final normalizedSubscriptionPrice =
                        LocalizedNumberHelper.normalizeNumericText(
                      subscriptionPriceController.text,
                    );

                    navigateTo(
                      context,
                      LeagueRulesPage(
                        name: nameController.text,
                        maxTeams: normalizedTeams,
                        maxSubPlayers: normalizedSubPlayers,
                        maxMainPlayers: normalizedMainPlayers,
                        isPrivate: state.isPrivate,
                        type: state.type,
                        scope: state.scope,
                        subscriptionPrice: normalizedSubscriptionPrice,
                        logoPath: _logoLocalPath,
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


class LocalImageStore {
  const LocalImageStore();

  String _hash(String input) => sha1.convert(input.codeUnits).toString();

  Future<String> savePickedImage({
    required String pickedPath,
    required String namespace, // 'leagues'
    required String key, // league temp key or uuid
  }) async {
    final src = File(pickedPath);
    if (!await src.exists()) {
      throw Exception('Picked image not found: $pickedPath');
    }

    final docs = await getApplicationDocumentsDirectory();
    final dir = Directory(p.join(docs.path, 'images', namespace));
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }

    final ext = p.extension(pickedPath).isNotEmpty ? p.extension(pickedPath) : '.jpg';
    final name = '${_hash(key)}$ext';
    final dst = File(p.join(dir.path, name));

    await src.copy(dst.path);
    return dst.path;
  }
}
