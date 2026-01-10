import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/app/app_colors.dart';
import 'package:flutter_ecommerce/app/app_units.dart';
import 'package:flutter_ecommerce/features/commons/presentations/widgets/bottom_static_section_widget.dart';
import 'package:flutter_ecommerce/features/commons/presentations/widgets/full_page_circuar_loading_widget.dart';
import 'package:flutter_ecommerce/features/commons/presentations/widgets/increment_decrement_button_widget.dart';
import 'package:flutter_ecommerce/features/products/presentations/widgets/color_picker_widget.dart';
import 'package:flutter_ecommerce/features/products/presentations/widgets/product_details_carousel_widget.dart';
import 'package:flutter_ecommerce/features/products/presentations/widgets/size_picker_widget.dart';
import 'package:flutter_ecommerce/features/products/state_management/product_provider.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.productId});
  static final String name = 'product_details_screen';
  final String productId;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ProductProvider productProvider = context.read<ProductProvider>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      productProvider.fetchProductById(widget.productId);
    });
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = TextTheme.of(context);
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
      body: Consumer<ProductProvider>(
        builder: (context, value, child) => Visibility(
          visible: !value.getIsFatchingProductById,
          replacement: FullPageCircuarLoadingWidget(),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ProductDetailsCarouselWidget(
                        images: value.getProductById.photos,
                      ),
                      Padding(
                        padding: EdgeInsets.all(
                          AppUnits.headlineSeparateHeight,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    value.getProductById.title,
                                    style: textTheme.titleLarge,
                                  ),
                                ),
                                IncrementDecrementButton(
                                  quantity: value.productQuantity,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.star, size: 22, color: Colors.amber),
                                Text('4.8', style: textTheme.bodyLarge),
                                TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Reviews',
                                    style: textTheme.bodyLarge!.copyWith(
                                      color: AppColors.themeColor,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    padding: EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: AppColors.themeColor,
                                    ),
                                    child: Icon(
                                      Icons.favorite_outline,
                                      size: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  'In Stock: ${value.getProductById.quantity}',
                                ),
                              ],
                            ),
                            SizedBox(
                              height: AppUnits.headlineSeparateHeight - 6,
                            ),
                            if (value.getProductById.colors.isNotEmpty)
                              ColorPickerWidget(
                                colorList: value.getProductById.colors
                                    .map((e) => e.toLowerCase())
                                    .toList(),
                              ),
                            if (value.getProductById.colors.isNotEmpty)
                              SizedBox(height: AppUnits.headlineSeparateHeight),
                            if (value.getProductById.colors.isNotEmpty)
                              SizePickerWidget(
                                sizeList: value.getProductById.sizes,
                              ),
                            SizedBox(height: AppUnits.headlineSeparateHeight),
                            Text(
                              'Description',
                              style: TextTheme.of(context).titleMedium,
                            ),
                            SizedBox(height: 5),
                            Text(
                              value.getProductById.description,
                              style: textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              BottomStaticSectionWidget(
                title: 'Price',
                amount: value.getProductById.currentPrice,
                isTextButton: true,
                textButtonTitle: 'Add to cart',
                buttonWidget: null,
                textButtonOnTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
