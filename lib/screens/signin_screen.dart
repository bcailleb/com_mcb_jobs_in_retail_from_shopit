// ignore_for_file: unused_import

import '../utils/extension/list_space_between.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../blocs/AuthBloc/auth_bloc.dart';
import '../screens/signup_screen.dart';
import '../utils/color_themes.dart';
import '../utils/constants.dart';
import '../utils/message_constant.dart';
import '../utils/translate.dart';
import '../widgets/Buttons/primary_text_button.dart';
import '../widgets/Buttons/primary_widget_button.dart';
import '../widgets/textfield_widget.dart';
import '../gen/assets.gen.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({Key? key}) : super(key: key);

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(
            kDefaultPadding,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Hero(
                tag: 1,
                child: Image.asset(Assets.images.logoNormal.path,
                    height: Adaptive.h(15)),
              ),
              Text(
                translate(context)!.login_title,
                style: GoogleFonts.aleo(
                    fontSize: kTextTitleFontSize,
                    fontWeight: FontWeight.w700,
                    color: appColor1),
              ),
              TextFieldWidget(
                title: translate(context)!.email_input,
                controller: emailController,
                obsecureText: false,
                hintText: pleaseEnterField(context, constNameInput),
              ),
              TextFieldWidget(
                title: translate(context)!.password_input,
                controller: passwordController,
                obsecureText: true,
                hintText: pleaseEnterField(context, constPasswordInput),
              ),
              Hero(
                tag: 2,
                child: BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return PrimaryTextButton(
                      color: buttonColor,
                      isLoading: state is AuthLoading ? true : false,
                      onPressed: () async {
                        context.read<AuthBloc>().add(
                              SigninUserEvent(
                                password: passwordController.text,
                                email: emailController.text,
                                context: context,
                              ),
                            );
                      },
                      text: translate(context)!.login_button,
                    );
                  },
                ),
              ),
              Text(
                translate(context)!.no_account_label,
                style: GoogleFonts.acme(
                  color: buttonColor,
                  fontSize: kTextFontSize,
                ),
              ),
              PrimaryTextButton(
                color: appColor3,
                isLoading: false,
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignUpScreen(),
                    ),
                  );
                },
                text: translate(context)!.signup_title,
              ),
              ].withSpaceBetween(height: kDefaultPadding),
          ),
        ),
      ),
    );
  }
}
