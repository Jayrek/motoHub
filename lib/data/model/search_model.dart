class SearchModel {
  String? latitude;
  String? longitude;
  String? item;

  SearchModel({this.latitude, this.longitude, this.item});

  @override
  String toString() {
    return 'SearchModel {latitude: $latitude, longitude: $longitude, item: $item}';
  }
}
