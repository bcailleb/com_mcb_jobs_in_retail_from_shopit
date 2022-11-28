import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../blocs/UserDataBloc/firestore_bloc.dart';
import '../screens/Order/services/order_services.dart';
import '../screens/sell_screen.dart';
import '../utils/color_themes.dart';
import '../utils/constants.dart';
import '../widgets/account_screen_appbar.dart';
import '../widgets/Buttons/primary_widget_button.dart';
import '../widgets/product_show_list.dart';

import '../utils/utils.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AccountScreenAppBar(),
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenSize.height,
          width: screenSize.width,
          child: Column(children: [
            const UserIntroWidget(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: PrimaryWidgetButton(
                color: buttonColor,
                isLoading: false,
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
                child: const Text('Sign Out'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: PrimaryWidgetButton(
                color: lightbuttonColor,
                isLoading: false,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SellScreen(),
                    ),
                  );
                },
                child: const Text('Sell'),
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: StreamBuilder(
                stream: OrderServices().showOrdersToUser(),
                builder: (context, AsyncSnapshot<List<Widget>> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: buttonColor,
                      ),
                    );
                  }
                  // print(snapshot.data!.docs[0].data());
                  // List<Widget> orderedProducts = [];

                  // snapshot.data!.docs.forEach((snap) {
                  //   ProductModel product =
                  //       ProductModel.fromJson(snap.data());
                  //   orderedProducts.add(
                  //     ProductWidget(productModel: product),
                  //   );
                  // });
                  return ProductsShowCase(
                    title: "Your Orders",
                    children: snapshot.data,
                  );
                },
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Order Request',
                  style: GoogleFonts.acme(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Expanded(
                child: ListView.builder(
                    primary: false,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          'Order $index : Realme Narzo 6',
                          style: GoogleFonts.actor(
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                            color: Colors.black,
                          ),
                        ),
                        subtitle:
                            const Text('Address- Deopa Building, near chungi'),
                        trailing: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.check,
                            color: Colors.green,
                          ),
                        ),
                      );
                    }))
          ]),
        ),
      ),
    );
  }
}

class UserIntroWidget extends StatelessWidget {
  const UserIntroWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kAppBarHeight,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: backgroundGradient1,
          begin: Alignment.topCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: SizedBox(
        height: kAppBarHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 17,
              ),
              child: BlocBuilder<FirestoreBloc, FirestoreState>(
                builder: (context, state) {
                  if (state is FirestoreLoading) {
                    return Container();
                  }
                  if (state is FirestoreLoaded) {
                    return RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Hello, ',
                            style: GoogleFonts.aBeeZee(
                              fontSize: 26,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: state.userData.name,
                            style: GoogleFonts.aBeeZee(
                              fontSize: 26,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                right: 20,
              ),
              child: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(
                  'https://firebasestorage.googleapis.com/v0/b/jobs-in-retail.appspot.com/o/products%2F13ec6db0-5890-11ed-8577-f5137ecd9e0a?alt=media&token=14cd8dec-779d-46d9-866b-4a8a8236c047',
                  // 'https://images.unsplash.com/photo-1655949595981-f1d8e8739cdf?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2802&q=80',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
