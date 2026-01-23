import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/app/extensions/localization_extension.dart';
import 'package:flutter_ecommerce/features/auth/data/models/user_model.dart';
import 'package:flutter_ecommerce/features/auth/presentations/screens/signin_screen.dart';
import 'package:flutter_ecommerce/features/auth/state_management/profile_provider.dart';
import 'package:flutter_ecommerce/features/auth/state_management/signup_provider.dart';
import 'package:flutter_ecommerce/features/auth/utils/auth_management.dart';
import 'package:flutter_ecommerce/features/commons/presentations/widgets/button_loading_widget.dart';
import 'package:flutter_ecommerce/features/commons/utils/show_snack_bar.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  static String name = '/profile_screen';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameTEC = TextEditingController();
  final TextEditingController _lastNameTEC = TextEditingController();
  final TextEditingController _phoneTEC = TextEditingController();
  final TextEditingController _cityTEC = TextEditingController();
  final TextEditingController _avaterUrlTEC = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLoggedIn();
  }

  void checkLoggedIn() async {
    if (await AuthManagement.isLoggedIn() == false) {
      Navigator.pushNamed(context, SigninScreen.name);
    } else {
      UserModel model = AuthManagement.getUserModel!;
      _cityTEC.text = model.city;
      _firstNameTEC.text = model.firstName;
      _lastNameTEC.text = model.lastName;
      _phoneTEC.text = model.phone;
      if (model.avatarUrl != null) {
        _avaterUrlTEC.text = model.avatarUrl!;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    UserModel model = AuthManagement.getUserModel!;
    final TextTheme textTheme = TextTheme.of(context);
    return ChangeNotifierProvider(
      create: (context) => SignupProvider(),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(title: Text('Profile')),
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 50),
                  SizedBox(
                    width: 200,
                    height: 200,
                    child: ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(100),
                      child: Image.network(
                        fit: BoxFit.cover,
                        model.avatarUrl ??
                            'https://static.vecteezy.com/system/resources/thumbnails/020/168/700/small/faceless-male-silhouette-empty-state-avatar-icon-businessman-editable-404-not-found-persona-for-ux-ui-design-cartoon-profile-picture-with-red-dot-colorful-website-mobile-error-user-badge-vector.jpg',
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '${model.firstName} ${model.lastName}',
                    style: textTheme.headlineMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    context.localization.update_profile_if_you_need,
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
                            controller: _avaterUrlTEC,
                            decoration: InputDecoration(
                              hintText: context.localization.avater_url,
                            ),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            textInputAction: TextInputAction.next,
                          ),
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
                          Consumer<ProfileProvider>(
                            builder: (context, profileProvider, child) =>
                                FilledButton(
                                  onPressed: () => profileProvider.getIsUpdating
                                      ? null
                                      : onTapUpdate(profileProvider),
                                  child: Visibility(
                                    visible: !profileProvider.getIsUpdating,
                                    replacement: ButtonLoadingWidget(),
                                    child: Text(context.localization.update),
                                  ),
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
  Future<void> onTapUpdate(ProfileProvider profileProvider) async {
    if (_formKey.currentState!.validate()) {
      await profileProvider.updateProfile({
        'first_name': _firstNameTEC.text.trim(),
        'last_name': _lastNameTEC.text.trim(),
        'phone': _phoneTEC.text.trim(),
        'avatar_url': _avaterUrlTEC.text.isEmpty ? null : _avaterUrlTEC.text,
        'city': _cityTEC.text.trim(),
      });

      bool isSuccess = profileProvider.getResponseModel.isSuccess;

      if (isSuccess) {
        mounted
            ? showSnackBar(
                context: context,
                message: profileProvider.getResponseModel.message!,
              )
            : null;
        if (mounted) {
          Navigator.pop(context, (route) => false);
        }
      } else {
        mounted
            ? showSnackBar(
                isError: true,
                context: context,
                message: profileProvider.getResponseModel.message!,
              )
            : null;
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose

    _cityTEC.dispose();
    _firstNameTEC.dispose();
    _lastNameTEC.dispose();
    _phoneTEC.dispose();

    super.dispose();
  }
}
