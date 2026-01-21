import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/app/app_units.dart';
import 'package:flutter_ecommerce/features/commons/presentations/widgets/full_page_circuar_loading_widget.dart';
import 'package:flutter_ecommerce/features/commons/presentations/widgets/product_card.dart';
import 'package:flutter_ecommerce/features/commons/state_management/main_nav_bar_provider.dart';
import 'package:flutter_ecommerce/features/products/data/models/product_card_model.dart';
import 'package:flutter_ecommerce/features/products/presentations/screens/product_details_screen.dart';
import 'package:flutter_ecommerce/features/wish_list/state_management/wish_provider.dart';
import 'package:provider/provider.dart';

class ProductListByWish extends StatefulWidget {
  const ProductListByWish({super.key});
  static final String name = 'product_list_by_wish';

  @override
  State<ProductListByWish> createState() => _ProductListByWishState();
}

class _ProductListByWishState extends State<ProductListByWish> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WishProvider wishProvider = context.read<WishProvider>();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      wishProvider.fetchWishList();
    });
  }

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
        body: Consumer<WishProvider>(
          builder: (context, wishProvider, child) => Visibility(
            visible: !wishProvider.getIsWishFetching,
            replacement: FullPageCircuarLoadingWidget(),
            child: wishProvider.getWishList.isNotEmpty
                ? GridView.builder(
                    itemCount: wishProvider.getWishList.length,
                    padding: EdgeInsets.all(AppUnits.horizontalMainPadding),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 3,
                    ),
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          ProductDetailsScreen.name,
                          arguments: wishProvider.getWishList[index].id,
                        );
                      },
                      child: ProductCard(
                        model: ProductCardModel(
                          indexFromParent: index,
                          id: wishProvider.getWishList[index].id,
                          title: wishProvider.getWishList[index].title,
                          photos: wishProvider.getWishList[index].photos,
                          currentPrice:
                              wishProvider.getWishList[index].currentPrice,
                          inWishlist:
                              wishProvider.getWishList[index].inWishlist ??
                              true,
                          wishId: wishProvider.getWishList[index].wishId,
                        ),
                      ),
                    ),
                  )
                : Center(
                    child: Text(
                      "No Wished Product",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
