import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  List<dynamic>? products;
  final String totalPrice;
  final String shippingAddress;
  final String buyerId;
  final DateTime orderedAt;
  final String orderNumber;
  final int orderStatus; // 0 = pending, 1= shipped, 2= received, 3= delivered

  OrderModel({
    this.products,
    required this.totalPrice,
    required this.shippingAddress,
    required this.buyerId,
    required this.orderedAt,
    this.orderStatus = 0,
    required this.orderNumber,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      products: json['products'],
      totalPrice: json['totalPrice'],
      shippingAddress: json['shippingAddress'],
      buyerId: json['buyerId'],
      orderedAt: (json['orderedAt'] as Timestamp).toDate(),
      orderNumber: json['orderNumber'],
    );
  }

  Map<String, dynamic> getJson() {
    return {
      'totalPrice': totalPrice,
      'shippingAddress': shippingAddress,
      'buyerId': buyerId,
      'orderedAt': orderedAt,
      'orderStatus': orderStatus,
      'orderNumber': orderNumber,
    };
  }
 static String collectionName = 'orders';
  @override
  String toString() {
    return 'OrderModel(product: $products, totalPrice: $totalPrice, shippingAddress: $shippingAddress, buyerId: $buyerId, orderNumber: $orderNumber, orderedAt: $orderedAt)';
  }
}
