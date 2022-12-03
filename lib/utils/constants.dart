import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../gen/assets.gen.dart';
import '../gen/fonts.gen.dart';
import '../screens/account_screen.dart';
import '../screens/home_screen.dart';

import '../models/product_model.dart';
import '../screens/more_screen.dart';
import '../components/product_widget.dart';
import 'color_themes.dart';

const String kAppName = 'Jobs in retail';
const double kAppBarHeight = 80;
// Padding par defaut
 double kDefaultPadding =Adaptive.h(4); // 16.0;
 const String kDefaultFont = FontFamily.syncopate;

// Custom Widget properties
// Button
double kButtonFontSize = 14.sp;
double kCustomButtonFontSize = 12.sp;

// TextField
double kTextFieldFontSize = 14.sp;
double kTextFieldHintFontSize = 12.sp;

// Text
double kTextTitleFontSize = 15.sp;
double kTextSubTitleFontSize = 13.sp;
double kTextFontSize = 14.sp;

const List<Widget> tabScreens = [
  HomeScreen(),
  // CartScreen(),
  AccountScreen(),
  MoreScreen(),
];

const List<String> categoriesList = [
  "Maroquinerie",
  "Prêt-à-porter",
  "Optique",
  "Lingerie",
  "Beauté Cosmétique",
  "Autre"
];

List<String> categoryLogos = [
  Assets.categories.mobile.path,
  Assets.categories.fashion.path,
  Assets.categories.electronics.path,
  Assets.categories.appliances.path,
  Assets.categories.books.path,
  Assets.categories.essential.path,
];

const List<String> largeAds = [
  "https://m.media-amazon.com/images/I/51QISbJp5-L._SX3000_.jpg",
  "https://m.media-amazon.com/images/I/61jmYNrfVoL._SX3000_.jpg",
  "https://m.media-amazon.com/images/I/612a5cTzBiL._SX3000_.jpg",
  "https://m.media-amazon.com/images/I/61fiSvze0eL._SX3000_.jpg",
  "https://m.media-amazon.com/images/I/61PzxXMH-0L._SX3000_.jpg",
];

const List<String> smallAds = [
  "https://m.media-amazon.com/images/I/11M5KkkmavL._SS70_.png",
  "https://m.media-amazon.com/images/I/11iTpTDy6TL._SS70_.png",
  "https://m.media-amazon.com/images/I/11dGLeeNRcL._SS70_.png",
  "https://m.media-amazon.com/images/I/11kOjZtNhnL._SS70_.png",
];

const List<String> adItemNames = [
  "Amazon Pay",
  "Recharge",
  "Rewards",
  "Pay Bills"
];

List<Widget> demoproducts = [
  ProductWidget(
    productModel: ProductModel(
        productName:
            'Samsung  1.5 Ton 3 Star Wi-Fi Twin-Cool Inverter Split Air Conditioner (Copper, Auto Convertible, Shield Blu Anti-Corrosion Technology, 2022 Model, CS/CU-SU18XKYTA, White)',
        imgUrl: 'https://m.media-amazon.com/images/I/31YVq3uH0EL._SL1024_.jpg',
        price: 16000,
        discount: 0,
        uid: '12',
        sellerName: 'Samsung',
        sellerUid: 'samsung',
        rating: 5,
        numberOfRating: 10,
        description: productDescriptionList,
        category: 'Electronics'),
  ),
  ProductWidget(
    productModel: ProductModel(
        productName:
            'Samsung  1.5 Ton 3 Star Wi-Fi Twin-Cool Inverter Split Air Conditioner (Copper, Auto Convertible, Shield Blu Anti-Corrosion Technology, 2022 Model, CS/CU-SU18XKYTA, White)',
        imgUrl: 'https://m.media-amazon.com/images/I/31YVq3uH0EL._SL1024_.jpg',
        price: 16000,
        discount: 0,
        uid: '12',
        sellerName: 'Samsung',
        sellerUid: 'samsung',
        rating: 3,
        numberOfRating: 10,
        description: productDescriptionList,
        category: 'Electronics'),
  ),
  ProductWidget(
    productModel: ProductModel(
        productName:
            'Samsung  1.5 Ton 3 Star Wi-Fi Twin-Cool Inverter Split Air Conditioner (Copper, Auto Convertible, Shield Blu Anti-Corrosion Technology, 2022 Model, CS/CU-SU18XKYTA, White)',
        imgUrl: 'https://m.media-amazon.com/images/I/31YVq3uH0EL._SL1024_.jpg',
        price: 16000,
        discount: 0,
        uid: '12',
        sellerName: 'Samsung',
        sellerUid: 'samsung',
        rating: 1,
        numberOfRating: 10,
        description: productDescriptionList,
        category: 'Electronics'),
  ),
  ProductWidget(
    productModel: ProductModel(
        productName:
            'Samsung  1.5 Ton 3 Star Wi-Fi Twin-Cool Inverter Split Air Conditioner (Copper, Auto Convertible, Shield Blu Anti-Corrosion Technology, 2022 Model, CS/CU-SU18XKYTA, White)',
        imgUrl: 'https://m.media-amazon.com/images/I/31YVq3uH0EL._SL1024_.jpg',
        price: 16000,
        discount: 0,
        uid: '12',
        sellerName: 'Samsung',
        sellerUid: 'samsung',
        rating: 2,
        numberOfRating: 10,
        description: productDescriptionList,
        category: 'Electronics'),
  ),
];

