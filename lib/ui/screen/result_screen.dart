import 'package:flutter/material.dart';
import 'package:motohub/data/model/route_argument.dart';
import 'package:motohub/data/model/search_model.dart';
import 'package:motohub/util/string_util.dart';
import 'package:provider/provider.dart';

import '../../data/model/search_product_model.dart';
import '../../util/widget_util.dart';
import '../../vmodel/search_vmodel.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({Key? key, required this.routeArgument}) : super(key: key);
  final RouteArgument routeArgument;

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  var itemCount = 2;
  var itemSearch = '';

  late SearchModel searchModel;
  var _isLoading = false;
  List<Datum> _listProducts = [];

  @override
  void initState() {
    super.initState();
    searchModel = widget.routeArgument.param;
    getNearestProducts(searchModel.latitude.toString(),
        searchModel.longitude.toString(), searchModel.item.toString());
  }

  Future<void> getNearestProducts(
      String lat, String long, String product) async {
    try {
      setState(() => _isLoading = true);
      final provider = Provider.of<SearchViewModel>(context, listen: false);
      final response = await provider.searchProduct(lat, long, product);
      if (response.statusCode == 1) {
        setState(() {
          _isLoading = false;
          _listProducts = response.data!;
        });
        debugPrint('ITEMS: $response');
      } else {
        setState(() => _isLoading = false);
        showSnackBar(context, response.message.toString());
      }
    } catch (e) {
      setState(() => _isLoading = false);
      showSnackBar(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(searchModel.item.toString(),
                style: const TextStyle(fontSize: 18)),
            actions: [
              Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text('${_listProducts.length} : item(s)',
                      style: const TextStyle(fontWeight: FontWeight.bold)))
            ]),
        body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          _isLoading
              ? const Center(
                  child: Padding(
                      padding: EdgeInsets.all(40),
                      child: SizedBox(child: CircularProgressIndicator())))
              : Expanded(
                  child: _listProducts.isEmpty
                      ? const Padding(
                          padding: EdgeInsets.all(15),
                          child: Text('Searched product is not available.',
                              style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: Colors.red,
                                  fontWeight: FontWeight.w500)))
                      : listViewWidget())
        ]));
  }

  Widget listViewWidget() {
    return ListView.separated(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        separatorBuilder: (context, index) {
          return const Divider(height: 1, endIndent: 20, indent: 20);
        },
        itemCount: _listProducts.length,
        itemBuilder: (context, index) {
          Datum data = _listProducts[index];
          return listItem(data);
        });
  }

  Widget listItem(Datum data) {
    return Container(
        padding: const EdgeInsets.all(10),
        child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            elevation: 3,
            child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(data.productName.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text(data.motorcyleType.toString()),
                      Text(data.storeName.toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black45))
                    ]),
                subtitle: ListTile(
                    horizontalTitleGap: 5,
                    minLeadingWidth: 5,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 1),
                    leading: const Padding(
                        padding: EdgeInsets.all(8),
                        child:
                            Icon(Icons.location_on_rounded, color: Colors.red)),
                    title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                              padding: EdgeInsets.only(bottom: 8),
                              child: Divider(height: 1)),
                          Text(data.storeLocation.toString(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black45))
                        ]),
                    subtitle: Row(children: [
                      Text('${data.distance?.toStringAsFixed(2).toString()} km',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black45)),
                      const SizedBox(width: 5),
                      Text(_listProducts[0] == data ? 'Nearest item' : '',
                          style: const TextStyle(
                              color: Colors.red, fontStyle: FontStyle.italic))
                    ])),
                trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                  const Text('php'),
                  Flexible(
                      child: Text(' ${data.productPrice.toString()}',
                          style: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold)))
                ]),
                onTap: () {
                  Navigator.of(context).pushNamed(mapScreen,
                      arguments: SearchModel(
                          latitude: data.lat,
                          longitude: data.long,
                          item: data.storeName));

                  debugPrint(data.storeLocation.toString());
                })));
  }
}
