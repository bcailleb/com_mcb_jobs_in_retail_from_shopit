// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'product_bloc.dart';

@immutable
abstract class ProductEvent {
  final ProductModel? productModel;
  const ProductEvent({
    this.productModel,
  });
}

class UploadProductEvent extends ProductEvent {
  final Uint8List? image;
  final String productName;
  final String rawCost;
  final int productDiscount;
  final List<dynamic> productDescription;
  final String sellerName;
  final String sellerUid;
  final String category;
  final int quantity;
  final BuildContext context;
  const UploadProductEvent({
    required this.image,
    required this.productName,
    required this.rawCost,
    required this.productDiscount,
    required this.productDescription,
    required this.sellerName,
    required this.sellerUid,
    required this.context,
    required this.category,
    this.quantity = 0,
  });
}

class GetProductDataEvent extends ProductEvent {}
