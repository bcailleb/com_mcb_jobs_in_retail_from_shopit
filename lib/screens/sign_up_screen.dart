import 'package:com_mcb_jobs_in_retail_from_shopit/gen/assets.gen.dart';
import 'package:com_mcb_jobs_in_retail_from_shopit/utils/extension/list_space_between.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../blocs/AuthBloc/auth_bloc.dart';
import '../resources/auth_methods.dart';
import '../screens/sign_in_screen.dart';

import '../utils/color_themes.dart';

import '../utils/constants.dart';
import '../utils/message_constant.dart';
import '../utils/translate.dart';
import '../utils/utils.dart';
import '../widgets/button/custom_text_button.dart';
import '../widgets/button/primary_text_button.dart';
import '../widgets/text/text_tittle_widget.dart';
import '../widgets/text_field/text_field_widget.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  Size screenSize = Utils().getScreenSize();
  bool isLoading = false;

  AuthMethods authMethods = AuthMethods();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    addressController.dispose();
    super.dispose();
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
              TextTitleWidget(title:
                translate(context)!.sign_up_title
              ),
              TextFieldWidget(
                title: translate(context)!.name_input,
                controller: nameController,
                obsecureText: false,
                hintText: pleaseEnterField(context, constNameInput),
              ),
              TextFieldWidget(
                title: translate(context)!.address_input,
                controller: addressController,
                obsecureText: false,
                hintText: pleaseEnterField(context, constAddress),
              ),
              TextFieldWidget(
                title: translate(context)!.email_input,
                controller: emailController,
                obsecureText: false,
                hintText: pleaseEnterField(context, constEmailInput),
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
                              SignUpUserEvent(
                                name: nameController.text,
                                emailId: emailController.text,
                                password: passwordController.text,
                                address: addressController.text,
                                context: context,
                              ),
                            );
                      },
                      text: translate(context)!.sign_up_button,
                    );
                  },
                ),
              ),
              CustomTextButton(
                label: translate(context)!.already_an_account_title,
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignInScreen(),
                    ),
                  );
                },
              ),
            ].withSpaceBetween(height: kDefaultPadding),
          ),
        ),
      ),
    );
  }
}
