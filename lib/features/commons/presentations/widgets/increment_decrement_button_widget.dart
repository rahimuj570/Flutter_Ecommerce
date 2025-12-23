import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/app/app_colors.dart';

class IncrementDecrementButton extends StatelessWidget {
  const IncrementDecrementButton({
    super.key,
    required this.addOnTap,
    required this.removeOnTap,
  });
  final VoidCallback addOnTap;
  final VoidCallback removeOnTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: addOnTap,
          child: Container(
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: AppColors.themeColor,
            ),
            child: Icon(Icons.add, size: 18, color: Colors.white),
          ),
        ),
        SizedBox(width: 5),
        Text('2'),
        SizedBox(width: 5),

        GestureDetector(
          onTap: removeOnTap,
          child: Container(
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: AppColors.themeColor,
            ),
            child: Icon(Icons.remove, size: 18, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
