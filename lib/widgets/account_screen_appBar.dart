import 'package:flutter/material.dart';
import '../gen/assets.gen.dart';
import '../utils/constants.dart';
import '../utils/utils.dart';

class AccountScreenAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;
  AccountScreenAppBar({Key? key})
      : preferredSize = const Size.fromHeight(kAppBarHeight),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();

    return Container(
      height: kAppBarHeight * 1.3,
      width: screenSize.width,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 40,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Image.asset(
                Assets.images.logoNormal.path,
                height: screenSize.height * 0.04,
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.notifications_outlined,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(
                    Icons.search_outlined,
                  ),
                  onPressed: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
