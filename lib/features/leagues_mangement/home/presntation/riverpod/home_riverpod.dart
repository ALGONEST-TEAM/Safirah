import 'package:flutter_riverpod/legacy.dart';

import '../../../../../core/state/data_state.dart';
import '../../../../../core/state/pagination_data/paginated_model.dart';
import '../../../../../core/state/state.dart';
import '../../data/models/home_model.dart';
import '../../data/models/news_item_model.dart';
import '../../data/repos/home_repo.dart';

final getAllItemsLeagueHomeProvider =
    StateNotifierProvider<GetAllItemsLeagueHomeNotifier, DataState<HomeModel>>(
  (ref) {
    return GetAllItemsLeagueHomeNotifier();
  },
);

class GetAllItemsLeagueHomeNotifier
    extends StateNotifier<DataState<HomeModel>> {
  GetAllItemsLeagueHomeNotifier() : super(DataState.initial(HomeModel.empty())) {
    getData();
  }

  final _controller = HomeReposaitory();

  Future<void> getData() async {
    state = state.copyWith(state: States.loading);

    final data = await _controller.getAllItemsLeagueHome();
    data.fold((failure) {
      state = state.copyWith(state: States.error, exception: failure);
    }, (newData) {
      state = state.copyWith(state: States.loaded, data: newData);
    });
  }
}

final getAllLatestNewsProvider = StateNotifierProvider.autoDispose<
    GetAllLatestNewsNotifier,
    DataState<PaginationModel<NewsItemModel>>>(
      (ref) {
    return GetAllLatestNewsNotifier();
  },
);

class GetAllLatestNewsNotifier
    extends StateNotifier<DataState<PaginationModel<NewsItemModel>>> {
  GetAllLatestNewsNotifier()
      : super(DataState<PaginationModel<NewsItemModel>>.initial(
      PaginationModel.empty())) {
    getData();
  }

  final _controller = HomeReposaitory();

  Future<void> getData({bool moreData = false}) async {
    if (moreData && state.data.currentPage >= state.data.lastPage) {
      return;
    }
    if (moreData) {
      state = state.copyWith(state: States.loadingMore);
    } else {
      state = state.copyWith(state: States.loading);
    }

    final nextPage = moreData ? state.data.currentPage + 1 : 1;

    final result = await _controller.getAllLatestNews(nextPage);

    result.fold(
          (failure) {
        state = state.copyWith(state: States.error, exception: failure);
      },
          (newData) {
        state = state.success(newData, moreData);
      },
    );
  }
}


final newsDetailsProvider = StateNotifierProvider
    .family<NewsDetailsController, DataState<NewsItemModel>, int>(
      (ref, int id) {
    return NewsDetailsController(id);
  },
);

class NewsDetailsController
    extends StateNotifier<DataState<NewsItemModel>> {
  final int id;

  NewsDetailsController(this.id)
      : super(DataState<NewsItemModel>.initial(NewsItemModel.empty())) {
    getData();
  }

  final _controller = HomeReposaitory();

  Future<void> getData() async {
    state = state.copyWith(state: States.loading);
    final data = await _controller.newsDetails(id: id);
    data.fold(
          (failure) {
        state = state.copyWith(state: States.error, exception: failure);
      },
          (orderDetailsData) {
        state = state.copyWith(
          state: States.loaded,
          data: orderDetailsData,
        );
      },
    );
  }
}