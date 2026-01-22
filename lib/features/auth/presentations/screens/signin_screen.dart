import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/app/app_colors.dart';
import 'package:flutter_ecommerce/app/extensions/localization_extension.dart';
import 'package:flutter_ecommerce/core/models/network_response_model.dart';
import 'package:flutter_ecommerce/features/auth/data/models/login_request_model.dart';
import 'package:flutter_ecommerce/features/auth/presentations/screens/forgot_password_screen.dart';
import 'package:flutter_ecommerce/features/auth/presentations/screens/signup_screen.dart';
import 'package:flutter_ecommerce/features/auth/presentations/screens/verify_otp_screen.dart';
import 'package:flutter_ecommerce/features/auth/presentations/widgets/app_logo_widget.dart';
import 'package:flutter_ecommerce/features/auth/state_management/login_provider.dart';
import 'package:flutter_ecommerce/features/commons/presentations/screens/main_nav_holder_screen.dart';
import 'package:flutter_ecommerce/features/commons/presentations/widgets/button_loading_widget.dart';
import 'package:flutter_ecommerce/features/commons/utils/show_snack_bar.dart';
import 'package:provider/provider.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key, this.isComesFromRunningProcess});
  final String? isComesFromRunningProcess;
  static String name = '/signin';
  static final String comeFromRunningProceesKey = 'fromRunningProcess';

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final TextEditingController _emailTEC = TextEditingController();
  final TextEditingController _passwordTEC = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isObsecure = true;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = TextTheme.of(context);
    return SafeArea(
      child: ChangeNotifierProvider<LoginProvider>(
        create: (context) => LoginProvider(),
        builder: (context, child) => Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 50),
                  AppLogoWidget(width: 100),
                  SizedBox(height: 5),
                  Text(
                    context.localization.signin_profile,
                    style: textTheme.headlineMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    context.localization.wellcome_back,
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
                            controller: _emailTEC,
                            decoration: InputDecoration(
                              hintText: context.localization.email,
                            ),

                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            textInputAction: TextInputAction.next,
                            validator: (value) => value!.isEmpty
                                ? context.localization.insert_email
                                : null,
                          ),
                          TextFormField(
                            controller: _passwordTEC,
                            decoration: InputDecoration(
                              hintText: context.localization.password,

                              suffixIcon: IconButton(
                                onPressed: () {
                                  isObsecure = !isObsecure;
                                  setState(() {});
                                },
                                icon: Icon(Icons.remove_red_eye_outlined),
                              ),
                            ),

                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            obscureText: isObsecure,
                            textInputAction: TextInputAction.done,
                            validator: (value) => value!.isEmpty
                                ? context.localization.insert_pass
                                : null,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.all(1),
                                  minimumSize: Size.zero,
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    ForgotPasswordScreen.name,
                                  );
                                },
                                child: Text(context.localization.fogot_pass_qn),
                              ),
                            ],
                          ),

                          Consumer<LoginProvider>(
                            builder: (context, loginProvider, child) =>
                                FilledButton(
                                  onPressed: () =>
                                      loginProvider.getIsLoginProcess
                                      ? null
                                      : _loginOperation(loginProvider),
                                  child: Visibility(
                                    visible: !loginProvider.getIsLoginProcess,
                                    replacement: ButtonLoadingWidget(),
                                    child: Text(context.localization.login),
                                  ),
                                ),
                          ),
                          RichText(
                            text: TextSpan(
                              style: textTheme.bodyMedium,
                              text: context.localization.dont_have_account_qn,
                              children: [
                                TextSpan(
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.themeColor,
                                  ),
                                  text: ' ${context.localization.signup}',
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
      ),
    );
  }

  void _loginOperation(LoginProvider loginProvider) async {
    if (_formKey.currentState!.validate()) {
      LoginRequestModel model = LoginRequestModel(
        email: _emailTEC.text.trim(),
        password: _passwordTEC.text,
      );
      await loginProvider.login(model);
      NetworkResponseModel res = loginProvider.getNetWorkResponse;
      if (res.isSuccess) {
        if (mounted) {
          showSnackBar(context: context, message: res.message!);
          if (widget.isComesFromRunningProcess == null) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              MainNavHolderScreen.name,
              (route) => false,
            );
          } else {
            Navigator.popUntil(context, (route) => false);
          }
        }
      } else {
        if (res.message!.contains('verified')) {
          mounted
              ? Navigator.pushReplacementNamed(
                  context,
                  arguments: _emailTEC.text.trim(),
                  VerifyOtpScreen.name,
                )
              : null;
        } else {
          mounted
              ? showSnackBar(
                  isError: true,
                  context: context,
                  message: res.message!,
                )
              : null;
        }
      }
    }
  }

  void _gotoSignup() {
    Navigator.pushReplacementNamed(context, SignupScreen.name);
  }

  @override
  void dispose() {
    // TODO: implement dispose

    _emailTEC.dispose();
    _passwordTEC.dispose();
    super.dispose();
  }
}
