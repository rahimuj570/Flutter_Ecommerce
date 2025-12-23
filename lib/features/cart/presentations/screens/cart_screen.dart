import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/app/app_units.dart';
import 'package:flutter_ecommerce/features/cart/presentations/widgets/cart_card_widget.dart';
import 'package:flutter_ecommerce/features/commons/presentations/widgets/bottom_static_section_widget.dart';
import 'package:flutter_ecommerce/features/commons/state_management/main_nav_bar_provider.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
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
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  top: AppUnits.horizontalMainPadding,
                  left: AppUnits.horizontalMainPadding,
                  right: AppUnits.horizontalMainPadding,
                ),
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) =>
                      index != 9 ? CartCardWidget() : SizedBox(height: 80),
                ),
              ),
            ),
            BottomStaticSectionWidget(
              title: 'Total Price',
              amount: 2000,
              isTextButton: true,
              textButtonTitle: 'Checkout',
              buttonWidget: null,
              textButtonOnTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
