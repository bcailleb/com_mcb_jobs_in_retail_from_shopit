// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/color_themes.dart';
import '../utils/constants.dart';
import '../utils/utils.dart';

class ProductsShowCase extends StatelessWidget {
  final String? title;
  final List<Widget>? children;
  bool isLoading;
  ProductsShowCase({
    Key? key,
    this.isLoading = false,
    this.title,
    this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.all(8),
          width: screenSize.width,
          child: isLoading == true
              ? const Center(
                  child: CircularProgressIndicator(
                    backgroundColor: buttonColor,
                  ),
                )
              : Row(
                  children: [
                    Text(
                      title!,
                      style: GoogleFonts.acme(
                        fontSize: 20,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold,
                        color: buttonColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 14,
                      ),
                      child: Text(
                        'View more',
                        style: linkButtonStyle,
                      ),
                    )
                  ],
                ),
        ),
        SizedBox(
          height: screenSize.height * 0.2,
          width: screenSize.width,
          child: ListView.builder(
            itemCount: children!.length < 6 ? children!.length : 6,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return children![index];
            },
          ),
        )
      ],
    );
  }
}



// ProductModel(
//                           category: snap.data!.docs[index]['category'],
//                           productName: snap.data!.docs[index]['productName'],
//                           imgUrl: snap.data!.docs[index]['imageUrl'],
//                           uid: snap.data!.docs[index]['productUid'],
//                           price: snap.data!.docs[index]['price'],
//                           discount: snap.data!.docs[index]['discount'],
//                           description: snap.data!.docs[index]['description'],
//                           sellerName: snap.data!.docs[index]['sellerName'],
//                           sellerUid: snap.data!.docs[index]['sellerUid'],
//                           rating: snap.data!.docs[index]['rating'],
//                           numberOfRating: snap.data!.docs[index]
//                               ['numberOfRating'],
//                         ),