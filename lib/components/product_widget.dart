import 'package:flutter/material.dart';

import '../models/product_model.dart';
import '../screens/Product/product_screen.dart';
import '../utils/color_themes.dart';
import '../utils/constants.dart';
import 'cost_widget.dart';

class ProductWidget extends StatelessWidget {
  final ProductModel productModel;

  const ProductWidget({
    Key? key,
    required this.productModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductScreen(
                productModel: productModel,
              ),
            ));
      },
      child: AspectRatio(
        aspectRatio: 1 / 1,
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 5,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.grey.shade100,
              width: 2,
            ),
          ),
          child: Padding(
              padding: const EdgeInsets.all(
                10,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 3,
                    child: Image.network(
                      productModel.imgUrl,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Text(
                      productModel.productName,
                      textAlign: TextAlign.center,
                      style: productNameStyle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Text(
                      productModel.category,
                      textAlign: TextAlign.center,
                      style: productNameStyle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Flexible(
                      flex: 1,
                      child: CostWidget(
                        color: priceColor,
                        cost: productModel.price,
                        textSize: 18,
                      )
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
