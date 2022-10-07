// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      json['product_name'] as String,
      json['product_details'] as String,
      json['stocks'] as int,
      json['frozen'] as bool,
      json['active'] as bool,
      json['type'] as String,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'product_name': instance.productName,
      'product_details': instance.productDetails,
      'stocks': instance.stocks,
      'frozen': instance.frozen,
      'active': instance.active,
      'type': instance.type,
    };
