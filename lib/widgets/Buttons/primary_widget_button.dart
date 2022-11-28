// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import '../../utils/utils.dart';

class PrimaryWidgetButton extends StatelessWidget {
  final Widget child;
  final Color color;
  final bool isLoading;
  final VoidCallback onPressed;

  const PrimaryWidgetButton({
    Key? key,
    required this.child,
    required this.color,
    required this.isLoading,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: color,
          fixedSize: Size(
            screenSize.width * 0.5,
            screenSize.height * 0.06,
          )),
      onPressed: onPressed,
      child: isLoading
          ? const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 5,
              ),
              child: AspectRatio(
                aspectRatio: 1 / 1,
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            )
          : child,
    );
  }
}
