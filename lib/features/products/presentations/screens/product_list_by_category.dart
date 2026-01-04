import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/app/app_units.dart';
import 'package:flutter_ecommerce/features/commons/presentations/widgets/full_page_circuar_loading_widget.dart';
import 'package:flutter_ecommerce/features/commons/presentations/widgets/product_card.dart';
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<ProductProvider>().fethingProductCardListByCategry(
        widget.arguments['id'],
      );
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
          child: GridView.builder(
            padding: EdgeInsets.all(AppUnits.horizontalMainPadding),
            itemCount: productCardProvider.getProductCardList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 9 / 10,
              crossAxisCount: MediaQuery.sizeOf(context).width < 600 ? 2 : 3,
              mainAxisSpacing: 8,
              crossAxisSpacing: 3,
            ),
            itemBuilder: (context, index) => ProductCard(
              model: productCardProvider.getProductCardList[index],
            ),
          ),
        ),
      ),
    );
  }
}
