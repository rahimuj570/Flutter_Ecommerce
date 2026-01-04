import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/app/app_units.dart';
import 'package:flutter_ecommerce/features/commons/presentations/widgets/product_card.dart';
import 'package:flutter_ecommerce/features/commons/state_management/main_nav_bar_provider.dart';
import 'package:flutter_ecommerce/features/products/data/models/product_card_model.dart';
import 'package:provider/provider.dart';

class ProductListByWish extends StatefulWidget {
  const ProductListByWish({super.key});
  static final String name = 'product_list_by_wish';

  @override
  State<ProductListByWish> createState() => _ProductListByWishState();
}

class _ProductListByWishState extends State<ProductListByWish> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        context.read<MainNavBarProvider>().changeIndex(0);
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              context.read<MainNavBarProvider>().changeIndex(0);
            },
            icon: Icon(Icons.arrow_back_ios_rounded),
          ),
          title: Text('Wish'),
          backgroundColor: Colors.white,
          elevation: 1,
          shadowColor: Colors.grey,
          surfaceTintColor: Colors.transparent,
        ),
        body: GridView.builder(
          itemCount: 10,
          padding: EdgeInsets.all(AppUnits.horizontalMainPadding),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 8,
            crossAxisSpacing: 3,
          ),
          itemBuilder: (context, index) => ProductCard(
            model: ProductCardModel(
              id: 'id',
              title: 'title',
              photos: ['photos'],
              currentPrice: 1,
              inWishlist: true,
            ),
          ),
        ),
      ),
    );
  }
}
