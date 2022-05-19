class LocationModel {
  double? latitude;
  double? longitude;
  String? addressName;

  LocationModel({
    this.latitude,
    this.longitude,
    this.addressName,
  });

  @override
  String toString() {
    return 'LocationModel {latitude: $latitude, longitude: $longitude, addressName: $addressName}';
  }

  Stream myLocation() {
    return LocationModel(
        latitude: latitude, longitude: longitude, addressName: '') as Stream;
  }
}
