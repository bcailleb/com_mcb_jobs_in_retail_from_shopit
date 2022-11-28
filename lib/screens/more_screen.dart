import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../widgets/category_widget.dart';
import '../widgets/parent_appbar_widget.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ParentAppBarWidget(
        hasBack: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
            itemCount: categoriesList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2.2 / 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              return CategoryWidget(index: index);
            }),
      ),
    );
  }
}
