import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first


import '../gen/assets.gen.dart';
import '../layout/screen_layout.dart';
import '../models/userdetail_model.dart';
import '../models/cart_model.dart';
import '../screens/search_screen.dart';
import '../utils/constants.dart';

import '../utils/utils.dart';
import 'bubble_icon_widget.dart';

class ParentAppBarWidget extends StatelessWidget with PreferredSizeWidget {
  ScreenLayout screenLayout = ScreenLayout();
  final bool hasBack;

  ParentAppBarWidget({
    Key? key,
    required this.hasBack,
  })  : preferredSize = const Size.fromHeight(kAppBarHeight),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();

    return Container(
      width: screenSize.width,
      height: kAppBarHeight * 1.4,
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            hasBack
                ? IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                  )
                : IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SearchScreen(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.search_outlined,
                      color: Colors.black,
                    ),
                  ),
            Container(
              height: screenSize.height * .05,
              child: Image.asset(
                Assets.images.shopit.path,
                fit: BoxFit.cover,
              ),
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection(UserDetailModel.collectionName)
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection(CartModel.collectionName)
                  .snapshots(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (!snapshot.hasData) {
                  return Container();
                }
                return BubbleIcon(
                  iconName: Icon(
                    Icons.shopping_bag_outlined,
                    size: screenSize.height * 0.03,
                  ),
                  iconValue:
                      snapshot.data!.docs == 0 || snapshot.data!.docs.length < 7
                          ? snapshot.data!.docs.length.toString()
                          : '6+',
                  onPress: () {},
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
