import 'package:bloc/bloc.dart';

import '../../resources/firestore_methods.dart';

part 'firestore_event.dart';
part 'firestore_state.dart';

class FirestoreBloc extends Bloc<FirestoreEvent, FirestoreState> {
  FirestoreMethods firestoreMethods;
  FirestoreBloc(this.firestoreMethods) : super(FirestoreLoading()) {
    on<GetUserEvent>((event, emit) async {
      emit(FirestoreLoading());
      final userData = await firestoreMethods.getUserDetails();
      emit(FirestoreLoaded(userData: userData));
    });
  }
}
