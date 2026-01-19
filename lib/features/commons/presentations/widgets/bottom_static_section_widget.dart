import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/app/app_colors.dart';
import 'package:flutter_ecommerce/app/app_units.dart';
import 'package:flutter_ecommerce/features/products/state_management/product_provider.dart';
import 'package:provider/provider.dart';

class BottomStaticSectionWidget extends StatelessWidget {
  const BottomStaticSectionWidget({
    super.key,
    required this.title,
    required this.amount,
    required this.isTextButton,
    required this.textButtonTitle,
    required this.buttonWidget,
    required this.textButtonOnTap,
  });
  final String title;
  final bool isTextButton;
  final int amount;
  final String textButtonTitle;
  final Widget? buttonWidget;
  final VoidCallback textButtonOnTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.themeColor.withAlpha(AppUnits.themeColorOpacity),
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
                Text(title),
                Text(
                  '\$$amount',
                  style: TextTheme.of(
                    context,
                  ).titleLarge!.copyWith(color: AppColors.themeColor),
                ),
              ],
            ),
            Consumer<ProductProvider>(
              builder: (context, value, child) => Visibility(
                visible: !value.getIsAddCartProcesing,
                replacement: CircularProgressIndicator(),
                child: SizedBox(
                  height: 40,
                  width: 150,
                  child: isTextButton
                      ? FilledButton(
                          onPressed: textButtonOnTap,
                          child: Text(textButtonTitle),
                        )
                      : buttonWidget,
                ),
              ),
            ),
            // FilledButton(onPressed: () {}, child: Text('Checkout')),
          ],
        ),
      ),
    );
  }
}
