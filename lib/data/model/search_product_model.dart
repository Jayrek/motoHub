import 'dart:convert';

SearchProductModel searchProductModelFromJson(String str) =>
    SearchProductModel.fromJson(json.decode(str));

String searchProductModelToJson(SearchProductModel data) =>
    json.encode(data.toJson());

class SearchProductModel {
  SearchProductModel({
    this.statusCode,
    this.message,
    this.data,
  });

  int? statusCode;
  String? message;
  List<Datum>? data;

  factory SearchProductModel.fromJson(Map<String, dynamic> json) =>
      SearchProductModel(
        statusCode: json["status_code"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };

  @override
  String toString() {
    return 'SearchProductModel {statusCode: $statusCode, message: $message, data: $data}';
  }
}

class Datum {
  Datum({
    this.productName,
    this.productPrice,
    this.storeName,
    this.storeLocation,
    this.motorcyleType,
    this.distance,
  });

  String? productName;
  int? productPrice;
  String? storeName;
  String? storeLocation;
  String? motorcyleType;
  double? distance;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        productName: json["product_name"],
        productPrice: json["product_price"],
        storeName: json["store_name"],
        storeLocation: json["store_location"],
        motorcyleType: json["motorcyle_type"],
        distance: json["distance"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "product_name": productName,
        "product_price": productPrice,
        "store_name": storeName,
        "store_location": storeLocation,
        "motorcyle_type": motorcyleType,
        "distance": distance,
      };

  @override
  String toString() {
    return 'Datum {productName: $productName, productPrice: $productPrice, storeName: $storeName, storeLocation: $storeLocation, motorcyleType: $motorcyleType, distance: $distance}';
  }
}
