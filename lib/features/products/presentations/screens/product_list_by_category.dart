import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/app/app_units.dart';
import 'package:flutter_ecommerce/features/commons/presentations/widgets/full_page_circuar_loading_widget.dart';
import 'package:flutter_ecommerce/features/commons/presentations/widgets/product_card.dart';
import 'package:flutter_ecommerce/features/products/presentations/screens/product_details_screen.dart';
import 'package:flutter_ecommerce/features/products/state_management/product_provider.dart';
import 'package:provider/provider.dart';

class ProductListByCategory extends StatefulWidget {
  final Map<String, dynamic> arguments; // can be String, int, etc.
  const ProductListByCategory({super.key, required this.arguments});
  static final String name = 'product_list_by_categoy';
  @override
  State<ProductListByCategory> createState() => _ProductListByCategoryState();
}

class _ProductListByCategoryState extends State<ProductListByCategory> {
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ProductProvider productProvider = context.read<ProductProvider>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      productProvider.fethingProductCardListByCategry(
        10,
        1,
        widget.arguments['id'],
      );
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        if (productProvider.getIsFetchingMore == false &&
            productProvider.getPageNo <= productProvider.getLastPage) {
          productProvider.fethingProductCardListByCategry(
            10,
            productProvider.getPageNo,
            widget.arguments['id'],
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_rounded),
        ),
        elevation: 1,
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
        shadowColor: Colors.grey,
        title: Text(widget.arguments['title']),
      ),
      body: Consumer<ProductProvider>(
        builder: (context, productCardProvider, child) => Visibility(
          visible: !productCardProvider.getIsFetchingProductCardList,
          replacement: FullPageCircuarLoadingWidget(),
          child: Padding(
            padding: EdgeInsets.all(AppUnits.horizontalMainPadding),
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverGrid.builder(
                  itemCount: productCardProvider.getProductCardList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 9 / 10,
                    crossAxisCount: MediaQuery.sizeOf(context).width < 600
                        ? 2
                        : 3,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 3,
                  ),
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () => Navigator.pushNamed(
                      context,
                      ProductDetailsScreen.name,
                      arguments:
                          productCardProvider.getProductCardList[index].id,
                    ),
                    child: ProductCard(
                      model: productCardProvider.getProductCardList[index],
                    ),
                  ),
                ),

                SliverToBoxAdapter(child: SizedBox(height: 30)),

                Consumer<ProductProvider>(
                  builder: (context, value, child) => SliverToBoxAdapter(
                    child: Visibility(
                      visible: !value.getIsFetchingMore,
                      replacement: Center(child: CircularProgressIndicator()),
                      child: Center(
                        child: Container(
                          margin: EdgeInsets.only(bottom: 25),
                          child: Text('No data to show'),
                        ),
                      ),
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
}
