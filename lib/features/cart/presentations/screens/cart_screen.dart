import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/app/app_units.dart';
import 'package:flutter_ecommerce/features/cart/presentations/widgets/cart_card_widget.dart';
import 'package:flutter_ecommerce/features/commons/presentations/widgets/bottom_static_section_widget.dart';
import 'package:flutter_ecommerce/features/commons/presentations/widgets/full_page_circuar_loading_widget.dart';
import 'package:flutter_ecommerce/features/commons/state_management/main_nav_bar_provider.dart';
import 'package:flutter_ecommerce/features/cart/state_management/cart_provider.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CartProvider cp = context.read<CartProvider>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      cp.fetchCartList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        context.read<MainNavBarProvider>().changeIndex(0);
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              context.read<MainNavBarProvider>().changeIndex(0);
            },
            icon: Icon(Icons.arrow_back_ios_new_rounded),
          ),
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          elevation: 1,
          shadowColor: Colors.grey,
          title: Text('Cart'),
        ),
        body: Consumer<CartProvider>(
          builder: (context, cartProvider, child) {
            if (cartProvider.getIsCartFetching) {
              return FullPageCircuarLoadingWidget();
            }
            if (cartProvider.getCartList.isEmpty) {
              return Center(
                child: Text(
                  'No Product Carted!',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              );
            }

            return Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: AppUnits.horizontalMainPadding,
                      left: AppUnits.horizontalMainPadding,
                      right: AppUnits.horizontalMainPadding,
                    ),
                    child: ListView.builder(
                      itemCount: cartProvider.getCartList.length + 1,
                      itemBuilder: (context, index) =>
                          index != cartProvider.getCartList.length
                          ? CartCardWidget(
                              cartIndex: index,
                              cartModel: cartProvider.getCartList[index],
                            )
                          : SizedBox(height: 80),
                    ),
                  ),
                ),
                BottomStaticSectionWidget(
                  title: 'Total Price',
                  amount: cartProvider.getTotalAmount(),
                  isTextButton: true,
                  textButtonTitle: 'Checkout',
                  buttonWidget: null,
                  textButtonOnTap: () {},
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
