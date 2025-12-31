import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/app/app_colors.dart';
import 'package:flutter_ecommerce/core/models/network_response_model.dart';
import 'package:flutter_ecommerce/features/auth/data/models/verify_request_model.dart';
import 'package:flutter_ecommerce/features/auth/presentations/screens/signup_screen.dart';
import 'package:flutter_ecommerce/features/auth/presentations/widgets/app_logo_widget.dart';
import 'package:flutter_ecommerce/features/auth/state_management/verify_otp_provider.dart';
import 'package:flutter_ecommerce/features/commons/presentations/screens/main_nav_holder_screen.dart';
import 'package:flutter_ecommerce/features/commons/presentations/widgets/button_loading_widget.dart';
import 'package:flutter_ecommerce/features/commons/utils/show_snack_bar.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({super.key, required this.email});
  static String name = '/verify_otp';
  final String email;

  @override
  State<VerifyOtpScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<VerifyOtpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _otpTEC = TextEditingController();
  bool isObsecure = true;

  int remainTime = 300;
  Future<void> _updateTime() async {
    while (remainTime > 0) {
      await Future.delayed(Duration(seconds: 1));
      setState(() {
        remainTime--;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _updateTime();
  }

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
      child: ChangeNotifierProvider(
        create: (context) => VerifyOtpProvider(),
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
                            controller: _otpTEC,
                            defaultPinTheme: defaultPinTheme,
                            focusedPinTheme: focusedPinTheme,
                            submittedPinTheme: submittedPinTheme,
                            // validator: (s) {
                            //   return s == '1234' ? null : 'Pin is incorrect';
                            // },
                            pinputAutovalidateMode:
                                PinputAutovalidateMode.onSubmit,
                            showCursor: true,
                            onCompleted: (pin) => print(pin),
                          ),
                          Consumer<VerifyOtpProvider>(
                            builder: (context, value, child) => FilledButton(
                              onPressed: () => value.getIsVerifyProcessing
                                  ? null
                                  : _verifyOperation(value),
                              child: Visibility(
                                visible: !value.getIsVerifyProcessing,
                                replacement: ButtonLoadingWidget(),
                                child: Text("VERIFY"),
                              ),
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              style: textTheme.bodyMedium,
                              text: 'This code ill expire in ',
                              children: [
                                TextSpan(
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.themeColor,
                                  ),
                                  text: '${remainTime}s',
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = _gotoSignup,
                                ),
                              ],
                            ),
                          ),

                          TextButton(
                            style: TextButton.styleFrom(
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            onPressed: () {},
                            child: Text('Resend Code'),
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
      ),
    );
  }

  void _gotoSignup() {
    Navigator.pushReplacementNamed(context, SignupScreen.name);
  }

  Future<void> _verifyOperation(VerifyOtpProvider verifyOtpProvider) async {
    if (_formKey.currentState!.validate()) {
      VerifyRequestModel model = VerifyRequestModel(
        email: widget.email,
        otp: _otpTEC.text.trim(),
      );
      await verifyOtpProvider.verifyOtp(model);
      NetworkResponseModel responseModel = verifyOtpProvider.getResponseModel;
      if (responseModel.isSuccess) {
        mounted
            ? Navigator.pushReplacementNamed(context, MainNavHolderScreen.name)
            : null;
      } else {
        mounted
            ? showSnackBar(
                isError: true,
                context: context,
                message: responseModel.message!,
              )
            : null;
      }
    }
  }
}
