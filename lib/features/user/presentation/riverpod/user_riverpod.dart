
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/state/data_state.dart';
import '../../../../core/state/state.dart';
import '../../data/model/auth_model.dart';
import '../../data/model/check_user_model.dart';
import '../../data/repos/user_repo.dart';

final checkUserProvider =
    StateNotifierProvider<CheckUserNotifier, DataState<CheckUserModel>>(
        (ref) => CheckUserNotifier());

class CheckUserNotifier extends StateNotifier<DataState<CheckUserModel>> {
  CheckUserNotifier()
      : super(DataState<CheckUserModel>.initial(CheckUserModel.empty()));
  final _controller = UserReposaitory();

  Future<void> checkUser({
    required String phoneNumberOrEmail,
  }) async {
    state = state.copyWith(state: States.loading);
    final user = await _controller.checkUser(phoneNumberOrEmail);
    user.fold((f) {
      state = state.copyWith(state: States.error, exception: f);
    }, (userData) {
      state = state.copyWith(state: States.loaded, data: userData);
    });
  }
}

final logInOrSignUpProvider = StateNotifierProvider.autoDispose<
    LogInOrSignUpNotifier,
    DataState<AuthModel>>((ref) => LogInOrSignUpNotifier());

class LogInOrSignUpNotifier extends StateNotifier<DataState<AuthModel>> {
  LogInOrSignUpNotifier()
      : super(DataState<AuthModel>.initial(AuthModel.empty()));
  final _controller = UserReposaitory();

  Future<void> logInOrSignUp({
    required String phoneNumberOrEmail,
    required String name,
    required String password,
  }) async {
    state = state.copyWith(state: States.loading);
    final user = await _controller.logInOrSignUp(phoneNumberOrEmail, password,name);
    user.fold((f) {
      state = state.copyWith(state: States.error, exception: f);
    }, (data) {
      state = state.copyWith(state: States.loaded, data: data);
    });
  }
}

final checkOTPProvider =
    StateNotifierProvider.autoDispose<CheckOTPNotifier, DataState<AuthModel>>(
        (ref) => CheckOTPNotifier());

class CheckOTPNotifier extends StateNotifier<DataState<AuthModel>> {
  CheckOTPNotifier() : super(DataState<AuthModel>.initial(AuthModel.empty()));
  final _controller = UserReposaitory();

  Future<void> checkOTP({
    required String phoneNumberOrEmail,
    required String otp,
  }) async {
    state = state.copyWith(state: States.loading);
    final user = await _controller.checkOTP(phoneNumberOrEmail, otp);
    user.fold((f) {
      state = state.copyWith(state: States.error, exception: f);
    }, (data) {
      state = state.copyWith(state: States.loaded, data: data);
    });
  }
}

/// resend OTP and forget password and reset password Riverpod
final userProvider =
    StateNotifierProvider.autoDispose<UserNotifier, DataState<bool>>(
        (ref) => UserNotifier());

class UserNotifier extends StateNotifier<DataState<bool>> {
  UserNotifier() : super(DataState<bool>.initial(false));
  final _controller = UserReposaitory();

  Future<void> resendOTP({
    required String phoneNumberOrEmail,
  }) async {
    state = state.copyWith(state: States.loading);
    final user = await _controller.resendOTP(phoneNumberOrEmail);
    user.fold((f) {
      state = state.copyWith(state: States.error, exception: f);
    }, (_) {
      state = state.copyWith(
        state: States.loaded,
      );
    });
  }

  Future<void> forgetPassword({
    required String phoneNumberOrEmail,
  }) async {
    state = state.copyWith(state: States.loading);
    final user = await _controller.forgetPassword(phoneNumberOrEmail);
    user.fold((f) {
      state = state.copyWith(state: States.error, exception: f);
    }, (_) {
      state = state.copyWith(
        state: States.loaded,
      );
    });
  }

  Future<void> resetPassword({
    required String phoneNumberOrEmail,
    required String password,
    required String confirmPassword,
  }) async {
    state = state.copyWith(state: States.loading);
    final user = await _controller.resetPassword(
      phoneNumberOrEmail,
      password,
      confirmPassword,
    );
    user.fold((f) {
      state = state.copyWith(state: States.error, exception: f);
    }, (_) {
      state = state.copyWith(
        state: States.loaded,
      );
    });
  }
}
