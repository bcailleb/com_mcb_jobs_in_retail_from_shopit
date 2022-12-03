// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:typed_data';
import 'package:com_mcb_jobs_in_retail_from_shopit/utils/extension/list_space_between.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../blocs/ProductDataBloc/product_bloc.dart';
import '../blocs/UserDataBloc/firestore_bloc.dart';
import '../utils/color_themes.dart';
import '../utils/constants.dart';
import '../utils/utils.dart';
import '../widgets/Button/primary_widget_button.dart';
import '../widgets/text_field/text_field_widget.dart';

class SellScreen extends StatefulWidget {
  const SellScreen({Key? key}) : super(key: key);

  @override
  State<SellScreen> createState() => _SellScreenState();
}

class _SellScreenState extends State<SellScreen> {
  TextEditingController productNameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  List keysForDiscount = [0, 50, 60, 70];

  final bool isLoading = false;
  String categoryValue = 'Electronics';

  int selected = 1;

  ImagePicker imagePicker = ImagePicker();

  Uint8List? image;
  List<String> productDescription = [];

  @override
  void dispose() {
    super.dispose();
    productNameController.dispose();
    priceController.dispose();
    descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return Scaffold(
      body: SafeArea(
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                padding: EdgeInsets.all(
                  kDefaultPadding,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    SizedBox(
                      height: screenSize.height / 2.5,
                      width: screenSize.height / 2.5,
                      child: Stack(
                        children: [
                          image == null
                              ? Image.network(
                                  'https://www.glamox.com/public/images/image-default.png?scale=canvas&width=522&height=348&quality=80&f.sharpen=35',
                                  fit: BoxFit.cover,
                                )
                              : Image.memory(image!),
                          Positioned(
                            top: 50,
                            right: 0,
                            child: Transform.scale(
                              scale: 0.7,
                              child: CircleAvatar(
                                backgroundColor: buttonColor,
                                child: IconButton(
                                  onPressed: () async {
                                    Uint8List temp = await Utils().pickImage();
                                    if (temp != null) {
                                      setState(() {
                                        image = temp;
                                      });
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    Text(
                      'Enter your Product Details',
                      style: GoogleFonts.aleo(
                          fontSize: kTextTitleFontSize,
                          fontWeight: FontWeight.w700,
                          color: appColor1),
                    ),
                    TextFieldWidget(
                      title: 'Name of a product',
                      controller: productNameController,
                      obsecureText: false,
                      hintText: 'Enter your product name',
                    ),
                    TextFieldWidget(
                      title: 'Price of a product',
                      controller: priceController,
                      obsecureText: false,
                      hintText: 'Enter your product price',
                    ),
                    Text(
                      'Product Description',
                      style: GoogleFonts.aleo(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      controller: descriptionController,
                      decoration: InputDecoration(
                        hintText: 'Click + Button to add item description',
                        prefixIcon: IconButton(
                          icon: const Icon(
                            Icons.add,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            productDescription.add(descriptionController.text);
                            if (descriptionController.text != '') {
                              Utils().showsnackBar(
                                  context: context,
                                  message: 'Description added sucessfully');
                            }
                            if (descriptionController.text == '') {
                              Utils().showsnackBar(
                                  context: context,
                                  message: 'Please add a description');
                            }

                            descriptionController.clear();
                          },
                        ),
                        hintStyle: const TextStyle(fontSize: 15),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      'Product category',
                      style: GoogleFonts.aleo(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    DropdownButton<String>(
                      isExpanded: true,
                      iconEnabledColor: buttonColor,
                      underline: const SizedBox(),
                      style: GoogleFonts.aleo(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                      value: categoryValue,
                      items: dropDownCategories,
                      onChanged: (index) {
                        setState(() {
                          categoryValue = index!;
                        });
                      },
                    ),
                    Text(
                      'Discount',
                      style: headingStyle,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RadioButtonWidget(
                          selected: selected,
                          title: 'None',
                          buttonValue: 1,
                          onChanged: (int? index) {
                            setState(() {
                              selected = index!;
                            });
                          },
                        ),
                        RadioButtonWidget(
                          selected: selected,
                          title: '50%',
                          buttonValue: 2,
                          onChanged: (int? index) {
                            setState(() {
                              selected = index!;
                            });
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        RadioButtonWidget(
                          selected: selected,
                          title: '60%',
                          buttonValue: 3,
                          onChanged: (int? index) {
                            setState(() {
                              selected = index!;
                            });
                          },
                        ),
                        RadioButtonWidget(
                          selected: selected,
                          title: '70%',
                          buttonValue: 4,
                          onChanged: (int? index) {
                            setState(() {
                              selected = index!;
                            });
                          },
                        ),
                      ],
                    ),
                    BlocBuilder<FirestoreBloc, FirestoreState>(
                      builder: (context, firestoreState) {
                        return BlocBuilder<ProductBloc, ProductState>(
                          builder: (context, state) {
                            return PrimaryWidgetButton(
                              color: buttonColor,
                              isLoading: false,
                              onPressed: () async {
                                context.read<ProductBloc>().add(
                                      UploadProductEvent(
                                        image: image,
                                        productName: productNameController.text,
                                        rawCost: priceController.text,
                                        productDiscount:
                                            keysForDiscount[selected - 1],
                                        sellerName:
                                            firestoreState.userData.name,
                                        sellerUid: FirebaseAuth
                                            .instance.currentUser!.uid,
                                        context: context,
                                        productDescription: productDescription,
                                        category: categoryValue,
                                      ),
                                    );
                                await Future.delayed(
                                  const Duration(seconds: 5),
                                );
                                Navigator.pop(context);
                                productDescription.clear();
                              },
                              child: Text('Sell', style: buttonTitleStyle),
                            );
                          },
                        );
                      },
                    ),
                    PrimaryWidgetButton(
                      color: lightbuttonColor,
                      isLoading: false,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Back', style: buttonTitleStyle),
                    )
                  ].withSpaceBetween(height: kDefaultPadding),
                ),
              ),
      ),
    );
  }
}

class RadioButtonWidget extends StatelessWidget {
  final String title;
  final int buttonValue;
  final ValueChanged<int?> onChanged;
  const RadioButtonWidget({
    Key? key,
    required this.title,
    required this.buttonValue,
    required this.onChanged,
    required this.selected,
  }) : super(key: key);

  final int selected;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListTile(
        title: Text(title),
        leading: Radio(
          value: buttonValue,
          groupValue: selected,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
