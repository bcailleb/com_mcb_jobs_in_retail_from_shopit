// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../utils/logger.dart';

class ProductModel {
  final String productName;
  final String imgUrl;
  final double price;
  final int discount;
  final List<dynamic> description;
  final String uid;
  final String category;
  final String sellerName;
  final String sellerUid;
  final int rating;
  final int numberOfRating;
  final int quantity;

  ProductModel({
    required this.productName,
    required this.imgUrl,
    required this.price,
    required this.discount,
    required this.description,
    required this.uid,
    required this.category,
    required this.sellerName,
    required this.sellerUid,
    required this.rating,
    required this.numberOfRating,
    this.quantity = 0,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
  try {
    return ProductModel(
      productName: json['productName'],
      imgUrl: json['imageUrl'],
      price: json['price'] as double,
      discount: json['discount'] as int,
      description: json['description'],
      uid: json['productUid'],
      category: json['category'],
      sellerName: json['sellerName'],
      sellerUid: json['sellerUid'],
      rating: json['rating'] as int,
      numberOfRating: json['numberOfRating'] as int,
      quantity: json['quantity'] as int,
    );
  }
  catch (e,s)
    {
      error(e.toString());
      error(s.toString());
      return ProductModel(
          productName: json['productName'],
          imgUrl: json['imageUrl'],
          price: double.parse(json['price']),
    discount: int.parse(json['discount)']),
    description: json['description'],
    uid: json['productUid'],
    category: json['category'],
    sellerName: json['sellerName'],
    sellerUid: json['sellerUid'],
    rating: int.parse(json['rating']),
    numberOfRating: int.parse(json['numberOfRating']),
    quantity: int.parse(json['quantity']),
      );
    }
  }

  Map<String, dynamic> getJson() {
    return {
      'productName': productName,
      'discount': discount,
      'imageUrl': imgUrl,
      'price': price,
      'description': description,
      'productUid': uid,
      'sellerName': sellerName,
      'sellerUid': sellerUid,
      'rating': rating,
      'numberOfRating': numberOfRating,
      'category': category,
      'quantity': quantity,
    };
  }

  Map<String, dynamic> getCartJson() {
    return {
      'productName': productName,
      'discount': discount,
      'imageUrl': imgUrl,
      'price': price,
      'description': description,
      'productUid': uid,
      'sellerName': sellerName,
      'sellerUid': sellerUid,
      'rating': rating,
      'numberOfRating': numberOfRating,
      'category': category,
      'quantity': quantity + 1,
    };
  }

static String collectionName = 'products';
  @override
  String toString() {
    return 'ProductModel(productName: $productName, imgUrl: $imgUrl, price: $price, discount: $discount, description: $description, uid: $uid, category: $category, sellerName: $sellerName, sellerUid: $sellerUid, rating: $rating, numberOfRating: $numberOfRating, quantity: $quantity)';
  }
}
