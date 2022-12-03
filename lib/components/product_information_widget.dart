import 'package:flutter/material.dart';
import '../utils/color_themes.dart';
import '../utils/constants.dart';


import '../utils/utils.dart';
import 'cost_widget.dart';

class ProductInformationWidget extends StatelessWidget {
  final String productName;
  final double productCost;
  final String sellerName;
  const ProductInformationWidget({
    Key? key,
    required this.productName,
    required this.productCost,
    required this.sellerName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    SizedBox spaceBtw = const SizedBox(
      height: 7,
    );

    return SizedBox(
      width: screenSize.width / 2,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              productName,
              style: productNameStyle,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
          spaceBtw,
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 7,
              ),
              child: CostWidget(
                textSize: 24,
                color: priceColor,
                cost: productCost,
              ),
            ),
          ),
          spaceBtw,
          Align(
            alignment: Alignment.centerLeft,
            child: RichText(
                text: TextSpan(children: [
              TextSpan(
                text: 'Sold by ',
                style: productShortLabelStyle,
              ),
              TextSpan(
                text: sellerName,
                style: const  TextStyle(
                  color: lightbuttonColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ])),
          )
        ],
      ),
    );
  }
}
