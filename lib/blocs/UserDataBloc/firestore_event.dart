part of 'firestore_bloc.dart';

@immutable
abstract class FirestoreEvent {}

class GetUserEvent extends FirestoreEvent {}
