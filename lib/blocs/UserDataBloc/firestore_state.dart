part of 'firestore_bloc.dart';

abstract class FirestoreState {
  var userData;
  FirestoreState({
    this.userData,
  });
}

class FirestoreLoading extends FirestoreState {}

class FirestoreLoaded extends FirestoreState {
  FirestoreLoaded({required super.userData});
}
