import 'package:e_learning/features/home/presentation/widgets/steps_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeBannersWidget extends StatefulWidget {
  const HomeBannersWidget({super.key});

  @override
  State<HomeBannersWidget> createState() => _HomeBannersWidgetState();
}

class _HomeBannersWidgetState extends State<HomeBannersWidget> {
  int activeIndex = 0;
  final CarouselSliderController _controller = CarouselSliderController();

  final List<String> banners = ['1', '2', '3', '4'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: banners.map((item) {
            return Builder(builder: (context) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Container(
                  height: 140.h,
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Banner $item',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            });
          }).toList(),
          carouselController: _controller,
          options: CarouselOptions(
            height: 140.h,
            viewportFraction: 0.9,
            autoPlay: true, // ✅ makes it move automatically
            autoPlayInterval: const Duration(seconds: 3),
            enlargeCenterPage: true,
            onPageChanged: (index, reason) {
              setState(() => activeIndex = index);
            },
          ),
        ),
        SizedBox(height: 20.h),
        StepsDotsIndecator(
          stepsCount: banners.length,
          selectedIndex: activeIndex,
        ),
      ],
    );
  }
}
