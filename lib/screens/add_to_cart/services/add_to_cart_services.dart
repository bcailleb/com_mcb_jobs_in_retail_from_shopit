import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../../models/userdetail_model.dart';
import '../../../models/cart_model.dart';
import '../../../utils/logger.dart';
import '../../../utils/message_constant.dart';

import '../../../models/product_model.dart';
import '../../../resources/storage_methods.dart';

class AddToCartServices {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  StorageMethods storageMethods = StorageMethods();
  String getUid = FirebaseAuth.instance.currentUser!.uid;

  Future<String> addProductToCart(
    ProductModel productModel,
  ) async {
    String result = constSomethingWrong;
    try {
      await firestore
          .collection(UserDetailModel.collectionName)
          .doc(firebaseAuth.currentUser!.uid)
          .collection(CartModel.collectionName)
          .doc(productModel.uid)
          .set(productModel.getCartJson());

      result = constAddedToCart;
    } catch (e) {
      result = e.toString();
    }
    return result;
  }

  Future<String> deleteProductFromCart(String uid) async {
    String result = constSomethingWrong;
    try {
      await firestore
          .collection(UserDetailModel.collectionName)
          .doc(firebaseAuth.currentUser!.uid)
          .collection(CartModel.collectionName)
          .doc(uid)
          .delete();
      result = 'Product deleted sucessfully';
    } catch (e) {
      result = e.toString();
    }
    return result;
  }

  Future getSubtotalCartPrice(String uid) async {
    QuerySnapshot priceData = await firestore
        .collection(UserDetailModel.collectionName)
        .doc(getUid)
        .collection(CartModel.collectionName)
        .where('price')
        .get();
        return priceData;
  }

  Future<int> getProductQuantity(String productUid) async {
    DocumentSnapshot productQuantity = await firestore
        .collection(UserDetailModel.collectionName)
        .doc(getUid)
        .collection(CartModel.collectionName)
        .doc(productUid)
        .get();
    return productQuantity['quantity'];
  }

  Future updateAddToCartProduct(
    String productUid,
  ) async {
    int quantity = await AddToCartServices().getProductQuantity(productUid);
    await firestore
        .collection(UserDetailModel.collectionName)
        .doc(getUid)
        .collection(CartModel.collectionName)
        .doc(productUid)
        .update({
      'quantity': quantity + 1,
    });

    info(quantity.toString());
  }

  Future checkProductinCart(String productUid) async {
    bool isAdded = false;

    QuerySnapshot<Map<String, dynamic>> snap = await firestore
        .collection(UserDetailModel.collectionName)
        .doc(getUid)
        .collection(CartModel.collectionName)
        .where('productUid', isEqualTo: productUid)
        .get();
    info(snap.docs.length.toString());
    if (snap.docs.isNotEmpty) {
      isAdded = true;
    } else {
      isAdded = false;
    }
    return isAdded;
  }

  Future<String> removeProductQuantity(String uid, int quantity) async {
    String result = constSomethingWrong;

    await firestore
        .collection(UserDetailModel.collectionName)
        .doc(getUid)
        .collection(CartModel.collectionName)
        .doc(uid)
        .update({
      'quantity': quantity - 1,
    });
    result = 'Product removed sucessfully';

    return result;
  }
}
