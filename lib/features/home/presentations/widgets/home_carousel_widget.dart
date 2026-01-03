import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/app/app_colors.dart';
import 'package:flutter_ecommerce/app/app_units.dart';
import 'package:flutter_ecommerce/features/home/data/models/slider_model.dart';

class HomeCarouselWidget extends StatefulWidget {
  const HomeCarouselWidget({super.key, required this.sliderModels});
  final List<SliderModel> sliderModels;

  @override
  State<HomeCarouselWidget> createState() => _HomeCarouselWidgetState();
}

class _HomeCarouselWidgetState extends State<HomeCarouselWidget> {
  final ValueNotifier _valueNotifierIndex = ValueNotifier(0);
  final CarouselSliderController _carouselSliderController =
      CarouselSliderController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ValueListenableBuilder(
          valueListenable: _valueNotifierIndex,
          builder: (context, value, child) {
            return CarouselSlider(
              carouselController: _carouselSliderController,
              options: CarouselOptions(
                initialPage: _valueNotifierIndex.value,
                viewportFraction: 1,
                aspectRatio: 16 / 9,
                onPageChanged: (index, reason) {
                  _valueNotifierIndex.value = index;
                },
              ),
              items: widget.sliderModels.map((slider) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        color: AppColors.themeColor,
                        borderRadius: BorderRadius.circular(AppUnits.round),
                      ),
                      child: Image.network(
                        fit: BoxFit.cover,
                        slider.photoUrl,
                        loadingBuilder: (context, child, loadingProgress) =>
                            loadingProgress == null
                            ? child
                            : Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    );
                  },
                );
              }).toList(),
            );
          },
        ),
        SizedBox(height: 8),
        ValueListenableBuilder(
          valueListenable: _valueNotifierIndex,
          builder: (context, value, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 6,
              children: [
                for (int i = 0; i < 4; i++)
                  GestureDetector(
                    onTap: () {
                      _carouselSliderController.animateToPage(i);
                    },
                    child: Container(
                      height: 14,
                      width: 14,
                      decoration: BoxDecoration(
                        color: i == value ? AppColors.themeColor : null,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}
