import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/app/app_colors.dart';
import 'package:flutter_ecommerce/features/commons/presentations/widgets/full_page_circuar_loading_widget.dart';

class ProductDetailsCarouselWidget extends StatefulWidget {
  const ProductDetailsCarouselWidget({super.key, required this.images});
  final List<String> images;
  @override
  State<ProductDetailsCarouselWidget> createState() =>
      _ProductDetailsCarouselWidgetState();
}

class _ProductDetailsCarouselWidgetState
    extends State<ProductDetailsCarouselWidget> {
  final ValueNotifier _valueNotifierIndex = ValueNotifier(0);
  final CarouselSliderController _carouselSliderController =
      CarouselSliderController();
  @override
  Widget build(BuildContext context) {
    return Stack(
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
              items: widget.images.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: AppColors.themeColor.withAlpha(12),
                      ),
                      child: widget.images.isEmpty
                          ? Center(child: Text('No Image'))
                          : Image.network(
                              i,
                              fit: BoxFit.cover,
                              loadingBuilder:
                                  (context, child, loadingProgress) =>
                                      loadingProgress == null
                                      ? child
                                      : FullPageCircuarLoadingWidget(),
                            ),
                    );
                  },
                );
              }).toList(),
            );
          },
        ),
        Positioned(
          bottom: 30,
          left: 0,
          right: 0,
          child: ValueListenableBuilder(
            valueListenable: _valueNotifierIndex,
            builder: (context, value, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 6,
                children: [
                  for (int i = 0; i < widget.images.length; i++)
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
        ),
      ],
    );
  }
}
