import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/app/app_colors.dart';
import 'package:flutter_ecommerce/app/app_units.dart';
import 'package:flutter_ecommerce/features/commons/presentations/widgets/bottom_static_section_widget.dart';
import 'package:flutter_ecommerce/features/commons/presentations/widgets/increment_decrement_button_widget.dart';
import 'package:flutter_ecommerce/features/products/presentations/widgets/color_picker_widget.dart';
import 'package:flutter_ecommerce/features/products/presentations/widgets/product_details_carousel_widget.dart';
import 'package:flutter_ecommerce/features/products/presentations/widgets/size_picker_widget.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});
  static final String name = 'product_details_screen';

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
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
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ProductDetailsCarouselWidget(),
                  Padding(
                    padding: EdgeInsets.all(AppUnits.headlineSeparateHeight),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Product Name ds  f s fd f sf sss s ssss',
                                style: textTheme.titleLarge,
                              ),
                            ),
                            IncrementDecrementButton(
                              addOnTap: () {},
                              removeOnTap: () {},
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
                          ],
                        ),
                        SizedBox(height: AppUnits.headlineSeparateHeight - 6),
                        ColorPickerWidget(),
                        SizedBox(height: AppUnits.headlineSeparateHeight),
                        SizePickerWidget(),
                        SizedBox(height: AppUnits.headlineSeparateHeight),
                        Text(
                          'Description',
                          style: TextTheme.of(context).titleMedium,
                        ),
                        SizedBox(height: 5),
                        Text(
                          'data sad fs f sdf  f sd ds f dds f sdf sd f sdf sd sd f s fs ds  fsfs',
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
