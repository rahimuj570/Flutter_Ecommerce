import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/app/app_colors.dart';
import 'package:flutter_ecommerce/app/app_units.dart';
import 'package:flutter_ecommerce/core/models/network_response_model.dart';
import 'package:flutter_ecommerce/features/cart/data/models/cart_card_model.dart';
import 'package:flutter_ecommerce/features/cart/state_management/cart_provider.dart';
import 'package:flutter_ecommerce/features/commons/presentations/widgets/increment_decrement_button_widget.dart';
import 'package:flutter_ecommerce/features/commons/utils/show_snack_bar.dart';
import 'package:provider/provider.dart';

class CartCardWidget extends StatefulWidget {
  const CartCardWidget({
    super.key,
    required this.cartModel,
    required this.cartIndex,
  });
  final CartCardModel cartModel;
  final int cartIndex;
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
            Image.network(
              widget.cartModel.photo ?? '',
              loadingBuilder: (context, child, loadingProgress) =>
                  loadingProgress == null ? child : CircularProgressIndicator(),
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.cartModel.productTitle, style: th.bodyLarge),
                  Text(
                    'Color: ${widget.cartModel.color ?? 'N/A'} , Size: ${widget.cartModel.size ?? 'N/A'}',
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(height: AppUnits.headlineSeparateHeight),
                  Text(
                    '\$${widget.cartModel.price}',
                    style: th.bodyLarge!.copyWith(color: AppColors.themeColor),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Consumer<CartProvider>(
                  builder: (context, cartProvider, child) {
                    final whichOneDeleting =
                        cartProvider.getCartDeletingIndex == widget.cartIndex;
                    if (whichOneDeleting) {
                      return SizedBox(
                        width: 48,
                        height: 48,
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                    return IconButton(
                      onPressed: () async {
                        await cartProvider.deleteCart(widget.cartIndex);
                        NetworkResponseModel responseModel =
                            cartProvider.getResponseModel;
                        if (responseModel.isSuccess) {
                          showSnackBar(
                            context: context,
                            message: responseModel.message!,
                          );
                        } else {
                          showSnackBar(
                            context: context,
                            message: responseModel.message!,
                            isError: true,
                          );
                        }
                      },
                      icon: Icon(CupertinoIcons.delete),
                    );
                  },
                ),
                SizedBox(height: 20),
                IncrementDecrementButton(
                  cartIndex: widget.cartIndex,
                  quantity: widget.cartModel.stockQuantity,
                  selectedQuantity: widget.cartModel.selectedQuantity,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
