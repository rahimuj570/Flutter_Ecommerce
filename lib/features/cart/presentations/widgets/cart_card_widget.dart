import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/app/app_assets_path.dart';
import 'package:flutter_ecommerce/app/app_colors.dart';
import 'package:flutter_ecommerce/app/app_units.dart';

class CartCardWidget extends StatefulWidget {
  const CartCardWidget({super.key});

  @override
  State<CartCardWidget> createState() => _CartCardWidgetState();
}

class _CartCardWidgetState extends State<CartCardWidget> {
  @override
  Widget build(BuildContext context) {
    TextTheme th = TextTheme.of(context);
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Image.asset(AppAssetsPath.shoePng, width: 100),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Show PUma", style: th.bodyLarge),
                  Text(
                    'Color: Red , Size: X',
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(height: AppUnits.headlineSeparateHeight),
                  Text(
                    '\$300',
                    style: th.bodyLarge!.copyWith(color: AppColors.themeColor),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.delete)),
                SizedBox(height: 20),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        debugPrint('add');
                      },
                      child: Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: AppColors.themeColor,
                        ),
                        child: Icon(Icons.add, size: 18, color: Colors.white),
                      ),
                    ),
                    SizedBox(width: 5),
                    Text('2'),
                    SizedBox(width: 5),

                    GestureDetector(
                      onTap: () {
                        debugPrint('remove');
                      },
                      child: Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: AppColors.themeColor,
                        ),
                        child: Icon(
                          Icons.remove,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
