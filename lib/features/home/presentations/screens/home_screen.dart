import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_ecommerce/app/app_colors.dart';
import 'package:flutter_ecommerce/app/app_units.dart';
import 'package:flutter_ecommerce/features/categories/presentations/screens/categories_screen.dart';
import 'package:flutter_ecommerce/features/categories/presentations/widgets/category_card_widget.dart';
import 'package:flutter_ecommerce/features/commons/presentations/widgets/appbar_widgets.dart';
import 'package:flutter_ecommerce/features/home/presentations/widgets/home_carousel_widget.dart';
import 'package:flutter_ecommerce/features/home/presentations/widgets/section_separator_head.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppbarWidgets(),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppUnits.horizontalMainPadding,
          ),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: Icon(Icons.search),
                  fillColor: const Color.fromRGBO(238, 238, 238, 1),
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 8,
                  ),

                  prefixIconConstraints: BoxConstraints(
                    minWidth: 40,
                    maxWidth: 40,
                  ),
                  prefixStyle: TextStyle(),
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppUnits.round),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 15),
              HomeCarouselWidget(),
              const SizedBox(height: 14),
              SectionSeparatorHead(
                title: 'All Categories',
                onTapSeeAll: () {
                  Navigator.pushNamed(context, CategoriesScreen.name);
                },
              ),
              SizedBox(
                height: 100,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,

                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return CategoryCardWidget(constraints: constraints);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
