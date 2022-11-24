import 'package:flutter/material.dart';
import '../../utils/color_themes.dart';

class CustomTextButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  CustomTextButton({
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
          style: const TextStyle(
            color: buttonColor,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
