import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/app/app_units.dart';
import 'package:flutter_ecommerce/features/commons/presentations/widgets/product_card.dart';

class ProductListByCategory extends StatefulWidget {
  final Object? arguments; // can be String, int, etc.
  const ProductListByCategory({super.key, this.arguments});
  static final String name = 'product_list_by_categoy';
  @override
  State<ProductListByCategory> createState() => _ProductListByCategoryState();
}

class _ProductListByCategoryState extends State<ProductListByCategory> {
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
        title: Text(widget.arguments as String),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(AppUnits.horizontalMainPadding),
        itemCount: 5,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 9 / 10,
          crossAxisCount: 3,
          mainAxisSpacing: 8,
          crossAxisSpacing: 3,
        ),
        itemBuilder: (context, index) => ProductCard(itemSize: 200),
      ),
    );
  }
}
