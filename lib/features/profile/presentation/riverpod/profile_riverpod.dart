import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../../../../core/state/data_state.dart';
import '../../../../../core/state/state.dart';
import '../../data/model/profile_data_model.dart';
import '../../data/repos/profile_repo.dart';

final logoutProvider =
    StateNotifierProvider.autoDispose<LogoutController, DataState<Unit>>(
  (ref) {
    return LogoutController();
  },
);

class LogoutController extends StateNotifier<DataState<Unit>> {
  LogoutController() : super(DataState<Unit>.initial(unit));
  final _controller = ProfileReposaitory();

  Future<void> logout() async {
    state = state.copyWith(state: States.loading);

    final data = await _controller.logout();
    data.fold((f) {
      state = state.copyWith(state: States.error, exception: f);
    }, (data) {
      state = state.copyWith(state: States.loaded);
    });
  }

  Future<void> deleteAccount() async {
    state = state.copyWith(state: States.loading);

    final data = await _controller.deleteAccount();
    data.fold((f) {
      state = state.copyWith(state: States.error, exception: f);
    }, (data) {
      state = state.copyWith(state: States.loaded);
    });
  }
}

final getProfileDataProvider = StateNotifierProvider.autoDispose<
    GetProfileDataNotifier, DataState<ProfileDataModel>>(
  (ref) {
    return GetProfileDataNotifier();
  },
);

class GetProfileDataNotifier
    extends StateNotifier<DataState<ProfileDataModel>> {
  GetProfileDataNotifier()
      : super(DataState<ProfileDataModel>.initial(ProfileDataModel.empty())) {
    getData();
  }

  final _controller = ProfileReposaitory();

  Future<void> getData() async {
    state = state.copyWith(state: States.loading);
    final data = await _controller.getProfileData();
    data.fold(
      (failure) {
        state = state.copyWith(state: States.error, exception: failure);
      },
      (data) {
        state = state.copyWith(state: States.loaded, data: data);
      },
    );
  }
}

final changeWatcherProvider =
    StateNotifierProvider.autoDispose<ChangeWatcher, ChangeResult>(
  (ref) => ChangeWatcher(),
);

class ChangeWatcher extends StateNotifier<ChangeResult> {
  ChangeWatcher() : super(ChangeResult.empty);

  ProfileDataModel? _initial;

  ProfileDataModel? get initial => _initial;

  void setInitial(ProfileDataModel initial) {
    _initial = initial;
    state = ChangeResult.empty;
  }

  void compute(ProfileDataModel current) {
    final init = _initial;
    if (init == null) return;

    bool eqStr(String? a, String? b) => (a ?? '').trim() == (b ?? '').trim();
    String normGender(String? g) =>
        ((g ?? '').toLowerCase() == 'female') ? 'female' : 'male';

    String? normDate(String? s) {
      if (s == null || s.isEmpty) return null;
      final d = DateTime.tryParse(s);
      if (d == null) return null;
      return "${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}";
    }

    state = ChangeResult(
      nameChanged: !eqStr(current.name, init.name),
      genderChanged: normGender(current.gender) != normGender(init.gender),
      birthDateChanged:
          normDate(current.dateOfBirth) != normDate(init.dateOfBirth),
      cityChanged: (current.cityId) != (init.cityId),
    );
  }
}

final editProfileProvider = StateNotifierProvider.autoDispose<
    EditProfileNotifier,
    DataState<ProfileDataModel>>((ref) => EditProfileNotifier());

class EditProfileNotifier extends StateNotifier<DataState<ProfileDataModel>> {
  EditProfileNotifier()
      : super(DataState<ProfileDataModel>.initial(ProfileDataModel.empty()));
  final _controller = ProfileReposaitory();

  Future<void> editProfile({
    required String name,
    required String gender,
    required int cityId,
    DateTime? dateOfBirth,
  }) async {
    state = state.copyWith(state: States.loading);
    final user = await _controller.editProfile(
      name: name,
      gender: gender,
      cityId: cityId,
      dateOfBirth: dateOfBirth,
    );
    user.fold((f) {
      state = state.copyWith(state: States.error, exception: f);
    }, (data) {
      state = state.copyWith(state: States.loaded, data: data);
    });
  }
}
