import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../../../../../core/state/check_state_in_post_api_data_widget.dart';
import '../../../../../core/state/data_state.dart';
import '../../../../../core/state/state.dart';
import '../../../../../core/widgets/bottomNavbar/button_bottom_navigation_bar_design_widget.dart';
import '../../../../../core/widgets/buttons/default_button.dart';
import '../../../../../core/widgets/logo_shimmer_widget.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../services/auth/auth.dart';
import '../../../shop/address/data/model/city_model.dart';
import '../../../user/presentation/riverpod/user_riverpod.dart';
import '../../../user/presentation/widgets/birth_date_picker_widget.dart';
import '../../../user/presentation/widgets/city_widget.dart';
import '../../../user/presentation/widgets/gender_selection_widget.dart';
import '../../../user/presentation/widgets/name_and_email_widget.dart';
import '../../data/model/profile_data_model.dart';
import '../riverpod/profile_riverpod.dart';
import '../widgets/edit_profile_app_bar_widget.dart';

class EditProfilePage extends ConsumerStatefulWidget {
  final VoidCallback? onSuccess;

  const EditProfilePage({super.key, this.onSuccess});

  @override
  ConsumerState<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends ConsumerState<EditProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool _seeded = false;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(() => _recompute());
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  String? _fmt(DateTime? d) => d == null
      ? null
      : "${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}";

  void _seedInitial(ProfileDataModel m) {
    ref.read(changeWatcherProvider.notifier).setInitial(m);

    _nameController.text = m.name;
    final gender =
        ((m.gender ?? '').toLowerCase() == 'female') ? 'female' : 'male';
    ref.read(genderProvider.notifier).state = gender;

    final dob = (m.dateOfBirth == null || m.dateOfBirth!.isEmpty)
        ? null
        : DateTime.tryParse(m.dateOfBirth!);
    ref.read(birthDateProvider.notifier).state = dob;

    final city = (m.cityId != null && (m.cityName ?? '').isNotEmpty)
        ? CityModel(id: m.cityId!, name: m.cityName!)
        : null;
    ref.read(selectedCityProvider.notifier).state = city;
  }

  ProfileDataModel _currentForCompute() {
    final init = ref.read(changeWatcherProvider.notifier).initial;
    return ProfileDataModel(
      id: init?.id ?? 0,
      name: _nameController.text.trim(),
      phoneNumber: init?.phoneNumber ?? '',
      gender: ref.read(genderProvider),
      dateOfBirth: _fmt(ref.read(birthDateProvider)),
      cityId: ref.read(selectedCityProvider)?.id,
      cityName: ref.read(selectedCityProvider)?.name,
    );
  }

  void _recompute() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(changeWatcherProvider.notifier).compute(_currentForCompute());
    });
  }

  @override
  Widget build(BuildContext context) {
    var state = ref.watch(getProfileDataProvider);
    var editState = ref.watch(editProfileProvider);
    final changes = ref.watch(changeWatcherProvider);

    ref.listen<DataState<ProfileDataModel>>(getProfileDataProvider,
        (prev, next) {
      if (!_seeded && next.stateData == States.loaded && next.data != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _seedInitial(next.data);
          _seeded = true;
          _recompute();
        });
      }
    });

    ref.listen<String>(genderProvider, (_, __) => _recompute());
    ref.listen<DateTime?>(birthDateProvider, (_, __) => _recompute());
    ref.listen<CityModel?>(selectedCityProvider, (_, __) => _recompute());

    return Scaffold(
      appBar: const EditProfileAppBarWidget(),
      body: CheckStateInGetApiDataWidget(
        state: state,
        refresh: (){
          ref.invalidate(getProfileDataProvider);
        },
        widgetOfLoading: const LogoShimmerWidget(),
        widgetOfData: Form(
          key: formKey,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 14.w),
                        child: Column(
                          children: [
                            NameAndEmailWidget(name: _nameController),
                            const BirthDatePickerWidget(),
                            12.h.verticalSpace,
                            const GenderPickerWidget(),
                            const CityWidget(),
                            16.h.verticalSpace,
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ButtonBottomNavigationBarDesignWidget(
                child: CheckStateInPostApiDataWidget(
                  state: editState,
                  messageSuccess: S.of(context).profileUpdatedSuccess,
                  functionSuccess: () {
                    final current = Auth().user;
                    final newName = _nameController.text.trim();
                    if (newName.isNotEmpty && newName != current.user.name) {
                      final updatedUser = current.user.copyWith(name: newName);
                      Auth().login(current.copyWith(user: updatedUser));
                    }
                    Navigator.of(context).pop();
                    widget.onSuccess?.call();
                  },
                  bottonWidget: Opacity(
                    opacity: changes.hasAny ? 1 : 0.5,
                    child: DefaultButtonWidget(
                      text: S.of(context).saveChanges,
                      textSize: 13.6.sp,
                      isLoading: editState.stateData == States.loading,
                      onPressed: changes.hasAny
                          ? () {
                              final isValid = formKey.currentState!.validate();
                              final selectedCity =
                                  ref.read(selectedCityProvider);
                              final birthDate = ref.read(birthDateProvider);

                              bool hasError = false;
                              if (selectedCity == null) {
                                ref
                                    .read(selectedCityErrorProvider.notifier)
                                    .state = S.of(context).pleaseChoseACity;
                                hasError = true;
                              } else {
                                ref
                                    .read(selectedCityErrorProvider.notifier)
                                    .state = null;
                              }

                              if (!isValid || hasError) return;
                              if (!isValid) return;

                              FocusManager.instance.primaryFocus?.unfocus();

                              final selectedGender = ref.read(genderProvider);
                              ref
                                  .read(editProfileProvider.notifier)
                                  .editProfile(
                                    name: _nameController.text,
                                    gender: selectedGender.toString(),
                                    cityId: selectedCity!.id,
                                    dateOfBirth: birthDate,
                                  );
                            }
                          : null,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
