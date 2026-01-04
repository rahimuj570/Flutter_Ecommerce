import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/app/app_colors.dart';
import 'package:flutter_ecommerce/app/app_units.dart';
import 'package:flutter_ecommerce/features/products/data/models/product_card_model.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.model});

  final ProductCardModel model;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: ClipRect(
                    child: Image.network(
                      model.photos.isNotEmpty
                          ? model.photos[0]
                          : 'https://img.freepik.com/premium-vector/error-icon-vector-image-can-be-used-no-code_120816-88489.jpg?semt=ais_hybrid&w=740&q=80',
                      loadingBuilder: (context, child, loadingProgress) =>
                          loadingProgress == null
                          ? child
                          : Center(child: CircularProgressIndicator()),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 5),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(AppUnits.round),
                  bottomRight: Radius.circular(AppUnits.round),
                ),
              ),
              padding: EdgeInsets.only(left: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 2),
                  Text(model.title),
                  Row(
                    children: [
                      Text('\$${model.currentPrice}'),
                      Spacer(),
                      Icon(Icons.star, color: Colors.amber, size: 16),
                      Text('4.9'),
                      Spacer(),
                      Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),

                        color: AppColors.themeColor,
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Icon(
                            Icons.favorite_outline,
                            size: 15,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Spacer(),
                      Spacer(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
