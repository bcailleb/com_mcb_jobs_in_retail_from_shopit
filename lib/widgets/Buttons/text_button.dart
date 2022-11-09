import 'package:flutter/material.dart';
import '../../utils/color_themes.dart';

class textButton extends StatelessWidget {
  final String label;
  VoidCallback onTap;
  textButton({
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
