import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/app/app_colors.dart';
import 'package:flutter_ecommerce/app/extensions/localization_extension.dart';
import 'package:flutter_ecommerce/features/products/presentations/screens/product_details_screen.dart';

class SizePickerWidget extends StatefulWidget {
  const SizePickerWidget({super.key, required this.sizeList});
  final List<String> sizeList;

  @override
  State<SizePickerWidget> createState() => _SizePickerWidgetState();
}

class _SizePickerWidgetState extends State<SizePickerWidget> {
  late String seletedSize = widget.sizeList[0];
  @override
  Widget build(BuildContext context) {
    ProductDetailsScreen.selectedSize = seletedSize;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.localization.size,
          style: TextTheme.of(context).titleMedium,
        ),
        SizedBox(height: 5),
        Row(
          children: [
            for (String c in widget.sizeList)
              GestureDetector(
                onTap: () {
                  seletedSize = c;
                  setState(() {});
                },
                child: Container(
                  margin: EdgeInsets.only(right: 10),
                  height: 28,
                  width: 28,
                  decoration: BoxDecoration(
                    color: seletedSize != c
                        ? Colors.white
                        : AppColors.themeColor,

                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black),
                  ),
                  child: Center(
                    child: FittedBox(
                      child: Text(
                        c,
                        style: TextStyle(
                          fontSize: 13,
                          color: seletedSize == c ? Colors.white : null,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
