import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../../core/state/data_state.dart';
import '../../../../../../core/state/state.dart';
import '../../data/model/reviews_model.dart';
import '../../data/model/reviews_pagination_model.dart';
import '../../data/repos/reviews_repo.dart';

final getAllReviewsProvider = StateNotifierProvider.autoDispose
    .family<GetAllReviewsController, DataState<ReviewsModel>, int>(
  (ref, int productId) {
    return GetAllReviewsController(productId);
  },
);

class GetAllReviewsController extends StateNotifier<DataState<ReviewsModel>> {
  final int productId;

  GetAllReviewsController(this.productId)
      : super(DataState<ReviewsModel>.initial(ReviewsModel.empty())) {
    getData();
  }

  final _controller = ReviewsReposaitory();

  Future<void> getData({
    bool moreData = false,
  }) async {
    if (moreData &&
        state.data.review.currentPage >= state.data.review.lastPage) {
      return;
    }
    if (state.stateData == States.loadingMore ||
        state.stateData == States.loading) {
      return;
    }

    if (moreData) {
      state = state.copyWith(state: States.loadingMore);
    } else {
      state = state.copyWith(state: States.loading);
    }

    int page = state.data.review.currentPage + 1;
    final data = await _controller.getAllReviews(
      productId: productId,
      page: page,
    );
    data.fold(
      (failure) {
        state = state.copyWith(state: States.error, exception: failure);
      },
      (newData) {
        var oldData = state.data;

        if (oldData.rates != 0.0) {
          PaginatedReviewsModel commentData;
          commentData = oldData.review.copyWith(
            data: [...oldData.review.data, ...newData.review.data],
            currentPage: newData.review.currentPage,
          );
          oldData = oldData.copyWith(review: commentData);
        } else {
          oldData = newData;
        }
        state = state.copyWith(state: States.loaded, data: oldData);
      },
    );
  }
}

final addReviewsProvider =
    StateNotifierProvider.autoDispose<AddReviewsController, DataState<Unit>>(
  (ref) {
    return AddReviewsController();
  },
);

class AddReviewsController extends StateNotifier<DataState<Unit>> {
  AddReviewsController() : super(DataState<Unit>.initial(unit));
  final _controller = ReviewsReposaitory();

  Future<void> addReviews({
    required int orderId,
    required int productId,
    required dynamic colorId,
    required int sizeId,
    required String comment,
    required double evaluation,
    required int proportion,
    required List<File> images,
  }) async {
    state = state.copyWith(state: States.loading);
    final data = await _controller.addReviews(
      orderId,
      productId,
      colorId,
      sizeId,
      comment,
      evaluation,
      proportion,
      images,
    );
    data.fold((f) {
      state = state.copyWith(state: States.error, exception: f);
    }, (data) {
      state = state.copyWith(state: States.loaded);
    });
  }
}

final addLikeOrDislikeProvider = StateNotifierProvider.autoDispose
    .family<AddLikeOrDislikeController, DataState<Unit>, int>(
  (ref, int commentId) {
    return AddLikeOrDislikeController(commentId);
  },
);

class AddLikeOrDislikeController extends StateNotifier<DataState<Unit>> {
  AddLikeOrDislikeController(this.commentId) : super(DataState.initial(unit));

  final int commentId;
  final _controller = ReviewsReposaitory();

  Future<void> addLike() async {
    state = state.copyWith(state: States.loading);
    final data = await _controller.addLike(commentId);
    data.fold((f) {
      state = state.copyWith(state: States.error, exception: f);
    }, (data) {
      state = state.copyWith(state: States.loaded);
    });
  }

  Future<void> dislike() async {
    state = state.copyWith(state: States.loading);
    final data = await _controller.dislike(commentId);
    data.fold((f) {
      state = state.copyWith(state: States.error, exception: f);
    }, (data) {
      state = state.copyWith(state: States.loaded);
    });
  }
}
