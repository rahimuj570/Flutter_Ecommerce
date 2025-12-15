import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/app/app_colors.dart';
import 'package:flutter_ecommerce/features/auth/presentations/screens/signup_screen.dart';
import 'package:flutter_ecommerce/features/auth/presentations/widgets/app_logo_widget.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});
  static String name = '/forgot_password';

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
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
                  "Forgot Password",
                  style: textTheme.headlineMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text("Enter your email", style: textTheme.bodyMedium),
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
                        FilledButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {}
                          },
                          child: Text("NEXT"),
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
