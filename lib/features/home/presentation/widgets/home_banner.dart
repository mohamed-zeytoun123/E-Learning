import 'package:e_learning/core/utils/state_forms/response_status_enum.dart';
import 'package:e_learning/core/widgets/cached_image/custom_cached_image_widget.dart';
import 'package:e_learning/core/widgets/loading/app_loading.dart';
import 'package:e_learning/features/Banner/presentation/manager/banner_cubit.dart';
import 'package:e_learning/features/Banner/presentation/manager/banner_state.dart';
import 'package:e_learning/features/home/presentation/widgets/steps_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BannerCubit, BannerState>(
      builder: (context, state) {
        if (state.bannersStatus == ResponseStatusEnum.loading) {
          return SizedBox(
            height: 180.h,
            child: Center(child: AppLoading.circular()),
          );
        }

        if (state.bannersStatus == ResponseStatusEnum.failure) {
          return const SizedBox.shrink();
        }

        final banners = state.banners ?? [];
        final activeBanners =
            banners.where((b) => b.isCurrentlyActive).toList();

        if (activeBanners.isEmpty) {
          return const SizedBox.shrink();
        }

        return Column(
          children: [
            CarouselSlider(
              items: activeBanners.map((banner) {
                return Builder(builder: (context) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(20.r),
                    child: CustomCachedImageWidget(
                      appImage: banner.imageUrl,
                      height: 140.h,
                      width: 360.w,
                      fit: BoxFit.cover,
                      placeholder: Container(
                        height: 140.h,
                        color: Colors.grey.shade300,
                        child: Center(child: AppLoading.circular()),
                      ),
                      errorWidget: Container(
                        height: 140.h,
                        color: Colors.grey.shade300,
                        child: const Icon(Icons.error_outline),
                      ),
                    ),
                  );
                });
              }).toList(),
              carouselController: _controller,
              options: CarouselOptions(
                height: 180.h,
                viewportFraction: 1.0,
                autoPlay: activeBanners.length > 1,
                autoPlayInterval: const Duration(seconds: 3),
                enlargeCenterPage: false,
                onPageChanged: (index, reason) {
                  setState(() => activeIndex = index);
                },
              ),
            ),
            SizedBox(height: 20.h),
            StepsDotsIndecator(
              stepsCount: activeBanners.length,
              selectedIndex: activeIndex,
            ),
          ],
        );
      },
    );
  }
}
