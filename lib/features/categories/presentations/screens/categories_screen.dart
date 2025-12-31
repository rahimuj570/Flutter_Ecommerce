import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/app/app_units.dart';
import 'package:flutter_ecommerce/features/categories/data/models/category_model.dart';
import 'package:flutter_ecommerce/features/categories/presentations/widgets/category_card_widget.dart';
import 'package:flutter_ecommerce/features/categories/state_management/category_provider.dart';
import 'package:flutter_ecommerce/features/commons/presentations/widgets/full_page_circuar_loading_widget.dart';
import 'package:flutter_ecommerce/features/commons/state_management/main_nav_bar_provider.dart';
import 'package:provider/provider.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});
  static String name = '/categories_screen';

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

List<CategoryModel> _categoryList = [];

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _categoryList = context.read<CategoryProvider>().getCategories;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (context.read<CategoryProvider>().getCategories.isEmpty) {
        context.read<CategoryProvider>().fetchFirstTime(
          currentPage: 1,
          categoryCount: 30,
        );
      }
    });
  }

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
            backgroundColor: Colors.white,
            elevation: 1,
            shadowColor: Colors.grey,
            surfaceTintColor: Colors.transparent,
            leading: IconButton(
              onPressed: () {
                context.read<MainNavBarProvider>().changeIndex(0);
              },
              icon: Icon(Icons.chevron_left_rounded, size: 40),
            ),
            title: Text('Categories'),
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
                child: LayoutBuilder(
                  builder: (context, constraints) => GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 8,
                    ),

                    itemCount: _categoryList.length,
                    itemBuilder: (context, index) => CategoryCardWidget(
                      constraints: constraints,
                      model: _categoryList[index],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
