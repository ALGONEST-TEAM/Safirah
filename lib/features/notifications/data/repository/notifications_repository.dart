import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../model/notifications_model.dart';
import '../source/notifications_remote.dart';

class ReposaitoriesNotifications {
  final _remote = NotificationsRemoteDataSource();

  ReposaitoriesNotifications();

  Future<Either<DioException, List<NotificationsModel>>>
      getNotifications() async {
    try {
      final update = await _remote.getNotifications();
      return Right(update);
    } on DioException catch (e) {
      return Left(e);
    }
  }

  Future<Either<DioException, int>> getUnreadCount() async {
    try {
      final c = await _remote.getUnreadCount();
      return Right(c);
    } on DioException catch (e) {
      return Left(e);
    }
  }

  Future<Either<DioException, Unit>> markAsRead(String id) async {
    try {
      await _remote.markAsRead(id: id);
      return const Right(unit);
    } on DioException catch (e) {
      return Left(e);
    }
  }
}
