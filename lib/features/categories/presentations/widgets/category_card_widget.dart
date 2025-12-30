import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/app/app_colors.dart';

class CategoryCardWidget extends StatelessWidget {
  const CategoryCardWidget({super.key, required this.constraints});
  final BoxConstraints constraints;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SizedBox(
            width: constraints.maxWidth / 4,
            height: constraints.maxWidth / 4,
            child: Card(
              elevation: 0,
              color: AppColors.themeColor.withAlpha(40),
              child: Icon(
                Icons.computer,
                size: 50,
                color: AppColors.themeColor,
              ),
            ),
          ),
        ),
        Text(
          'Computer',
          style: TextTheme.of(
            context,
          ).titleMedium!.copyWith(color: AppColors.themeColor),
        ),
      ],
    );
  }
}
