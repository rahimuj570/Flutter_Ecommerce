import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/app/app_colors.dart';
import 'package:flutter_ecommerce/app/app_units.dart';
import 'package:flutter_ecommerce/features/cart/presentations/widgets/cart_card_widget.dart';
import 'package:flutter_ecommerce/features/commons/presentations/widgets/bottom_static_section_widget.dart';
import 'package:flutter_ecommerce/features/commons/presentations/widgets/full_page_circuar_loading_widget.dart';
import 'package:flutter_ecommerce/features/cart/state_management/cart_provider.dart';
import 'package:flutter_ecommerce/features/reviews/presentations/widgets/review_card_widget.dart';
import 'package:provider/provider.dart';

class ReviewsScreen extends StatefulWidget {
  final String productId;

  const ReviewsScreen({super.key, required this.productId});

  static String name = 'reviews_screen';

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CartProvider cp = context.read<CartProvider>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      cp.fetchCartList();
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
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          if (cartProvider.getIsCartFetching) {
            return FullPageCircuarLoadingWidget();
          }
          if (cartProvider.getCartList.isEmpty) {
            return Center(
              child: Text(
                'No Product Carted!',
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
                    itemCount: cartProvider.getCartList.length + 1,
                    itemBuilder: (context, index) =>
                        index != cartProvider.getCartList.length
                        ? ReviewCardWidget()
                        : SizedBox(height: 80),
                  ),
                ),
              ),
              BottomStaticSectionWidget(
                title: 'Total Reviews (${2 + 2})',
                amount: cartProvider.getTotalAmount(),
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
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
