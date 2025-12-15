import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/app/app_colors.dart';
import 'package:flutter_ecommerce/features/auth/presentations/screens/signup_screen.dart';
import 'package:flutter_ecommerce/features/auth/presentations/widgets/app_logo_widget.dart';
import 'package:pinput/pinput.dart';

class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({super.key});
  static String name = '/verify_otp';

  @override
  State<VerifyOtpScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<VerifyOtpScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isObsecure = true;
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      margin: EdgeInsets.symmetric(horizontal: 5),
      textStyle: TextStyle(
        fontSize: 20,
        color: AppColors.themeColor,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.themeColor),
        borderRadius: BorderRadius.circular(10),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );

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
                  "Verify OTP",
                  style: textTheme.headlineMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text("Enter your OTP", style: textTheme.bodyMedium),
                SizedBox(height: 25),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Column(
                      spacing: 15,
                      children: [
                        Pinput(
                          defaultPinTheme: defaultPinTheme,
                          focusedPinTheme: focusedPinTheme,
                          submittedPinTheme: submittedPinTheme,
                          validator: (s) {
                            return s == '2222' ? null : 'Pin is incorrect';
                          },
                          pinputAutovalidateMode:
                              PinputAutovalidateMode.onSubmit,
                          showCursor: true,
                          onCompleted: (pin) => print(pin),
                        ),
                        FilledButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {}
                          },
                          child: Text("VERIFY"),
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
