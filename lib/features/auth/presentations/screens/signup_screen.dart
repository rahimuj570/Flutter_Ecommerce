import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/app/app_colors.dart';
import 'package:flutter_ecommerce/app/extensions/localization_extension.dart';
import 'package:flutter_ecommerce/features/auth/data/models/signup_request_model.dart';
import 'package:flutter_ecommerce/features/auth/presentations/screens/signin_screen.dart';
import 'package:flutter_ecommerce/features/auth/presentations/screens/verify_otp_screen.dart';
import 'package:flutter_ecommerce/features/auth/presentations/widgets/app_logo_widget.dart';
import 'package:flutter_ecommerce/features/auth/state_management/signup_provider.dart';
import 'package:flutter_ecommerce/features/commons/presentations/widgets/button_loading_widget.dart';
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
                    context.localization.signup_profile,
                    style: textTheme.headlineMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    context.localization.get_started,
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
                            decoration: InputDecoration(
                              hintText: context.localization.first_name,
                            ),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            textInputAction: TextInputAction.next,
                            validator: (value) => value!.isEmpty
                                ? context.localization.insert_first_name
                                : null,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: context.localization.last_name,
                            ),
                            controller: _lastNameTEC,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            textInputAction: TextInputAction.next,
                            validator: (value) => value!.isEmpty
                                ? context.localization.insert_last_name
                                : null,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: context.localization.email,
                            ),
                            controller: _emailTEC,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            textInputAction: TextInputAction.next,
                            validator: (value) => value!.isEmpty
                                ? context.localization.insert_email
                                : null,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: context.localization.phone,
                            ),
                            controller: _phoneTEC,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            textInputAction: TextInputAction.next,
                            validator: (value) => value!.isEmpty
                                ? context.localization.insert_phone
                                : null,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: context.localization.password,
                            ),
                            controller: _passwordTEC,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            obscureText: true,
                            textInputAction: TextInputAction.next,
                            validator: (value) => value!.isEmpty
                                ? context.localization.insert_pass
                                : null,
                          ),

                          TextFormField(
                            controller: _cityTEC,
                            maxLines: 3,
                            decoration: InputDecoration(
                              hintText: context.localization.shipping_address,
                            ),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            textInputAction: TextInputAction.done,
                            validator: (value) => value!.isEmpty
                                ? context.localization.insert_address
                                : null,
                          ),
                          Consumer<SignupProvider>(
                            builder: (context, signupProvider, child) =>
                                FilledButton(
                                  onPressed: () => signupProvider.getProgress
                                      ? null
                                      : onTapSignUp(signupProvider),
                                  child: Visibility(
                                    visible: !signupProvider.getProgress,
                                    replacement: ButtonLoadingWidget(),
                                    child: Text(context.localization.signup),
                                  ),
                                ),
                          ),
                          RichText(
                            text: TextSpan(
                              style: textTheme.bodyMedium,
                              text: context.localization.already_have_account,
                              children: [
                                TextSpan(
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.themeColor,
                                  ),
                                  text: " ${context.localization.login}",
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
        _firstNameTEC.text.trim(),
        _lastNameTEC.text.trim(),
        _emailTEC.text.trim(),
        _passwordTEC.text,
        _phoneTEC.text.trim(),
        _cityTEC.text.trim(),
      );

      bool isSuccess = await signupProvider.signUp(requestModel.toJson());

      if (isSuccess) {
        mounted
            ? showSnackBar(
                context: context,
                message: signupProvider.getResponse.message!,
              )
            : null;
        await Future.delayed(Duration(seconds: 2));
        if (mounted) {
          Navigator.pushReplacementNamed(
            context,
            arguments: _emailTEC.text.trim(),
            VerifyOtpScreen.name,
          );
        }
      } else {
        mounted
            ? showSnackBar(
                isError: true,
                context: context,
                message: signupProvider.getResponse.message!,
              )
            : null;
      }
    }
  }

  void _gotoSignin() {
    Navigator.pushReplacementNamed(context, SigninScreen.name);
  }

  @override
  void dispose() {
    // TODO: implement dispose

    _cityTEC.dispose();
    _emailTEC.dispose();
    _firstNameTEC.dispose();
    _lastNameTEC.dispose();
    _passwordTEC.dispose();
    _phoneTEC.dispose();

    super.dispose();
  }
}
