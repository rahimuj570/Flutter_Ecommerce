import 'package:flutter/material.dart';

class FullPageCircuarLoadingWidget extends StatelessWidget {
  const FullPageCircuarLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 150,
        height: 150,
        child: CircularProgressIndicator(),
      ),
    );
  }
}
