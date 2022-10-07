
import 'package:json_annotation/json_annotation.dart';
part 'product.g.dart';

@JsonSerializable()
class Product {
  Product(
      this.productName,
      this.productDetails,
      this.stocks,
      this.frozen,
      this.active,
      this.type
      );

  @JsonKey(name: "product_name")
  String productName;

  @JsonKey(name: "product_details")
  String productDetails;
  int stocks;
  bool frozen;
  bool active;
  String type;

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}