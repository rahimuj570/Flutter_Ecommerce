import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/app/app_units.dart';
import 'package:flutter_ecommerce/features/commons/presentations/widgets/appbar_widgets.dart';
import 'package:flutter_ecommerce/features/home/presentations/widgets/home_carousel_widget.dart';

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
            ],
          ),
        ),
      ),
    );
  }
}
