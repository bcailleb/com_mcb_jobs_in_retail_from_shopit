import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../blocs/UserDataBloc/firestore_bloc.dart';
import '../layout/screen_layout.dart';
import '../utils/color_themes.dart';
import '../utils/constants.dart';
import '../widgets/Buttons/primary_widget_button.dart';
import '../gen/assets.gen.dart';
class OrderResultScreen extends StatelessWidget {
  const OrderResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = BlocProvider.of<FirestoreBloc>(context).state.userData;
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Order Placed Sucessfully',
                style: GoogleFonts.andika(
                  fontSize: 25,
                ),
              ),
              SizedBox(
                height: screenSize.height / 5,
                child:
                SvgPicture.asset(
                  Assets.images.greentick,
                  fit: BoxFit.contain,
                ),
              ),
              Text(
                'Thank you ${user.name} for placing your order',
                style: GoogleFonts.andika(
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                'Your order will be delivered within 2 to 3 days',
                style: productShortLabelStyle.copyWith(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              PrimaryWidgetButton(
                color: buttonColor,
                isLoading: false,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  ScreenLayout(),
                    ),
                  );
                },
                child: const Text('Continue shopping'),
              )
            ]),
      ),
    );
  }
}
