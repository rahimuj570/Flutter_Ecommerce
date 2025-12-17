import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/app/app_units.dart';
import 'package:flutter_ecommerce/features/categories/presentations/widgets/category_card_widget.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});
  static String name = '/categories_screen';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          shadowColor: Colors.grey,
          surfaceTintColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.chevron_left_rounded, size: 40),
          ),
          title: Text('Categories'),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 20,
            horizontal: AppUnits.horizontalMainPadding,
          ),
          child: LayoutBuilder(
            builder: (context, constraints) => GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 10,
                crossAxisSpacing: 5,
              ),

              itemCount: 10,
              itemBuilder: (context, index) =>
                  CategoryCardWidget(constraints: constraints),
            ),
          ),
        ),
      ),
    );
  }
}
