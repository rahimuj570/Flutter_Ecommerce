import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/app/app_units.dart';
import 'package:flutter_ecommerce/app/extensions/localization_extension.dart';
import 'package:flutter_ecommerce/features/auth/data/models/user_model.dart';
import 'package:flutter_ecommerce/features/auth/presentations/screens/signin_screen.dart';
import 'package:flutter_ecommerce/features/auth/utils/auth_management.dart';
import 'package:flutter_ecommerce/features/commons/presentations/widgets/button_loading_widget.dart';
import 'package:flutter_ecommerce/features/commons/utils/show_snack_bar.dart';
import 'package:flutter_ecommerce/features/reviews/data/models/review_model.dart';
import 'package:flutter_ecommerce/features/reviews/state_management/review_provider.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:provider/provider.dart';

class UpdateReviewScreen extends StatefulWidget {
  final ReviewModel model;
  final int index;
  const UpdateReviewScreen({
    super.key,
    required this.model,
    required this.index,
  });

  @override
  State<UpdateReviewScreen> createState() => _UpdateReviewScreenState();
}

class _UpdateReviewScreenState extends State<UpdateReviewScreen> {
  double rating = 0;
  final TextEditingController _commentTEC = TextEditingController();
  final GlobalKey<FormState> _fKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    _commentTEC.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLogin();
    _commentTEC.text = widget.model.comment;
    rating = widget.model.rating.toDouble();
  }

  void checkLogin() async {
    if (await AuthManagement.isLoggedIn() == false) {
      Navigator.pushNamed(context, SigninScreen.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.localization.update_review)),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppUnits.horizontalMainPadding),
          child: Column(
            children: [
              SizedBox(height: AppUnits.headlineSeparateHeight),
              Form(
                key: _fKey,
                child: Column(
                  spacing: 15,
                  children: [
                    TextFormField(
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: AuthManagement.getUserModel!.firstName,
                      ),
                    ),
                    TextFormField(
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: AuthManagement.getUserModel!.firstName,
                      ),
                    ),
                    TextFormField(
                      controller: _commentTEC,
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: context.localization.write_review,
                      ),
                      validator: (value) => value!.isEmpty
                          ? context.localization.need_to_write_a_review
                          : null,
                      autovalidateMode: AutovalidateMode.onUnfocus,
                    ),
                    StarRating(
                      allowHalfRating: false,
                      rating: rating,
                      starCount: 5,
                      onRatingChanged: (rating) {
                        setState(() {
                          this.rating = rating;
                        });
                      },
                    ),

                    Consumer<ReviewProvider>(
                      builder: (context, value, child) => FilledButton(
                        onPressed: () =>
                            value.getIsUpdating ? null : onTapUpdate(value),
                        child: value.getIsUpdating
                            ? Center(child: ButtonLoadingWidget())
                            : Text(context.localization.update),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onTapUpdate(ReviewProvider rp) async {
    if (_fKey.currentState!.validate()) {
      if (rating == 0) {
        showSnackBar(
          context: context,
          message: 'Need to give a rating',
          isError: true,
        );
      } else {
        UserModel user = AuthManagement.getUserModel!;
        await rp.updateReview(
          ReviewModel(
            avatarUrl: user.avatarUrl,
            firstName: user.firstName,
            lastName: user.lastName,
            comment: _commentTEC.text,
            rating: rating.toInt(),
            reviewId: widget.model.reviewId,
            productId: widget.model.productId,
          ),
          widget.index,
        );

        if (rp.getResponseModel.isSuccess) {
          _commentTEC.clear();
          setState(() {
            rating = 0;
          });
          showSnackBar(context: context, message: rp.getResponseModel.message!);
        } else {
          showSnackBar(
            context: context,
            message: rp.getResponseModel.message!,
            isError: true,
          );
        }
      }
    }
  }
}
