import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:motohub/data/repository/repository_interface.dart';

import '../model/search_product_model.dart';

class RepositoryImpl implements Repository {
  static const _baseUrl = 'http://moto-store-finder.herokuapp.com/api';

  @override
  Future<SearchProductModel> searchItem(
      String latitude, String longitude, String productName) async {
    final reqBody = jsonEncode({
      'latitude_from': latitude,
      'longitude_from': longitude,
      'product_name': productName
    });
    final response =
        await Dio().post('$_baseUrl/product-area/search-item', data: reqBody);
    return searchProductModelFromJson(response.toString());
  }
}
