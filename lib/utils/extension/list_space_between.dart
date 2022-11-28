import 'package:flutter/cupertino.dart';

extension ListSpaceBetweenExtension on List<Widget> {
  List<Widget> withSpaceBetween({required double height}) => [
        for (int i = 0; i < length; i++) ...[
          // ignore: avoid_print
          // Text(this[i].runtimeType.toString()?? ""),

          SizedBox(height: height / 2),
          this[i],
          if (this[i].runtimeType.toString() != 'TextFieldWidget')
            SizedBox(height: height / 2),
        ],
      ];
}