List<String> keysOfRating = [
  'Very Bad',
  'Poor',
  'Average',
  'Good',
  'Excellent',
];

List<String> productDescriptionList = [
  'Split AC with inverter compressor: Variable speed compressor which adjusts power depending on heat load. It is most energy efficient and has lowest-noise operation',
  'Split AC: 1.5 ton Suitable for medium sized rooms (111 to 150 sq ft)',
  'Energy Rating: 5 Star | Annual Energy Consumption 806.28 Units per year | ISSER Value: 4.80 | Copper Condenser Coil: Better cooling and requires low maintenance.',
  'Warranty : 1 Year on Product, 10 Years on Compressor',
  '100% copper condenser with Durafin Ultra Coating : Better cooling and requires low maintenance',
  'Key Features: Noise Level Indoor Unit High/Low: 45/24 (db); Ambient Temperature: 52 degree Celsius',
  'Special Features: WindFree Cooling with 23,000 microholes, Freeze Wash, Dehumidification, Auto Clean (Self Cleaning), Easy Filter Plus (Anti-Bacteria), 4 Way Swing',
];

// Text Styles

TextStyle productNameStyle = GoogleFonts.akshar(
  fontSize: 12,
  fontWeight: FontWeight.bold,
);

TextStyle productShortLabelStyle = GoogleFonts.adventPro(
  color: buttonColor,
  fontWeight: FontWeight.bold,
);

TextStyle descriptionStyle = GoogleFonts.akayaTelivigala(
  color: buttonColor,
  fontWeight: FontWeight.bold,
);

TextStyle addressTextStyle = GoogleFonts.aleo(
  fontSize: 26,
  fontWeight: FontWeight.w700,
);

TextStyle buttonTitleStyle = GoogleFonts.abel(
  fontSize: 16,
  fontWeight: FontWeight.w400,
  color: Colors.white,
);

TextStyle linkButtonStyle = GoogleFonts.actor(
  fontSize: 15,
  color: orangeColor,
  fontWeight: FontWeight.bold,
);

TextStyle headingStyle = GoogleFonts.aleo(
  fontSize: 18,
  fontWeight: FontWeight.bold,
);

// Categories For Product Dropdown

List<DropdownMenuItem<String>> dropDownCategories = [
  const DropdownMenuItem(
    value: 'Mobiles',
    child: Text('Mobiles'),
  ),
  const DropdownMenuItem(
    value: 'Fashion',
    child: Text('Fashion'),
  ),
  const DropdownMenuItem(
    value: 'Electronics',
    child: Text('Electronics'),
  ),
  const DropdownMenuItem(
    value: 'Appliances',
    child: Text('Appliances'),
  ),
  const DropdownMenuItem(
    value: 'Books',
    child: Text('Books'),
  ),
  const DropdownMenuItem(
    value: 'Others',
    child: Text('Others'),
  ),
];
