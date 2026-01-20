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
import 'package:flutter_ecommerce/features/home/state_management/slider_provider.dart';
import 'package:flutter_ecommerce/features/products/data/models/product_card_model.dart';
import 'package:flutter_ecommerce/features/products/presentations/screens/product_details_screen.dart';
import 'package:flutter_ecommerce/features/products/presentations/screens/product_list_by_category.dart';
import 'package:flutter_ecommerce/features/products/state_management/product_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

List<ProductCardModel> popularFirstThreeProduct = [];
List<ProductCardModel> newArrivalFirstThreeProduct = [];
List<ProductCardModel> specialFirstThreeProduct = [];
String popularCategoryId = '67c35af85e8a445235de197b';
String newCategoryId = "67c7bec4623a876bc4766fea";
String specialProductsId = '67c35b395e8a445235de197e';

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final SliderProvider sliderProvider = context.read<SliderProvider>();
      if (sliderProvider.getSliderList.isEmpty) {
        sliderProvider.fetchSlider();
      }

      final ProductProvider productProvider = context.read<ProductProvider>();
      if (productProvider.getPopularProductCardList.isEmpty) {
        productProvider.fethingProductCardListByCategry(
          3,
          1,
          popularCategoryId,
        );
        popularFirstThreeProduct = productProvider.getPopularProductCardList;
      }
      if (productProvider.getSpecialProductCardList.isEmpty) {
        productProvider.fethingProductCardListByCategry(
          3,
          1,
          specialProductsId,
        );
        specialFirstThreeProduct = productProvider.getSpecialProductCardList;
      }

      final CategoryProvider categoryProvider = context
          .read<CategoryProvider>();
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
                Consumer<SliderProvider>(
                  builder: (context, value, child) => Visibility(
                    visible: !value.isSliderFetching,
                    replacement: CircularProgressIndicator(),
                    child: HomeCarouselWidget(
                      sliderModels: value.getSliderList,
                    ),
                  ),
                ),
                SizedBox(height: AppUnits.headlineSeparateHeight),
                SectionSeparatorHead(
                  title: 'All Categories',
                  onTapSeeAll: () {
                    context.read<MainNavBarProvider>().changeIndex(1);
                  },
                ),
                Consumer<CategoryProvider>(
                  builder: (context, catProvider, child) {
                    List<CategoryModel> firstFourCat = [];
                    if (catProvider.getCategories.isNotEmpty) {
                      firstFourCat = catProvider.getCategories.sublist(0, 4);
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

                              itemCount: firstFourCat.length,
                              itemBuilder: (context2, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      ProductListByCategory.name,
                                      arguments: {
                                        'id': firstFourCat[index].id,
                                        'title': firstFourCat[index].title,
                                      },
                                    );
                                  },
                                  child: CategoryCardWidget(
                                    model: firstFourCat[index],
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
                SectionSeparatorHead(
                  title: 'Popular',
                  onTapSeeAll: () {
                    Navigator.pushNamed(
                      context,
                      ProductListByCategory.name,
                      arguments: {'id': popularCategoryId, 'title': 'Popular'},
                    );
                  },
                ),
                Consumer<ProductProvider>(
                  builder: (context, productProvider, child) => SizedBox(
                    height: 200,
                    child: Visibility(
                      visible: popularFirstThreeProduct.isNotEmpty,
                      replacement: Center(child: CircularProgressIndicator()),
                      child: ListView.builder(
                        itemCount: popularFirstThreeProduct.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              ProductDetailsScreen.name,
                              arguments: popularFirstThreeProduct[index].id,
                            );
                          },
                          child: ProductCard(
                            model: ProductCardModel(
                              id: popularFirstThreeProduct[index].id,
                              title: popularFirstThreeProduct[index].title,
                              photos: popularFirstThreeProduct[index].photos,
                              currentPrice:
                                  popularFirstThreeProduct[index].currentPrice,
                              inWishlist:
                                  popularFirstThreeProduct[index].inWishlist,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: AppUnits.headlineSeparateHeight),
                SectionSeparatorHead(
                  title: 'Special',
                  onTapSeeAll: () {
                    Navigator.pushNamed(
                      context,
                      ProductListByCategory.name,
                      arguments: {'id': specialProductsId, 'title': 'Special'},
                    );
                  },
                ),
                Consumer<ProductProvider>(
                  builder: (context, value, child) => SizedBox(
                    height: 200,
                    child: Visibility(
                      visible: specialFirstThreeProduct.isNotEmpty,
                      replacement: Center(child: CircularProgressIndicator()),
                      child: LayoutBuilder(
                        builder: (context, constraints) => ListView.builder(
                          itemCount: specialFirstThreeProduct.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => ProductCard(
                            model: ProductCardModel(
                              id: specialProductsId,
                              title: specialFirstThreeProduct[index].title,
                              photos: specialFirstThreeProduct[index].photos,
                              currentPrice:
                                  specialFirstThreeProduct[index].currentPrice,
                              inWishlist:
                                  specialFirstThreeProduct[index].inWishlist,
                            ),
                          ),
                        ),
                      ),
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
                        itemBuilder: (context, index) => ProductCard(
                          model: ProductCardModel(
                            id: 'id',
                            title: 'title',
                            photos: ['photos'],
                            currentPrice: 1,
                            inWishlist: true,
                          ),
                        ),
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
