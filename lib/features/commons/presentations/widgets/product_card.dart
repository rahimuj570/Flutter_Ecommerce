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
      child: Card(
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.only(
                  topLeft: Radius.circular(AppUnits.round),
                  topRight: Radius.circular(AppUnits.round),
                ),
                child: Image.asset(AppAssetsPath.shoePng),
              ),
            ),
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
                  Text(' 200 ss'),
                  Row(
                    children: [
                      Text('\$200'),
                      SizedBox(width: 6),
                      Icon(Icons.star, color: Colors.amber, size: 16),
                      Text('4.9'),
                      SizedBox(width: 6),
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
