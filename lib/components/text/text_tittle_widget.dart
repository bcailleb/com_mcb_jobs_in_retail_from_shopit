import 'package:com_mcb_jobs_in_retail_from_shopit/components/text/text_widget.dart';
import 'package:flutter/material.dart';
import '../../utils/color_themes.dart';
import '../../utils/constants.dart';

class TextTitleWidget extends StatelessWidget {
  final String title;

  const TextTitleWidget({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextWidget(
        title: title,
        alignment: Alignment.center,
        fontSize: kTextTitleFontSize,
        fontColor: appColor1);
  }
}
