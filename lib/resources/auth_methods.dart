import 'package:firebase_auth/firebase_auth.dart';
import '../models/userdetail_model.dart';
import '../resources/firestore_methods.dart';
import '../utils/message_constant.dart';

class AuthMethods {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirestoreMethods firestoreMethods = FirestoreMethods();

  Future<String> signUpUser(
      {required String name,
      required String address,
      required String email,
      required String password}) async {
    name.trim();
    address.trim();
    email.trim();
    password.trim();
    String output = constSomethingWrong;
    if (name != "" && address != "" && email != "" && password != "") {
      try {
        await firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password);
        UserDetailModel user = UserDetailModel(
          name: name,
          address: address,
        );
        await firestoreMethods.uploadUserDetails(user: user);

        output = constRegistrationSuccess;
      } on FirebaseAuthException catch (e) {
        output = e.message.toString();
      }
    } else {
      output = constFillFields;
    }
    return output;
  }

  Future<String> signInUser(
      {required String email, required String password}) async {
    email.trim();
    password.trim();
    String output = constSomethingWrong;
    if (email != "" && password != "") {
      try {
        await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
        output = constLoginSucces;
      } on FirebaseAuthException catch (e) {
        output = e.code.toString();
      }
    } else {
      output = constFillFields;
    }
    return output;
  }
}
