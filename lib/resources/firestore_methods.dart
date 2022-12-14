
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../models/userdetail_model.dart';
import '../resources/storage_methods.dart';

class FirestoreMethods {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  StorageMethods storageMethods = StorageMethods();

  Future uploadUserDetails({required UserDetailModel user}) async {
    await firestore.collection(UserDetailModel.collectionName).doc(firebaseAuth.currentUser!.uid).set(
          user.getJson(),
        );
  }

  Future<UserDetailModel> getUserDetails() async {
    final userSnap = await firestore
        .collection(UserDetailModel.collectionName)
        .doc(firebaseAuth.currentUser!.uid)
        .get();

    final userData = UserDetailModel.fromJson(userSnap.data()!);

    return userData;
  }
}
  
//   Stream<List<ProductModel>> getAllProducts() {
//     return firestore.collection(ProductModel.collectionName).snapshots().map((snapshot) {
//       return snapshot.docs
//           .map((doc) => ProductModel.fromSnapshot(doc))
//           .toList();
//     });
//   }

