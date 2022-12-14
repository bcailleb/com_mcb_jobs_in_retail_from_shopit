
import 'package:flutter/material.dart';
import '../../utils/constants.dart';
import '../../components/Button/primary_widget_button.dart';

class PrimaryTextButton extends StatelessWidget {
  final String text;
  final Color color;
  final bool isLoading;
  final VoidCallback onPressed;

  const PrimaryTextButton({
    Key? key,
    required this.text,
    required this.color,
    required this.isLoading,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PrimaryWidgetButton(
      color: color,
      isLoading: isLoading,
      onPressed: onPressed,

      child: Text(
        text,
        style: TextStyle(
          fontFamily: kDefaultFont,
          fontSize: kButtonFontSize, // 16.sp,
        ),
      ),
    );
  }
}