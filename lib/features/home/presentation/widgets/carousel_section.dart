// ignore_for_file: must_be_immutable

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oruphones/core/themes/app_colors.dart';
import 'package:oruphones/features/home/business_logic/cubits/CarouselScrollCubit/carouselscroll_cubit.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CarouselSection extends StatelessWidget {
  CarouselSection({super.key});

  List<int> carouselItems = List.generate(5, (index) => index + 1);

  int _currentIndex = 0;
  final CarouselSliderController _controller = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CarouselScrollCubit, CarouselScrollState>(
      builder: (context, state) {
        return Stack(
          children: [
            CarouselSlider(
              carouselController: _controller,
              options: CarouselOptions(
                aspectRatio: 16 / 9,
                initialPage: 0,
                viewportFraction: 1,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
                onPageChanged: (index, reason) {
                  _currentIndex = index;
                  context.read<CarouselScrollCubit>().onUpdates();
                },
              ),
              items: carouselItems.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Image.asset(
                      "lib/assets/images/banners/banner$i.png",
                      width: MediaQuery.of(context).size.width - 32,
                      fit: BoxFit.fitWidth,
                    );
                  },
                );
              }).toList(),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: AnimatedSmoothIndicator(
                  activeIndex: _currentIndex,
                  count: carouselItems.length,
                  effect: WormEffect(
                    activeDotColor: LightColors.indicatorGrey,
                    dotHeight: 8,
                    dotWidth: 8,
                    paintStyle: PaintingStyle.stroke,
                    spacing: 6,
                  ),
                  onDotClicked: (index) {
                    _controller.animateToPage(index);
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
