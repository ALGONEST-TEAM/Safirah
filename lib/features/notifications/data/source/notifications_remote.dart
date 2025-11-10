import '../../../../core/network/remote_request.dart';
import '../../../../core/network/urls.dart';
import '../model/notifications_model.dart';

class NotificationsRemoteDataSource {
  NotificationsRemoteDataSource();

  Future<List<NotificationsModel>> getNotifications() async {
    final response = await RemoteRequest.getData(url: AppURL.notification);

    return NotificationsModel.fromJsonList(response.data['data']);
  }

  Future<int> getUnreadCount() async {
    final res =
        await RemoteRequest.getData(url: AppURL.unreadNotificationCount);
    return (res.data['data']['counts'] as num?)?.toInt() ?? 0;
  }
  Future<void> markAsRead({required String id}) async {
    await RemoteRequest.postData(
      path: AppURL.markNotificationAsRead,
      data: {'id': id},
    );
  }
}
