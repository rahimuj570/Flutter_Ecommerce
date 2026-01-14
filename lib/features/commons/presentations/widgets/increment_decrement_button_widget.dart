import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/app/app_colors.dart';
import 'package:flutter_ecommerce/features/products/presentations/screens/product_details_screen.dart';
import 'package:flutter_ecommerce/features/products/state_management/product_provider.dart';
import 'package:provider/provider.dart';

class IncrementDecrementButton extends StatefulWidget {
  const IncrementDecrementButton({super.key, this.quantity});
  final int? quantity;

  @override
  State<IncrementDecrementButton> createState() =>
      _IncrementDecrementButtonState();
}

class _IncrementDecrementButtonState extends State<IncrementDecrementButton> {
  int count = 1;

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, value, child) => Row(
        children: [
          GestureDetector(
            onTap: () => btnOnTap(add: true),
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
          Text(count.toString()),
          SizedBox(width: 5),

          GestureDetector(
            onTap: () => btnOnTap(add: false),
            child: Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: AppColors.themeColor,
              ),
              child: Icon(Icons.remove, size: 18, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void btnOnTap({required bool add}) {
    if (add) {
      if (count + 1 <= widget.quantity!) {
        count++;
        setState(() {});
      } else {
        if (count - 1 >= 1) {
          count--;
        }
      }
    }
    ProductDetailsScreen.selectedQuantity = count;
  }
}
