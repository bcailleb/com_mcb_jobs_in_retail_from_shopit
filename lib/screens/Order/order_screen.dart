import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay/pay.dart';

import '../../blocs/UserDataBloc/firestore_bloc.dart';
import '../../models/address_model.dart';
import '../../screens/Order/services/order_services.dart';
import '../../screens/order_result_screen.dart';
import '../../utils/color_themes.dart';
import '../../utils/constants.dart';
import '../../utils/logger.dart';
import '../../utils/utils.dart';
import '../../components/address_widget.dart';
import '../../components/parent_appbar_widget.dart';
import '../../components/text_field/text_field_widget.dart';

final _addressFormKey = GlobalKey<FormState>();

class OrderScreen extends StatefulWidget {
  final String totalAmount;
  final bool isLoading = false;

  const OrderScreen({
    Key? key,
    required this.totalAmount,
  }) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  String addressDetails = '';

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    paymentItems.add(
      PaymentItem(
          amount: widget.totalAmount,
          label: 'Total Amount',
          status: PaymentItemStatus.final_price),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneNumberController.dispose();
    cityController.dispose();
    addressController.dispose();
    pinCodeController.dispose();
    super.dispose();
  }

  List<PaymentItem> paymentItems = [];
  void onApplePayResult(res) async {
    if (BlocProvider.of<FirestoreBloc>(context).state.userData.address ==
        null) {
      OrderServices().uploadUserAddress(
        AddressModel(address: addressDetails),
      );
    }
    final products = await OrderServices().getOrderedProducts();
    OrderServices().uploadOrderToDatabse(
      products: products,
      totalPrice: widget.totalAmount,
      shippingAddress: addressDetails,
      buyerId: FirebaseAuth.instance.currentUser!.uid,
      orderStatus: 0,
    );
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const  OrderResultScreen(),
      ),
    );
  }

  void onGooglePayResult(res) async {
    if (BlocProvider.of<FirestoreBloc>(context).state.userData.address ==
        null) {
      OrderServices().uploadUserAddress(
        AddressModel(address: addressDetails),
      );
    }
    final products = await OrderServices().getOrderedProducts();
    OrderServices().uploadOrderToDatabse(
      products: products,
      totalPrice: widget.totalAmount,
      shippingAddress: addressDetails,
      buyerId: FirebaseAuth.instance.currentUser!.uid,
      orderStatus: 0,
    );
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const OrderResultScreen(),
      ),
    );
  }

  void addressSelected(String defaultAddress) {
    addressDetails = '';
    bool isFromActive = nameController.text.isNotEmpty &&
        phoneNumberController.text.isNotEmpty &&
        addressController.text.isNotEmpty &&
        cityController.text.isNotEmpty &&
        pinCodeController.text.isNotEmpty;

    if (isFromActive) {
      if (_addressFormKey.currentState!.validate()) {
        addressDetails =
            '${nameController.text}, ${phoneNumberController.text} \n${addressController.text}, ${cityController.text}, ${pinCodeController.text}';
      } else {
        throw Exception('Please enter all the required fields');
      }
    } else if (defaultAddress.isNotEmpty) {
      addressDetails = defaultAddress;
    } else {
      throw Exception('Error');
    }
    info(addressDetails.toString());
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    var user = BlocProvider.of<FirestoreBloc>(context).state.userData;

    return Scaffold(
        appBar: ParentAppBarWidget(
          hasBack: true,
        ),
        body: Stack(
          children: [
            widget.isLoading
                ? SizedBox(
                    height: screenSize.height,
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: buttonColor,
                      ),
                    ))
                : Container(),
            SingleChildScrollView(
              child: Stack(
                children: [
                  Container(
                    padding:const  EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          user != null
                              ? Column(
                                  children: [
                                    AddressWidget(
                                      screenSize: screenSize,
                                      address: user,
                                    ),
                                    Center(
                                      child:
                                          Text("Or", style: addressTextStyle),
                                    ),
                                  ],
                                )
                              : Container(),
                          SizedBox(
                            height: screenSize.height * 0.01,
                          ),
                          Center(
                            child: Text(
                              'Add your address',
                              style: addressTextStyle,
                            ),
                          ),
                          const Divider(
                            thickness: 2,
                            color: Colors.black,
                          ),
                          Form(
                            key: _addressFormKey,
                            child: Column(
                              children: [
                                TextFieldWidget(
                                  title: "Name",
                                  controller: nameController,
                                  obsecureText: false,
                                  hintText: 'Full Name',
                                ),
                                TextFieldWidget(
                                  title: "Address",
                                  controller: addressController,
                                  obsecureText: false,
                                  hintText: 'Flat, House No, Building',
                                ),
                                TextFieldWidget(
                                  title: "City",
                                  controller: cityController,
                                  obsecureText: false,
                                  hintText: 'City',
                                ),
                                TextFieldWidget(
                                  title: "Pin Code",
                                  controller: pinCodeController,
                                  obsecureText: false,
                                  hintText: 'Pin code',
                                ),
                                TextFieldWidget(
                                  title: "Phone Number",
                                  controller: phoneNumberController,
                                  obsecureText: false,
                                  hintText: 'Enter your phone number',
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: screenSize.height * .05,
                          ),
                          ApplePayButton(
                            onPressed: () {
                              addressSelected(user.address);
                            },
                            width: screenSize.width,
                            height: screenSize.height * 0.05,
                            type: ApplePayButtonType.buy,
                            style: ApplePayButtonStyle.whiteOutline,
                            paymentConfigurationAsset: 'applepay.json',
                            onPaymentResult: onApplePayResult,
                            paymentItems: paymentItems,
                          ),
                          SizedBox(
                            height: screenSize.height * .05,
                          ),
                          GooglePayButton(
                            onPressed: () => addressSelected(user.address),
                            width: screenSize.width,
                            height: screenSize.height * 0.05,
                            type: GooglePayButtonType.buy,
                            paymentConfigurationAsset: 'gpay.json',
                            onPaymentResult: onGooglePayResult,
                            paymentItems: paymentItems,
                            loadingIndicator:const  Center(
                                child: CircularProgressIndicator(
                              color: buttonColor,
                            )),
                          )
                        ]),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
