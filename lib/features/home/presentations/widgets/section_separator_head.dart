import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/app/app_colors.dart';

class SectionSeparatorHead extends StatelessWidget {
  const SectionSeparatorHead({
    super.key,
    required this.title,
    required this.onTapSeeAll,
  });
  final String title;
  final VoidCallback onTapSeeAll;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextTheme.of(
            context,
          ).titleLarge!.copyWith(fontWeight: FontWeight.bold),
        ),
        TextButton(
          onPressed: onTapSeeAll,
          child: Text(
            'See All',
            style: TextTheme.of(
              context,
            ).titleMedium!.copyWith(color: AppColors.themeColor),
          ),
        ),
      ],
    );
  }
}
