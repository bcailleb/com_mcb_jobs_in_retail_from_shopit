import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../../components/product_widget.dart';
import '../../../models/address_model.dart';
import '../../../models/order_model.dart';
import '../../../models/cart_model.dart';
import '../../../models/product_model.dart';
import '../../../models/userdetail_model.dart';

class OrderServices {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String userId = FirebaseAuth.instance.currentUser!.uid;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future uploadUserAddress(AddressModel address) async {
    await firestore
        .collection(UserDetailModel.collectionName)
        .doc(userId)
        .collection(AddressModel.collectionName)
        .doc(const Uuid().v1())
        .set(address.getJson());
  }

  Future<List<ProductModel>> getOrderedProducts() async {
    List<ProductModel> products = [];
    QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
        .collection(UserDetailModel.collectionName)
        .doc(userId)
        .collection(CartModel.collectionName)
        .get();

    for(var snap in snapshot.docs) {
      ProductModel product = ProductModel.fromJson(snap.data());
      products.add(product);
    }
    return products;
  }

  Future uploadOrderedProductsToUser() async {
    List<ProductModel> products = await OrderServices().getOrderedProducts();

    products.forEach((product) async {
      await firestore
          .collection(UserDetailModel.collectionName)
          .doc(userId)
          .collection(OrderModel.collectionName)
          .doc(product.uid)
          .set(product.getJson());
    });
  }

  Future uploadOrderToDatabse({
    required List<ProductModel> products,
    required String totalPrice,
    required String shippingAddress,
    required String buyerId,
    required int orderStatus,
  }) async {
    String orderNumber = const Uuid().v4();

    OrderModel order = OrderModel(
      totalPrice: totalPrice,
      orderNumber: orderNumber,
      shippingAddress: shippingAddress,
      buyerId: buyerId,
      orderedAt: DateTime.now(),
    );
    products.forEach((product) async {
      await firestore
          .collection(OrderModel.collectionName)
          .doc(orderNumber)
          .collection(ProductModel.collectionName)
          .doc(product.uid)
          .set(product.getJson());
    });
    await firestore.collection(OrderModel.collectionName).doc(orderNumber).set(order.getJson());
    await OrderServices().uploadOrderedProductsToUser();
  }

  Future getOrderDetails(String buyerId) async {
    List<OrderModel> ordersList = [];
    final QuerySnapshot<Map<String, dynamic>> orders = await firestore
        .collection(OrderModel.collectionName)
        .where('buyerId', isEqualTo: buyerId)
        .get();
    for (var element in orders.docs) {
      OrderModel order = OrderModel.fromJson(element.data());
      ordersList.add(order);
    }
  }

  Stream<List<Widget>> showOrdersToUser() async* {
    List<Widget> orderedProducts = [];
    Stream<QuerySnapshot<Map<String, dynamic>>> snapshot = FirebaseFirestore
        .instance
        .collection(UserDetailModel.collectionName)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(OrderModel.collectionName)
        .snapshots();

    snapshot.forEach(
      (snap) {
        for(var element in snap.docs) {
          ProductModel product = ProductModel.fromJson(element.data());
          orderedProducts.add(
            ProductWidget(productModel: product),
          );
        }
      },
    );
    yield orderedProducts;
  }
}

// Future getProductsfromCart(String buyerId, String orderId) async {
//     List<OrderModel> orderedProdcuts = [];
//     List<ProductModel> prodcutList = [];

//     final QuerySnapshot<Map<String, dynamic>> products = await firestore
//         .collection(OrderModel.collectionName)
//         .doc(orderId)
//         .collection(ProductModel.collectionName)
//         .get();

//     products.docs.forEach((element) {
//       ProductModel product = ProductModel.fromJson(
//         element.data(),
//       );
//       // ProductModel product = ProductModel.fromJson(element['products'].docs);

//       prodcutList.add(product);
//     });

//     print(prodcutList);

//     // products.docs.forEach((element) {
//     //   ProductModel product = ProductModel.fromJson(element['products']);
//     //   orderedProdcuts.add(product);
//     // });
//   }