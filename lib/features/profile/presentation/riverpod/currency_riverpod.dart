import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../../../core/state/data_state.dart';
import '../../../../../core/state/state.dart';
import '../../../../../services/auth/auth.dart';
import '../../data/model/currency_model.dart';
import '../../data/repos/profile_repo.dart';

final getAllCurrencies = StateNotifierProvider.autoDispose<GetAllCurrenciesController,
    DataState<List<CurrencyModel>>>(
      (ref) {
    return GetAllCurrenciesController();
  },
);

class GetAllCurrenciesController
    extends StateNotifier<DataState<List<CurrencyModel>>> {
  GetAllCurrenciesController()
      : super(DataState<List<CurrencyModel>>.initial([])) {
    getData();
  }

  final _controller = ProfileReposaitory();

  Future<void> getData() async {
    state = state.copyWith(state: States.loading);

    final data = await _controller.getAllCurrencies();
    data.fold((failure) {
      state = state.copyWith(state: States.error, exception: failure);
    }, (newData) {
      state = state.copyWith(state: States.loaded, data: newData);
    });
  }
}

final currencyProvider =
StateNotifierProvider<CurrencyController, String>((ref) {
  return CurrencyController();
});

class CurrencyController extends StateNotifier<String> {
  CurrencyController() : super("YER") {
    getCurrency();
  }

  Future<void> getCurrency() async {
    try {
      final savedLanguage = await Auth().getCurrency();
      state = savedLanguage;
    } catch (e) {

      state = "YER";
      debugPrint("Error loading currency: $e");
    }
  }

  Future<void> changeCurrency(String currency) async {
    try {
      await Auth().setCurrency(currency);
      state = currency;
    } catch (e) {
      debugPrint("Error changing currency: $e");
    }
  }
}
