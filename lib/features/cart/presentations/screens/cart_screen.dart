import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/app/app_assets_path.dart';
import 'package:flutter_ecommerce/app/app_colors.dart';
import 'package:flutter_ecommerce/app/app_units.dart';
import 'package:flutter_ecommerce/features/cart/presentations/widgets/cart_card_widget.dart';
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
        body: Padding(
          padding: EdgeInsets.all(AppUnits.horizontalMainPadding),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) =>
                      index != 9 ? CartCardWidget() : SizedBox(height: 80),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.themeColor.withAlpha(
                    AppUnits.themeColorOpacity,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(AppUnits.round),
                    topRight: Radius.circular(AppUnits.round),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Total Price'),
                          Text(
                            '\$20,000',
                            style: TextTheme.of(
                              context,
                            ).titleLarge!.copyWith(color: AppColors.themeColor),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40,
                        width: 150,
                        child: FilledButton(
                          onPressed: () {},
                          child: Text('Checkout'),
                        ),
                      ),
                      // FilledButton(onPressed: () {}, child: Text('Checkout')),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
