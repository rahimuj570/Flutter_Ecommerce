import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/app/app_units.dart';
import 'package:flutter_rating/flutter_rating.dart';

class ReviewCardWidget extends StatelessWidget {
  final String firstName;
  final String lastName;
  final int rating;
  final String comment;
  final String? avatarUrl;
  const ReviewCardWidget({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.comment,
    required this.rating,
    required this.avatarUrl,
  });

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
                avatarUrl == null
                    ? Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.shade100,
                        ),
                        child: const Icon(Icons.person_outline),
                      )
                    : SizedBox(
                        width: 24,
                        height: 24,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Image.network(avatarUrl!, fit: BoxFit.cover),
                        ),
                      ),
                Text('$firstName $lastName'),
                StarRating(
                  size: 14,
                  rating: rating.toDouble(),
                  allowHalfRating: false,
                ),
              ],
            ),
            Text(comment),
          ],
        ),
      ),
    );
  }
}
