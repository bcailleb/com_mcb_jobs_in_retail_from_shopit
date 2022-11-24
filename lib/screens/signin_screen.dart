import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../blocs/AuthBloc/auth_bloc.dart';
import '../screens/signup_screen.dart';
import '../utils/color_themes.dart';
import '../utils/message_constant.dart';
import '../utils/translate.dart';
import '../utils/utils.dart';
import '../widgets/Buttons/primary_button.dart';
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
    Size screenSize = Utils().getScreenSize();
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenSize.height,
          width: screenSize.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: Assets.images.bg.provider(),
                  fit: BoxFit.cover,
                ),
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: 1,
                    child: Image.asset(
                      Assets.images.logoNormal.path,
                      height: screenSize.height * 0.09,
                    ),
                  ),
                  Container(
                    height: screenSize.height * 0.5,
                    width: screenSize.width * 0.8,
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          translate(context)!.login_title,
                          style: GoogleFonts.aleo(
                            fontSize: 26,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextFieldWidget(
                          title: translate(context)!.email_input,
                          controller: emailController,
                          obsecureText: false,
                          hintText: pleaseEnterField(context,constNameInput),
                        ),
                        TextFieldWidget(
                          title: translate(context)!.password_input,
                          controller: passwordController,
                          obsecureText: true,
                          hintText: pleaseEnterField(context,constPasswordInput),
                        ),
                        Center(
                          child: Hero(
                            tag: 2,
                            child: BlocBuilder<AuthBloc, AuthState>(
                              builder: (context, state) {
                                return PrimaryButton(
                                  color: buttonColor,
                                  isLoading:
                                      state is AuthLoading ? true : false,
                                  onPressed: () async {
                                    context.read<AuthBloc>().add(
                                          SigninUserEvent(
                                            password: passwordController.text,
                                            email: emailController.text,
                                            context: context,
                                          ),
                                        );
                                  },
                                  child: Text(
                                    translate(context)!.login_button,
                                    style: const TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 1,
                          color: buttonColor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: Text(
                          translate(context)!.no_account_label,
                          style: GoogleFonts.acme(
                            color: buttonColor,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 1,
                          color: buttonColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: screenSize.height * 0.01,
                  ),
                  PrimaryButton(
                    color: Colors.grey[200]!,
                    isLoading: false,
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpScreen(),
                        ),
                      );
                    },
                    child: Text(translate(context)!.signup_title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: buttonColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
