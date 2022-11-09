// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../utils/color_themes.dart';

class BubbleIcon extends StatelessWidget {
  final Icon iconName;
  final String iconValue;
  final VoidCallback onPress;
  const BubbleIcon({
    Key? key,
    required this.iconName,
    required this.iconValue,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          onPressed: onPress,
          icon: iconName,
        ),
        Positioned(
            right: 7,
            bottom: 5,
            child: CircleAvatar(
              radius: 9,
              backgroundColor: buttonColor,
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Text(
                  iconValue,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 8,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )),
      ],
    );
  }
}
