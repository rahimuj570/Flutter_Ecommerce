import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/app/app_units.dart';
import 'package:flutter_ecommerce/features/categories/data/models/category_model.dart';
import 'package:flutter_ecommerce/features/categories/presentations/widgets/category_card_widget.dart';
import 'package:flutter_ecommerce/features/categories/state_management/category_provider.dart';
import 'package:flutter_ecommerce/features/commons/presentations/widgets/appbar_widgets.dart';
import 'package:flutter_ecommerce/features/commons/presentations/widgets/product_card.dart';
import 'package:flutter_ecommerce/features/commons/state_management/main_nav_bar_provider.dart';
import 'package:flutter_ecommerce/features/home/presentations/widgets/home_carousel_widget.dart';
import 'package:flutter_ecommerce/features/home/presentations/widgets/section_separator_head.dart';
import 'package:flutter_ecommerce/features/products/presentations/screens/product_details_screen.dart';
import 'package:flutter_ecommerce/features/products/presentations/screens/product_list_by_category.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      CategoryProvider categoryProvider = context.read<CategoryProvider>();
      if (categoryProvider.getCategories.isEmpty) {
        categoryProvider.fetchFirstTime(currentPage: 1, categoryCount: 30);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppbarWidgets(),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppUnits.horizontalMainPadding,
          ),
          child: SingleChildScrollView(
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
                SizedBox(height: AppUnits.headlineSeparateHeight),
                SectionSeparatorHead(
                  title: 'All Categories',
                  onTapSeeAll: () {
                    context.read<MainNavBarProvider>().changeIndex(1);
                  },
                ),
                Consumer<CategoryProvider>(
                  builder: (context, catProvider, child) {
                    List<CategoryModel> _firstThreeCat = [];
                    if (catProvider.getCategories.isNotEmpty) {
                      _firstThreeCat = catProvider.getCategories.sublist(0, 4);
                    }
                    return Visibility(
                      visible: !catProvider.getIsFirstLoadin,
                      replacement: CircularProgressIndicator(),
                      child: SizedBox(
                        height: 100,
                        child: LayoutBuilder(
                          builder: (context2, constraints) {
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,

                              itemCount: _firstThreeCat.length,
                              itemBuilder: (context2, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      ProductListByCategory.name,
                                      arguments: 'Fashion',
                                    );
                                  },
                                  child: CategoryCardWidget(
                                    model: _firstThreeCat[index],
                                    constraints: constraints,
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: AppUnits.headlineSeparateHeight),
                SectionSeparatorHead(title: 'Popular', onTapSeeAll: () {}),
                SizedBox(
                  height: 200,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final itemSize =
                          (constraints.maxWidth / 3); // square side length
                      return ListView.builder(
                        itemCount: 3,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              ProductDetailsScreen.name,
                            );
                          },
                          child: ProductCard(itemSize: itemSize),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: AppUnits.headlineSeparateHeight),
                SectionSeparatorHead(title: 'Special', onTapSeeAll: () {}),
                SizedBox(
                  height: 200,
                  child: LayoutBuilder(
                    builder: (context, constraints) => ListView.builder(
                      itemCount: 3,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) =>
                          ProductCard(itemSize: constraints.maxWidth / 3),
                    ),
                  ),
                ),
                SizedBox(height: AppUnits.headlineSeparateHeight),
                SectionSeparatorHead(title: 'New', onTapSeeAll: () {}),
                SizedBox(
                  height: 200,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return ListView.builder(
                        itemCount: 3,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) =>
                            ProductCard(itemSize: constraints.maxWidth / 3),
                      );
                    },
                  ),
                ),
                SizedBox(height: AppUnits.headlineSeparateHeight),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
