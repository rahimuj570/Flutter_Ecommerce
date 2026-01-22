import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/app/app_units.dart';

class ReviewCardWidget extends StatelessWidget {
  const ReviewCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsetsGeometry.all(AppUnits.horizontalMainPadding),
        child: Column(
          spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              spacing: 14,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.shade100,
                  ),
                  child: const Icon(Icons.person_outline),
                ),
                const Text("Mr. T"),
              ],
            ),
            Text('ss s  s ss'),
          ],
        ),
      ),
    );
  }
}
