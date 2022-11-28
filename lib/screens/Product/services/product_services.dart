import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:com_mcb_jobs_in_retail_from_shopit/utils/logger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import '../../../models/product_model.dart';
import '../../../models/review_model.dart';
import '../../../widgets/product_widget.dart';
import '../../../widgets/result_widgets.dart';
import 'package:uuid/uuid.dart';

import '../../../utils/message_constant.dart';
import '../../../resources/storage_methods.dart';

class ProductServices {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  StorageMethods storageMethods = StorageMethods();
  String getUid = FirebaseAuth.instance.currentUser!.uid;

  Future<String> uploadProductToDatabse({
    required Uint8List? image,
    required String productName,
    required String rawCost,
    required int productDiscount,
    required List<dynamic> productDescription,
    required String sellerName,
    required String sellerUid,
    required String category,
    required int quantity,
  }) async {
    productName.trim();
    rawCost.trim();
    String output = constSomethingWrong;

    if (image != null) {
      try {
        String productUid = const Uuid().v1();
        String imageUrl =
            await storageMethods.uploadImageToStorage(productUid, image);
        double cost = double.parse(rawCost);
        cost = cost - (cost * (productDiscount / 100));
        ProductModel product = ProductModel(
          productName: productName,
          imgUrl: imageUrl,
          price: cost,
          discount: productDiscount,
          description: productDescription,
          uid: productUid,
          sellerName: sellerName,
          sellerUid: sellerUid,
          rating: 5,
          numberOfRating: 0,
          category: category,
          quantity: 0,
        );

        await firestore
            .collection(ProductModel.collectionName)
            .doc(productUid)
            .set(product.getJson());

        output = 'Product added sucessfully';
      } catch (e) {
        output = e.toString();
      }
    } else {
      output = 'Please fill all the required fields';
    }
    return output;
  }

  Future<String> uploadReviewToDatabase({
    required String senderName,
    required int userRating,
    required String description,
    required String productUid,
  }) async {
    String reviewUid = const Uuid().v1();
    String output = constSomethingWrong;
    try {
      ReviewModel review = ReviewModel(
        senderName: senderName,
        userRating: userRating,
        description: description,
      );
      await firestore
          .collection(ProductModel.collectionName)
          .doc(productUid)
          .collection(ReviewModel.collectionName)
          .doc(reviewUid)
          .set(review.getJson());
      output = 'Review added sucessfully';
    } catch (e) {
      output = e.toString();
    }
    return output;
  }

  Future<List<Widget>> getProductDataFromDiscount(int discount) async {
    List<Widget> products = [];
    QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
        .collection(ProductModel.collectionName)
        .where('discount', isEqualTo: discount)
        .get();
    for(var snap in snapshot.docs) {
      ProductModel product = ProductModel.fromJson(snap.data());
      products.add(
        ProductWidget(productModel: product),
      );
    }
    return products;
  }

  Future<List<Widget>> getProductData() async {
    List<Widget> products = [];
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await firestore.collection(ProductModel.collectionName).get();

    for(var snap in snapshot.docs) {
      ProductModel product = ProductModel.fromJson(snap.data());
      products.add(
        ProductWidget(productModel: product),
      );
    }
    return products;
  }

  Future<List<Widget>> getProductsByCategory(String category) async {
    List<Widget> products = [];
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
          .collection(ProductModel.collectionName)
          .where('category', isEqualTo: category)
          .get();

      for(var snap in snapshot.docs) {
        ProductModel product = ProductModel.fromJson(snap.data());
        products.add(
          ResultsWidget(
            product: product,
          ),
        );
      }
    } catch (e) {
      info(e.toString());
    }
    return products;
  }

  // }
}
