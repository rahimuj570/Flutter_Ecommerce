import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/app/app_colors.dart';
import 'package:flutter_ecommerce/features/auth/data/models/signup_request_model.dart';
import 'package:flutter_ecommerce/features/auth/presentations/screens/signin_screen.dart';
import 'package:flutter_ecommerce/features/auth/presentations/screens/verify_otp_screen.dart';
import 'package:flutter_ecommerce/features/auth/presentations/widgets/app_logo_widget.dart';
import 'package:flutter_ecommerce/features/auth/state_management/signup_provider.dart';
import 'package:flutter_ecommerce/features/commons/utils/show_snack_bar.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});
  static String name = '/signup';

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameTEC = TextEditingController();
  final TextEditingController _lastNameTEC = TextEditingController();
  final TextEditingController _emailTEC = TextEditingController();
  final TextEditingController _phoneTEC = TextEditingController();
  final TextEditingController _passwordTEC = TextEditingController();
  final TextEditingController _cityTEC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = TextTheme.of(context);
    return ChangeNotifierProvider(
      create: (context) => SignupProvider(),
      child: SafeArea(
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
                            controller: _firstNameTEC,
                            decoration: InputDecoration(hintText: "First Name"),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            textInputAction: TextInputAction.next,
                            validator: (value) =>
                                value!.isEmpty ? 'Insert First Name' : null,
                          ),
                          TextFormField(
                            decoration: InputDecoration(hintText: 'Last Name'),
                            controller: _lastNameTEC,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            textInputAction: TextInputAction.next,
                            validator: (value) =>
                                value!.isEmpty ? 'Insert Last Name' : null,
                          ),
                          TextFormField(
                            decoration: InputDecoration(hintText: 'Email'),
                            controller: _emailTEC,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            textInputAction: TextInputAction.next,
                            validator: (value) =>
                                value!.isEmpty ? 'Insert Email' : null,
                          ),
                          TextFormField(
                            decoration: InputDecoration(hintText: 'Phone'),
                            controller: _phoneTEC,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            textInputAction: TextInputAction.next,
                            validator: (value) =>
                                value!.isEmpty ? 'Insert Phone' : null,
                          ),
                          TextFormField(
                            decoration: InputDecoration(hintText: 'Pasword'),
                            controller: _passwordTEC,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            obscureText: true,
                            textInputAction: TextInputAction.next,
                            validator: (value) =>
                                value!.isEmpty ? 'Insert Password' : null,
                          ),

                          TextFormField(
                            controller: _cityTEC,
                            maxLines: 3,
                            decoration: InputDecoration(
                              hintText: 'Shipping Address',
                            ),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            textInputAction: TextInputAction.done,
                            validator: (value) => value!.isEmpty
                                ? 'Insert Shipping Address'
                                : null,
                          ),
                          Consumer<SignupProvider>(
                            builder: (context, signupProvider, child) =>
                                FilledButton(
                                  onPressed: () {
                                    onTapSignUp(signupProvider);
                                  },
                                  child: Visibility(
                                    visible: !signupProvider.getProgress,
                                    replacement: SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    ),
                                    child: Text("SIGN UP"),
                                  ),
                                ),
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
                  SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //FUNCTIONS START FROM HERE
  Future<void> onTapSignUp(SignupProvider signupProvider) async {
    if (_formKey.currentState!.validate()) {
      SignupRequestModel requestModel = SignupRequestModel(
        _firstNameTEC.text,
        _lastNameTEC.text,
        _emailTEC.text,
        _passwordTEC.text,
        _phoneTEC.text,
        _cityTEC.text,
      );

      bool isSuccess = await signupProvider.signUp(requestModel.toJson());
      if (mounted) {
        if (isSuccess) {
          showSnackBar(
            context: context,
            message: signupProvider.getResponse.message!,
          );
          await Future.delayed(Duration(seconds: 2));
          if (mounted) {
            Navigator.pushReplacementNamed(context, VerifyOtpScreen.name);
          }
        } else {
          showSnackBar(
            context: context,
            message: signupProvider.getResponse.message!,
          );
        }
      }
    }
  }

  void _gotoSignin() {
    Navigator.pushReplacementNamed(context, SigninScreen.name);
  }
}
