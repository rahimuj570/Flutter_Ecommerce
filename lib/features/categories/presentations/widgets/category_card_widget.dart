import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/app/app_colors.dart';
import 'package:flutter_ecommerce/features/categories/data/models/category_model.dart';

class CategoryCardWidget extends StatelessWidget {
  const CategoryCardWidget({super.key, required this.constraints, this.model});
  final BoxConstraints constraints;
  final CategoryModel? model;
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
              child: Center(
                child: Image.network(
                  model!.icon,
                  loadingBuilder: (context, child, loadingProgress) =>
                      loadingProgress != null
                      ? CircularProgressIndicator()
                      : child,
                  width: 40,
                  height: 40,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) =>
                      Icon(Icons.error, size: 40),
                ),
              ),
            ),
          ),
        ),
        Text(
          model?.title ?? 'N/A',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextTheme.of(
            context,
          ).titleMedium!.copyWith(color: AppColors.themeColor),
        ),
      ],
    );
  }
}
