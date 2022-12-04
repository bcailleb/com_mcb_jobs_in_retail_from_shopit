import "package:flutter/material.dart";
import "package:validators/validators.dart";
import '../../utils/color_themes.dart';
import '../../utils/constants.dart';
import '../../utils/translate.dart';

class TextInputComponent extends StatefulWidget {
  final TextEditingController controller;
  final String textInputType;
  final String title;
  final bool isRequire;
  final String hintText;
  final String errorText;
  final int minCharacters;

  const TextInputComponent({
    Key? key,
    required this.controller,
    this.textInputType = kInputTypeNormal,
    required this.title,
    this.errorText = "",
    this.isRequire = false,
    this.minCharacters = 0,
    this.hintText = "Hint text",
  }) : super(key: key);

  @override
  State<TextInputComponent> createState() => _TextInputComponentState();
}

class _TextInputComponentState extends State<TextInputComponent> {
  final FocusNode _focusNode = FocusNode();
  bool _isError = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        switch (widget.textInputType) {

          case kInputTypeEmail:
            setState(() => _isError = !isEmail(widget.controller.text));
            break;
          case kInputTypePassword:
            setState(() => _isError =
                widget.controller.text.length <= widget.minCharacters);
            break;
            default:

      setState(() => _isError =
      widget.isRequire && widget.controller.text.isEmpty ||
      widget.controller.text.length < widget.minCharacters);
      break;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String localErrorMessage = widget.errorText;
    if(localErrorMessage == "") {
      if (widget.minCharacters > 0) {
        localErrorMessage =
            translate(context)!.minCharactersField(widget.minCharacters);
      }
      else if (widget.isRequire) {
        localErrorMessage = translate(context)!.mandatoryFieldGen;
      }
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          child: Text(
            widget.title,
            style: TextStyle(
              fontFamily: kDefaultFont,
              fontSize: kTextFieldFontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        TextField(
          focusNode: _focusNode,
          controller: widget.controller,
          obscureText: widget.textInputType == kInputTypePassword ? true : false,
          decoration: InputDecoration(
            errorText: _isError ? localErrorMessage : null,
            hintText: widget.hintText,
            hintStyle: TextStyle(
                fontFamily: kDefaultFont,
                fontSize: kTextFieldHintFontSize,
                color: appColor3),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(
                color: appColor3,
                width: 1,
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: appColor1,
                width: 1,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
