import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/app/app_colors.dart';
import 'package:flutter_ecommerce/features/auth/presentations/screens/forgot_password_screen.dart';
import 'package:flutter_ecommerce/features/auth/presentations/screens/signup_screen.dart';
import 'package:flutter_ecommerce/features/auth/presentations/widgets/app_logo_widget.dart';
import 'package:flutter_ecommerce/features/commons/main_nav_holder_screen.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});
  static String name = '/signin';

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isObsecure = true;
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = TextTheme.of(context);
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 50),
                AppLogoWidget(width: 100),
                SizedBox(height: 5),
                Text(
                  "Sigin Profile",
                  style: textTheme.headlineMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Wellcome back. Let's shopping",
                  style: textTheme.bodyMedium,
                ),
                SizedBox(height: 25),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Column(
                      spacing: 15,
                      children: [
                        TextFormField(
                          decoration: InputDecoration(hintText: 'Email'),

                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          textInputAction: TextInputAction.next,
                          validator: (value) =>
                              value!.isEmpty ? 'Insert Email' : null,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Pasword',

                            suffixIcon: IconButton(
                              onPressed: () {
                                isObsecure = !isObsecure;
                                setState(() {});
                              },
                              icon: Icon(Icons.remove_red_eye_outlined),
                            ),
                          ),

                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          obscureText: isObsecure,
                          textInputAction: TextInputAction.done,
                          validator: (value) =>
                              value!.isEmpty ? 'Insert Password' : null,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.all(1),
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                  context,
                                  ForgotPasswordScreen.name,
                                );
                              },
                              child: Text('Forgot Password?'),
                            ),
                          ],
                        ),

                        FilledButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                              context,
                              MainNavHolderScreen.name,
                            );
                            if (_formKey.currentState!.validate()) {}
                          },
                          child: Text("SIGN IN"),
                        ),
                        RichText(
                          text: TextSpan(
                            style: textTheme.bodyMedium,
                            text: 'Don\'t have an account? ',
                            children: [
                              TextSpan(
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.themeColor,
                                ),
                                text: 'Sign up',
                                recognizer: TapGestureRecognizer()
                                  ..onTap = _gotoSignup,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _gotoSignup() {
    Navigator.pushReplacementNamed(context, SignupScreen.name);
  }
}
