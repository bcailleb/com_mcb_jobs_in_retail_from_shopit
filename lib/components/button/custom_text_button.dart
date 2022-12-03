import 'package:flutter/material.dart';
import '../../utils/color_themes.dart';
import '../../utils/constants.dart';

class CustomTextButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const CustomTextButton({
    Key? key,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Text(
          label,
          style:  TextStyle(
            color: buttonColor,
            fontFamily: kDefaultFont,
            fontSize: kCustomButtonFontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
