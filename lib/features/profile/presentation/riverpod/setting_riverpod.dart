import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/state/data_state.dart';
import '../../../../../core/state/state.dart';
import '../../../../../services/auth/auth.dart';
import '../../../user/data/model/auth_model.dart';
import '../../data/repos/profile_repo.dart';

final languageProvider =
    StateNotifierProvider<LanguageController, Locale>((ref) {
  return LanguageController();
});

class LanguageController extends StateNotifier<Locale> {
  LanguageController() : super(const Locale('ar')) {
    _loadSavedLanguage();
  }

  Future<void> _loadSavedLanguage() async {
    try {
      final savedLanguage = await Auth().getLanguage();
      state = Locale(savedLanguage);
    } catch (e) {
      state = const Locale('ar');
      debugPrint("Error loading language: $e");
    }
  }

  Future<void> changeLanguage(String languageCode) async {
    try {
      await Auth().setLanguage(languageCode);
      state = Locale(languageCode);
    } catch (e) {
      debugPrint("Error changing language: $e");
    }
  }
}

final changePhoneNumberProvider = StateNotifierProvider.autoDispose<
    ChangePhoneNumberController, DataState<AuthModel>>(
  (ref) {
    return ChangePhoneNumberController();
  },
);

class ChangePhoneNumberController extends StateNotifier<DataState<AuthModel>> {
  ChangePhoneNumberController() : super(DataState<AuthModel>.initial(AuthModel.empty()));
  final _controller = ProfileReposaitory();

  Future<void> changePhoneNumber({
    required String phoneNumber,
    required String otp,
  }) async {
    state = state.copyWith(state: States.loading);

    final data = await _controller.changePhoneNumber(
      phoneNumber: phoneNumber,
      otp: otp,
    );
    data.fold((f) {
      state = state.copyWith(state: States.error, exception: f);
    }, (data) {
      state = state.copyWith(state: States.loaded,data: data);
    });
  }
}
