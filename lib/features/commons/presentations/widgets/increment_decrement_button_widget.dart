import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/app/app_colors.dart';
import 'package:flutter_ecommerce/features/cart/state_management/cart_provider.dart';
import 'package:flutter_ecommerce/features/products/presentations/screens/product_details_screen.dart';
import 'package:provider/provider.dart';

class IncrementDecrementButton extends StatefulWidget {
  const IncrementDecrementButton({
    super.key,
    required this.quantity,
    this.selectedQuantity,
    this.isFromCart,
    required this.cartIndex,
  });
  final int quantity;
  final int? selectedQuantity;
  final bool? isFromCart;
  final int cartIndex;
  @override
  State<IncrementDecrementButton> createState() =>
      _IncrementDecrementButtonState();
}

class _IncrementDecrementButtonState extends State<IncrementDecrementButton> {
  int count = 1;

  @override
  Widget build(BuildContext context) {
    if (widget.selectedQuantity != null) count = widget.selectedQuantity!;

    return Row(
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
        Text(widget.selectedQuantity?.toString() ?? count.toString()),
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
    );
  }

  void btnOnTap({required bool add}) {
    if (widget.isFromCart != null) {
      CartProvider cartProvider = context.read<CartProvider>();
      if (add) {
        if (count + 1 <= widget.quantity) {
          count++;
          setState(() {});
          cartProvider.cartIncreDecre(cartIndex: widget.cartIndex, add: true);
        } else {
          if (count - 1 >= 1) {
            setState(() {
              count--;
            });
            cartProvider.cartIncreDecre(
              cartIndex: widget.cartIndex,
              add: false,
            );
          }
        }
      }
    } else {
      if (add) {
        if (count + 1 <= widget.quantity) {
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
}
