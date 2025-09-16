import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/state/data_state.dart';
import '../../../../../core/state/state.dart';
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
}