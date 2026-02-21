import '../../../../../core/network/remote_request.dart';
import '../../../../../core/network/urls.dart';
import '../../../../../core/state/pagination_data/paginated_model.dart';
import '../models/home_model.dart';
import '../models/news_item_model.dart';

class HomeRemoteDataSource {
  Future<HomeModel> getAllItemsLeagueHome() async {
    final response = await RemoteRequest.getData(url: AppURL.leagueHome);
    return HomeModel.fromJson(response.data['data']);
  }

  Future<PaginationModel<NewsItemModel>> getAllLatestNews(int page) async {
    final response = await RemoteRequest.getData(
      url: AppURL.news,
      query: {'page': page},
    );
    return PaginationModel<NewsItemModel>.fromJson(
      response.data['data'] ?? response.data,
      (book) {
        return NewsItemModel.fromJson(book);
      },
    );
  }
  Future<NewsItemModel> newsDetails({
    required int id,
  }) async {
    final response = await RemoteRequest.getData(
      url: "${AppURL.news}/$id",
    );
    return NewsItemModel.fromJson(response.data['data']);
  }
}
