// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

import '../layout/screen_layout.dart';
import '../screens/result_screen.dart';
import '../screens/search_screen.dart';
import '../utils/constants.dart';

import '../utils/utils.dart';

class SearchBarWidget extends StatelessWidget with PreferredSizeWidget {
  final bool isReadOnly;
  final bool hasBackButton;
  ScreenLayout screenLayout = ScreenLayout();

  SearchBarWidget({
    Key? key,
    required this.isReadOnly,
    required this.hasBackButton,
  })  : preferredSize = const Size.fromHeight(kAppBarHeight),
        super(key: key);

  @override
  final Size preferredSize;

  OutlineInputBorder border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: const BorderSide(
      color: Colors.grey,
      width: 2,
    ),
  );

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();

    return Container(
      height: kAppBarHeight * 1.5,
      decoration: const BoxDecoration(),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            hasBackButton
                ? IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                      size: screenSize.height * 0.035,
                    ))
                : Container(),
            SizedBox(
              width: screenSize.width * 0.68,
              child: TextField(
                onSubmitted: (String query) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResultScreen(query: query),
                    ),
                  );
                },
                readOnly: isReadOnly,
                onTap: () {
                  if (isReadOnly) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SearchScreen(),
                      ),
                    );
                  }
                },
                decoration: InputDecoration(
                  border: border,
                  focusedBorder: border,
                  hintText: 'Search for products',
                  hintStyle: const TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
