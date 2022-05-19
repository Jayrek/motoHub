class RouteArgument {
  String? id;
  String? heroTag;
  dynamic param;

  RouteArgument({this.id, this.heroTag, this.param});

  @override
  String toString() {
    return 'RouteArgument {id: $id, heroTag: $heroTag, param: $param}';
  }
}
