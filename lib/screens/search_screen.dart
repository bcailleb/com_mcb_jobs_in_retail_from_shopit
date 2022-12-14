import 'package:flutter/material.dart';
import '../components/searchbar_widget.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchBarWidget(
        hasBackButton: true,
        isReadOnly: false,
      ),
    );
  }
}
