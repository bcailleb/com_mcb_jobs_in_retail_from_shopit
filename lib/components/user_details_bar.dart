// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../blocs/UserDataBloc/firestore_bloc.dart';

import '../utils/color_themes.dart';
import '../utils/constants.dart';
import '../utils/utils.dart';

class UserDetailsBar extends StatelessWidget {
  final double offset;

  const UserDetailsBar({
    Key? key,
    required this.offset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return Positioned(
      top: -offset / 5,
      child: Container(
        height: kAppBarHeight / 2,
        width: screenSize.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: lightBackgroundaGradient,
            begin: Alignment.centerLeft,
            end: Alignment.center,
          ),
        ),
        child: BlocBuilder<FirestoreBloc, FirestoreState>(
          builder: (context, state) {
            if (state is FirestoreLoading) {
              return const Center(
                child: LinearProgressIndicator(
                  color: Colors.white,
                ),
              );
            }
            return Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 3,
                horizontal: 20,
              ),
              child: Row(children: [
                const Padding(
                  padding: EdgeInsets.only(
                    right: 8,
                  ),
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                ),
                Flexible(
                  child: Text(
                    '${state.userData.name}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.abel(
                      color: Colors.white,
                    ),
                  ),
                )
              ]),
            );
          },
        ),
      ),
    );
  }
}
