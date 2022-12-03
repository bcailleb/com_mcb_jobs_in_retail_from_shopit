// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../utils/color_themes.dart';
import '../utils/constants.dart';
import '../components/result_widgets.dart';
import '../components/searchbar_widget.dart';

import '../models/product_model.dart';

class ResultScreen extends StatelessWidget {
  final String? query;
  final bool isCategoryQuery;
  const ResultScreen({
    Key? key,
    this.isCategoryQuery = false,
    required this.query,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchBarWidget(
        isReadOnly: false,
        hasBackButton: true,
      ),
      body: Align(
        alignment: Alignment.centerLeft,
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10,
            ),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Résultats pour ',
                    style: buttonTitleStyle.copyWith(
                      fontSize: 17,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: query,
                    style: buttonTitleStyle.copyWith(
                      fontSize: 17,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
              child: FutureBuilder(
            future: isCategoryQuery
                ? FirebaseFirestore.instance
                    .collection(ProductModel.collectionName)
                    .where('category', isEqualTo: query)
                    .get()
                : FirebaseFirestore.instance
                    .collection(ProductModel.collectionName)
                    .where('productName', isGreaterThanOrEqualTo: query)
                    .get(),
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(color: buttonColor),
                );
              }
              return GridView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data.docs.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2 / 3,
                  ),
                  itemBuilder: (context, index) {
                    return ResultsWidget(
                        product: ProductModel.fromJson(
                            snapshot.data.docs[index].data()));
                  });
            },
          )),
        ]),
      ),
    );
  }
}
