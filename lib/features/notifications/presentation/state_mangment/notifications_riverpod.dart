import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../../../core/state/data_state.dart';
import '../../../../core/state/state.dart';
import '../../data/model/notifications_model.dart';
import '../../data/repository/notifications_repository.dart';

final notificationProvider = StateNotifierProvider.autoDispose<
    NotificationNotifier, DataState<List<NotificationsModel>>>(
  (ref) => NotificationNotifier(ref),
);

class NotificationNotifier
    extends StateNotifier<DataState<List<NotificationsModel>>> {
  NotificationNotifier(this._ref)
      : super(DataState<List<NotificationsModel>>.initial([])) {
    getNotifications();
  }

  final Ref _ref;
  final _repo = ReposaitoriesNotifications();
  final Set<int> _pending = {};

  Future<void> getNotifications() async {
    state = state.copyWith(state: States.loading);
    final res = await _repo.getNotifications();
    res.fold(
      (f) => state = state.copyWith(state: States.error, exception: f),
      (data) => state = state.copyWith(state: States.loaded, data: data),
    );
  }

  Future<void> markAsRead({required int index}) async {
    if (_pending.contains(index)) return;

    final items = [...state.data];
    final item = items[index];
    if (item.readAt != null) return;

    final old = item;
    final optimistic = NotificationsModel(
      id: item.id,
      userId: item.userId,
      title: item.title,
      message: item.message,
      date: item.date,
      readAt: DateTime.now().toIso8601String(),
    );
    items[index] = optimistic;

    state = state.copyWith(data: items, state: States.loaded);

    _pending.add(index);
    final res = await _repo.markAsRead(item.id!.toString());
    _pending.remove(index);

    res.fold((_) {
      items[index] = old;
      state = state.copyWith(data: items, state: States.loaded);
    }, (_) {
      _ref.read(unreadCountProvider.notifier).refresh();
    });
  }
}

final unreadCountProvider =
    StateNotifierProvider.autoDispose<UnreadNotifier, int>(
        (ref) => UnreadNotifier());

class UnreadNotifier extends StateNotifier<int> {
  UnreadNotifier() : super(0);

  final _repo = ReposaitoriesNotifications();

  Future<void> refresh() async {
    final res = await _repo.getUnreadCount();
    res.fold((_) {}, (count) => state = count);
  }

  void set(int value) => state = value;

  void clear() => state = 0;
}
