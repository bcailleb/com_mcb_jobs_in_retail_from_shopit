import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../gen/fonts.gen.dart';
import '../../utils/constants.dart';

class TextWidget extends StatelessWidget {
  final String title;
  final Alignment alignment;
  final double fontSize;
  final Color fontColor;

  const TextWidget({
    Key? key,
    required this.title,
    required this.alignment,
    required this.fontSize,
    required this.fontColor,
  }) : super(key: key);

/*  @override
  State<TextWidget> createState() => _TextWidgetState();
}

class _TextWidgetState extends State<TextWidget> {
*/
  @override
  Widget build(BuildContext context) {
    return
      Align(
        alignment: alignment,
        child: Text(title,
        style: TextStyle(
        fontFamily: kDefaultFont,
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
          color: fontColor,
          ),
        ),
      );
  }
}
