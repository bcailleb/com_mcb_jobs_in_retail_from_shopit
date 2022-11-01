import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/AddToCart/add_to_cart_bloc.dart';
import '../blocs/AuthBloc/auth_bloc.dart';
import '../blocs/ProductDataBloc/product_bloc.dart';
import '../blocs/UserDataBloc/firestore_bloc.dart';
import '../layout/screen_layout.dart';
import '../resources/auth_methods.dart';
import '../resources/firestore_methods.dart';
import '../screens/Product/services/product_services.dart';
import '../screens/add_to_cart/services/add_to_cart_services.dart';
import '../screens/signin_screen.dart';
import '../utils/color_themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
          apiKey: "AIzaSyAm5IXn9jDbEqsTubso7r15pOLIy2B1XJg",
          appId: "1:683605207521:web:f2d478c3e434995b8c0aa0",
          messagingSenderId: "683605207521",
          projectId: "jobs-in-retail",
          authDomain: "jobs-in-retail.firebaseapp.com",
          databaseURL:
          "https://jobs-in-retail-default-rtdb.europe-west1.firebasedatabase.app",
          storageBucket: "jobs-in-retail.appspot.com",
        ));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthMethods(),
        ),
        RepositoryProvider(
          create: (context) => ProductServices(),
        ),
        RepositoryProvider(
          create: (context) => FirestoreMethods(),
        ),
        RepositoryProvider(
          create: (context) => AddToCartServices(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
              RepositoryProvider.of<AuthMethods>(context),
            ),
          ),
          BlocProvider(
            create: (context) =>
                FirestoreBloc(RepositoryProvider.of<FirestoreMethods>(context))
                  ..add(getUserEvent()),
          ),
          BlocProvider(
            create: (context) => ProductBloc(
              RepositoryProvider.of<ProductServices>(context),
            ),
          ),
          BlocProvider(
            create: (context) => AddToCartBloc(
              RepositoryProvider.of<AddToCartServices>(context),
            ),
          )
        ],
        child: MaterialApp(
          title: 'Shop it',
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light().copyWith(
            scaffoldBackgroundColor: backgroundColor1,
          ),
          // To check whether user is logged in or not. If not than it will show the login screen to the user. If yes than user will get the homepage.

          home: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, AsyncSnapshot<User?> user) {
                if (user.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: buttonColor,
                    ),
                  );
                } else if (user.hasData) {
                  return ScreenLayout();
                } else {
                  return SigninScreen();
                }
              }),
        ),
      ),
    );
  }
}
