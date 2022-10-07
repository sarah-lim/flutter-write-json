
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_write_json/product.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductForm extends StatefulWidget {
  const ProductForm({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ProductForm();
  }
}

class _ProductForm extends State<ProductForm> {
  final _formKey = GlobalKey<FormBuilderState>();

  var spaceBetweenComponentsH = const SizedBox(height: 30.0,);
  var productTypes = ['A', 'B', 'C'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('JSON File builder'),),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormBuilder(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Product name'),
                      FormBuilderTextField(name: 'product_name',),
                      spaceBetweenComponentsH,
                      const Text('Product details'),
                      FormBuilderTextField(name: 'product_details',),
                      spaceBetweenComponentsH,
                      const Text('Number of stocks'),
                      FormBuilderTextField(name: 'stocks',),
                      spaceBetweenComponentsH,
                      FormBuilderSwitch(title: const Text('Frozen'), name: 'frozen', initialValue: false,),
                      spaceBetweenComponentsH,
                      FormBuilderSwitch(title: const Text('Active'), name: 'active', initialValue: false,),
                      spaceBetweenComponentsH,
                      FormBuilderRadioGroup(name: 'type',
                        initialValue: productTypes.first,
                        options: productTypes.map((e) =>
                        FormBuilderFieldOption(value: e, child: Text(e),)).toList(),)
                    ],
                  )),
              spaceBetweenComponentsH,
              ElevatedButton(onPressed: _convertToJson, child: const Text("Create JSON File"))
            ],
          ),
        ),
      ),
    );
  }

  _convertToJson() {
    var formState = _formKey.currentState;

    var productName = formState?.fields['product_name']?.value;
    var productDetails = formState?.fields['product_details']?.value;
    var stocks = formState?.fields['stocks']?.value;
    var frozen = formState?.fields['frozen']?.value;
    var active = formState?.fields['active']?.value;
    var type = formState?.fields['type']?.value;

    var product = Product(productName, productDetails, int.parse(stocks), frozen, active, type);
    print(jsonEncode(product));
    _write(jsonEncode(product).toString());
  }

  _write(String json) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/product.json');
    await file.writeAsString(json);
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