import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/features/commons/presentations/widgets/bottom_static_section_widget.dart';
import 'package:flutter_ecommerce/features/products/presentations/widgets/product_details_carousel_widget.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});
  static final String name = 'product_details_screen';

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Text('Product Details'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(children: [ProductDetailsCarouselWidget()]),
            ),
          ),
          BottomStaticSectionWidget(
            title: 'Price',
            amount: 100,
            isTextButton: true,
            textButtonTitle: 'Add to cart',
            buttonWidget: null,
            textButtonOnTap: () {},
          ),
        ],
      ),
    );
  }
}
