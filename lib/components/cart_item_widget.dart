import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:com_mcb_jobs_in_retail_from_shopit/components/product_information_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/AddToCart/add_to_cart_bloc.dart';

import '../models/product_model.dart';
import '../models/userdetail_model.dart';
import '../models/cart_model.dart';
import '../screens/Product/product_screen.dart';
import '../utils/color_themes.dart';
import '../utils/constants.dart';
import '../utils/utils.dart';
import '../components/Button/custom_rounded_button.dart';
import '../components/Button/custom_square_button.dart';

class CartItemWidget extends StatelessWidget {
  final ProductModel product;
  const CartItemWidget({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return Container(
      padding: const EdgeInsets.all(20),
      height: screenSize.height / 3,
      width: screenSize.width,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 1,
          ),
        ),
      ),
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Expanded(
          flex: 2,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductScreen(
                    productModel: product,
                  ),
                ),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: screenSize.width / 3,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Image.network(
                      product.imgUrl,
                    ),
                  ),
                ),
                SizedBox(
                  width: screenSize.width * 0.03,
                ),
                ProductInformationWidget(
                  productName: product.productName,
                  productCost: product.price,
                  sellerName: product.sellerName,
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CustomSquareButton(
                    color: backgroundColor,
                    widget: const Icon(
                      Icons.remove,
                    ),
                    onPressed: () {
                      context.read<AddToCartBloc>().add(
                            RemoveProductQuantityinCart(
                              productUid: product.uid,
                            ),
                          );
                    },
                    dimension: screenSize.height * 0.05,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 1,
                      right: 1,
                    ),
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection(UserDetailModel.collectionName)
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .collection(CartModel.collectionName)
                            .doc(product.uid)
                            .snapshots(),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (!snapshot.hasData) {
                            return const CircularProgressIndicator();
                          }

                          int value = snapshot.data['quantity'];
                          return CustomSquareButton(
                            color: Colors.white,
                            widget: Text(
                              value == null ? '0' : value.toString(),
                              style: const TextStyle(
                                color: buttonColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            onPressed: () {},
                            dimension: screenSize.height * 0.05,
                          );
                        }),
                  ),
                  CustomSquareButton(
                    color: backgroundColor,
                    widget: const Icon(
                      Icons.add,
                    ),
                    onPressed: () async {
                      context.read<AddToCartBloc>().add(
                            AddProductQuantityinCart(
                              productUid: product.uid,
                              productModel: product,
                            ),
                          );
                    },
                    dimension: screenSize.height * 0.05,
                  ),
                ],
              ),
              Row(
                children: [
                  CustomRoundedButton(
                    buttonTitle: 'Delete',
                    onPressed: () {
                      context.read<AddToCartBloc>().add(
                            DeleteProductFromCart(uid: product.uid),
                          );
                    },
                    color: buttonColor,
                    textColor: Colors.white,
                  ),
                  SizedBox(
                    width: screenSize.width * 0.02,
                  ),
                  CustomRoundedButton(
                    buttonTitle: 'Save for Later',
                    onPressed: () {},
                    color: buttonColor,
                    textColor: Colors.white,
                  )
                ],
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 15,
            ),
            child: Text(
              'See more like this',
              style: linkButtonStyle,
            ),
          ),
        ),
      ]),
    );
  }
}
