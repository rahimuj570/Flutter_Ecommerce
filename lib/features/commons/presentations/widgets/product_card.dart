import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/app/app_assets_path.dart';
import 'package:flutter_ecommerce/app/app_colors.dart';
import 'package:flutter_ecommerce/app/app_units.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.itemSize});
  final double itemSize;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: itemSize,
      height: itemSize,
      child: Card(
        color: Colors.white,
        elevation: 2,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppUnits.round),
                topRight: Radius.circular(AppUnits.round),
              ),
              child: Container(
                color: AppColors.themeColor.withAlpha(
                  AppUnits.themeColorOpacity,
                ),
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(AppAssetsPath.shoePng, fit: BoxFit.contain),
              ),
            ),
            //Details Cotainer Start
            Container(
              padding: EdgeInsets.all(5),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('data'),
                  Row(
                    children: [
                      Text('\$200'),
                      SizedBox(width: 6),
                      Icon(Icons.star, color: Colors.amber, size: 16),
                      Text('4.9'),
                      SizedBox(width: 6),
                      Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(),

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
