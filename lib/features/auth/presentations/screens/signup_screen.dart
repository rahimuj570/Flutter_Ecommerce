import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/app/app_colors.dart';
import 'package:flutter_ecommerce/features/auth/presentations/screens/signin_screen.dart';
import 'package:flutter_ecommerce/features/auth/presentations/widgets/app_logo_widget.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});
  static String name = '/signup';

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

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
                  "Signup Profile",
                  style: textTheme.headlineMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Get started with us with profile details",
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
                          decoration: InputDecoration(hintText: "First Name"),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          textInputAction: TextInputAction.next,
                          validator: (value) =>
                              value!.isEmpty ? 'Insert First Name' : null,
                        ),
                        TextFormField(
                          decoration: InputDecoration(hintText: 'Last Name'),

                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          textInputAction: TextInputAction.next,
                          validator: (value) =>
                              value!.isEmpty ? 'Insert Last Name' : null,
                        ),
                        TextFormField(
                          decoration: InputDecoration(hintText: 'Email'),

                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          textInputAction: TextInputAction.next,
                          validator: (value) =>
                              value!.isEmpty ? 'Insert Email' : null,
                        ),
                        TextFormField(
                          decoration: InputDecoration(hintText: 'Pasword'),

                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          obscureText: true,
                          textInputAction: TextInputAction.next,
                          validator: (value) =>
                              value!.isEmpty ? 'Insert Password' : null,
                        ),

                        TextFormField(
                          maxLines: 3,
                          decoration: InputDecoration(
                            hintText: 'Shipping Address',
                          ),

                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          textInputAction: TextInputAction.done,
                          validator: (value) =>
                              value!.isEmpty ? 'Insert Shipping Address' : null,
                        ),
                        FilledButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {}
                          },
                          child: Text("SIGN UP"),
                        ),
                        RichText(
                          text: TextSpan(
                            style: textTheme.bodyMedium,
                            text: 'Already have an account? ',
                            children: [
                              TextSpan(
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.themeColor,
                                ),
                                text: 'Signin',
                                recognizer: TapGestureRecognizer()
                                  ..onTap = _gotoSignin,
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

  void _gotoSignin() {
    Navigator.pushReplacementNamed(context, SigninScreen.name);
  }
}
