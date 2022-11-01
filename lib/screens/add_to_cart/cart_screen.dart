import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../models/product_model.dart';
import '../../screens/Order/order_screen.dart';
import '../../utils/color_themes.dart';
import '../../utils/constants.dart';
import '../../widgets/cart_item_widget.dart';
import '../../widgets/Buttons/primary_button.dart';
import '../../widgets/parent_appBar_widget.dart';
import '../../widgets/user_details_bar.dart';


class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double sum = 0;

    return Scaffold(
      appBar: ParentAppBarWidget(
        hasBack: false,
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              children: [
                SizedBox(
                  height: kAppBarHeight / 2,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection('cart')
                        .snapshots(),
                    builder: (context,
                        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                            snapshot) {
                      if (!snapshot.hasData) {
                        return Container();
                      }
                      snapshot.data!.docs.forEach((product) {
                        double finalPrice =
                            product['price'] * product['quantity'];
                        sum += finalPrice;
                      });

                      return PrimaryButton(
                        child: Text(
                          'Proceed to buy ${snapshot.data!.docs.length} items',
                          style: buttonTitleStyle,
                        ),
                        color: lightbuttonColor,
                        isLoading: false,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  OrderScreen(totalAmount: sum.toString()),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                Expanded(
                    child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection('cart')
                      .snapshots(),
                  builder: (context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(color: buttonColor),
                      );
                    }
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          ProductModel product = ProductModel.fromJson(
                              snapshot.data!.docs[index].data());
                          return CartItemWidget(
                            product: product,
                          );
                        });
                  },
                ))
              ],
            ),
          ),
          UserDetailsBar(
            offset: 0,
          ),
        ],
      ),
    );
  }
}


// ProductModel(
//                             productName:
//                                 'Samsung  1.5 Ton 3 Star Wi-Fi Twin-Cool Inverter Split Air Conditioner (Copper, Auto Convertible, Shield Blu Anti-Corrosion Technology, 2022 Model, CS/CU-SU18XKYTA, White)',
//                             imgUrl:
//                                 'https://m.media-amazon.com/images/I/31YVq3uH0EL._SL1024_.jpg',
//                             price: 16000,
//                             discount: 0,
//                             uid: '12',
//                             sellerName: 'Samsung',
//                             sellerUid: 'samsung',
//                             rating: 5,
//                             numberOfRating: 10,
//                             description: productDescriptionList,
//                             category: 'Electronics',
//                           ),