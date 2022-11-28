import 'package:com_mcb_jobs_in_retail_from_shopit/models/address_model.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart';

class AddressWidget extends StatelessWidget {
  AddressWidget({
    Key? key,
    required this.screenSize,
    required this.address,
  }) : super(key: key);

  final Size screenSize;
  var address;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      height: screenSize.height * 0.15,
      width: screenSize.width,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'Primary Address-',
            style: productNameStyle.copyWith(
              fontSize: 18,
            ),
          ),
          Center(
            child: Text(
              address.name,
              style: addressTextStyle.copyWith(
                fontSize: 15,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: screenSize.height * 0.01,
          ),
          Center(
            child: Text(
              address.address,
              style: addressTextStyle.copyWith(
                fontSize: 15,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
