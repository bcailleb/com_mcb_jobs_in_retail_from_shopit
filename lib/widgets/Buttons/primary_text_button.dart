import 'package:com_mcb_jobs_in_retail_from_shopit/widgets/Buttons/primary_widget_button.dart';
import 'package:flutter/material.dart';
import '../../utils/constants.dart';

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
          fontSize: kButtonFontSIze, // 16.sp,
        ),
      ),
    );
  }
}