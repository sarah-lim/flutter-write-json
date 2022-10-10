
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_write_json/product.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductFormModel extends ChangeNotifier {

  var _product = Product.empty();

  Product get product => _product;

  set product(Product product) {
    _product = product;
    notifyListeners();
  }

  writeJson() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/product.json');
    await file.writeAsString(jsonEncode(product).toString());
    await _openPath(file, directory);
  }

  _openPath(File file, Directory directory) async {
    if (!File(file.uri.toFilePath()).existsSync()) {
      throw '${file.uri} does not exist!';
    }

    if (!await launchUrl(directory.uri)) {
      throw 'Could not launch ${directory.uri}';
    }
  }
}