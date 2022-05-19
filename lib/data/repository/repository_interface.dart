import '../model/search_product_model.dart';

abstract class Repository {
  Future<SearchProductModel> searchItem(
      String latitude, String longitude, String productName);
}
