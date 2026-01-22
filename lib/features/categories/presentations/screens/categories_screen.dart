import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/app/app_units.dart';
import 'package:flutter_ecommerce/app/extensions/localization_extension.dart';
import 'package:flutter_ecommerce/app/state_management/theme_provider.dart';
import 'package:flutter_ecommerce/features/categories/data/models/category_model.dart';
import 'package:flutter_ecommerce/features/categories/presentations/widgets/category_card_widget.dart';
import 'package:flutter_ecommerce/features/categories/state_management/category_provider.dart';
import 'package:flutter_ecommerce/features/commons/presentations/widgets/full_page_circuar_loading_widget.dart';
import 'package:flutter_ecommerce/features/commons/state_management/main_nav_bar_provider.dart';
import 'package:flutter_ecommerce/features/products/presentations/screens/product_list_by_category.dart';
import 'package:provider/provider.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});
  static String name = '/categories_screen';

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List<CategoryModel> _categoryList = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    final provider = context.read<CategoryProvider>();
    _categoryList = provider.getCategories;
    // Defer provider access until after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.addListener(() async {
          if (_scrollController.position.extentAfter < 300) {
            if (!provider.getIsLoadingMore) {
              final temp = provider.fetchMore();
              _categoryList.addAll(await temp);
            }
          }
        });
      }
    });
  }

  // @override
  // void dispose() {
  //   _scrollController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        context.read<MainNavBarProvider>().changeIndex(0);
      },
      canPop: false,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: context.read<ThemeProvider>().isDark! == false
                ? Colors.white
                : null,
            elevation: 1,
            shadowColor: Colors.grey,
            surfaceTintColor: Colors.transparent,
            leading: IconButton(
              onPressed: () {
                context.read<MainNavBarProvider>().changeIndex(0);
              },
              icon: Icon(Icons.chevron_left_rounded, size: 40),
            ),
            title: Text(context.localization.allCat),
          ),
          body: Consumer<CategoryProvider>(
            builder: (context, categoryProvider, child) => Visibility(
              visible: !categoryProvider.getIsFirstLoadin,
              replacement: FullPageCircuarLoadingWidget(),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: AppUnits.horizontalMainPadding,
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: LayoutBuilder(
                        builder: (context, constraints) => CustomScrollView(
                          controller: _scrollController,
                          slivers: [
                            SliverGrid(
                              delegate: SliverChildBuilderDelegate(
                                (context, index) => GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      ProductListByCategory.name,
                                      arguments: {
                                        'id': categoryProvider
                                            .getCategories[index]
                                            .id,
                                        'title': categoryProvider
                                            .getCategories[index]
                                            .title,
                                      },
                                    );
                                  },
                                  child: CategoryCardWidget(
                                    constraints: constraints,
                                    model: _categoryList[index],
                                  ),
                                ),
                                childCount: _categoryList.length,
                              ),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 8,
                                  ),
                            ),
                            if (!categoryProvider.getIsLoadingMore &&
                                categoryProvider.getCurrentPage ==
                                    categoryProvider.getLastPage)
                              SliverToBoxAdapter(
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                    ),
                                    child: Text(
                                      context.localization.no_more,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),

                    if (categoryProvider.getIsLoadingMore)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Center(child: CircularProgressIndicator()),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
