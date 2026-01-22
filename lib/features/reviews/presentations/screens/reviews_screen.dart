import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/app/app_colors.dart';
import 'package:flutter_ecommerce/app/app_units.dart';
import 'package:flutter_ecommerce/features/commons/presentations/widgets/bottom_static_section_widget.dart';
import 'package:flutter_ecommerce/features/commons/presentations/widgets/full_page_circuar_loading_widget.dart';
import 'package:flutter_ecommerce/features/reviews/data/models/review_model.dart';
import 'package:flutter_ecommerce/features/reviews/presentations/screens/create_review_screen.dart';
import 'package:flutter_ecommerce/features/reviews/presentations/widgets/review_card_widget.dart';
import 'package:flutter_ecommerce/features/reviews/state_management/review_provider.dart';
import 'package:provider/provider.dart';

class ReviewsScreen extends StatefulWidget {
  final String productId;

  const ReviewsScreen({super.key, required this.productId});

  static String name = 'reviews_screen';

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ReviewProvider rp = context.read<ReviewProvider>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (rp.prevPage == null) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
          await rp.fetchReviews(widget.productId);
        });
      }

      scrollController.addListener(() async {
        if (scrollController.position.extentAfter < 300 &&
            rp.getIsFetchingMore == false) {
          await rp.fetchMoreReviews(widget.productId);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 1,
        shadowColor: Colors.grey,
        title: Text('Reviews'),
      ),
      body: Consumer<ReviewProvider>(
        builder: (context, reviewProvider, child) {
          if (reviewProvider.getIsCartFetching) {
            return FullPageCircuarLoadingWidget();
          }
          if (reviewProvider.getReviewList.isEmpty) {
            return Center(
              child: Text(
                'No Product Review!',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: AppUnits.horizontalMainPadding,
                    left: AppUnits.horizontalMainPadding,
                    right: AppUnits.horizontalMainPadding,
                  ),
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: reviewProvider.getReviewList.length + 1,
                    itemBuilder: (context, index) {
                      if (index != reviewProvider.getReviewList.length) {
                        ReviewModel model = reviewProvider.getReviewList[index];
                        return ReviewCardWidget(
                          comment: model.comment,
                          firstName: model.firstName,
                          lastName: model.lastName,
                          rating: model.rating,
                          avatarUrl: model.avatarUrl,
                        );
                      } else {
                        return Visibility(
                          visible: reviewProvider.getIsFetchingMore == false,
                          replacement: Column(
                            children: [
                              SizedBox(height: 10),
                              Center(child: CircularProgressIndicator()),
                            ],
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: 80),
                              Text('No more data'),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
              BottomStaticSectionWidget(
                title: 'Total Reviews (${reviewProvider.getReviewCount})',
                amount: reviewProvider.getReviewCount,
                isTextButton: false,
                textButtonTitle: '',
                buttonWidget: null,
                textButtonOnTap: () {},
                isReview: true,
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: AppColors.themeColor,
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  CreateReviewScreen(productId: widget.productId),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
