// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_to_cart_bloc.dart';

abstract class AddToCartEvent extends Equatable {
  const AddToCartEvent();

  @override
  List<Object> get props => [];
}

class AddProductToDatabase extends AddToCartEvent {
  final ProductModel productModel;
  const AddProductToDatabase({
    required this.productModel,
  });
}

class DeleteProductFromCart extends AddToCartEvent {
  final String uid;
  const DeleteProductFromCart({
    required this.uid,
  });
}

class AddProductQuantityinCart extends AddToCartEvent {
  final String productUid;
  final ProductModel productModel;
  const AddProductQuantityinCart({
    required this.productUid,
    required this.productModel,
  });
}

class RemoveProductQuantityinCart extends AddToCartEvent {
  final String productUid;
  const RemoveProductQuantityinCart({
    required this.productUid,
  });
}
