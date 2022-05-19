import 'package:flutter/material.dart';

import '../data/model/search_product_model.dart';
import '../data/repository/repository_interface.dart';

class SearchViewModel extends ChangeNotifier {
  final Repository _repository;

  SearchViewModel(this._repository);

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  bool _iSSuccess = false;

  bool get iSSuccess => _iSSuccess;

  Future<SearchProductModel> searchProduct(
      String lat, String long, String product) async {
    try {
      // onProgress();
      final response = await _repository.searchItem(lat, long, product);
      // var officials = jsonEncode(response);
      debugPrint('response: $response');
      return response;
    } catch (e) {
      onDoneWithException();
      throw Exception(e.toString());
    }
  }

  void onProgress() {
    _isLoading = true;
    notifyListeners();
  }

  void onDone() {
    _isLoading = false;
    _iSSuccess = true;
    notifyListeners();
  }

  void onDoneWithException() {
    _isLoading = false;
    _iSSuccess = false;
    notifyListeners();
  }
}
