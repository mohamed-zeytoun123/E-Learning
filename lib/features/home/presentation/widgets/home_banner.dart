import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/model/enums/app_enums.dart';
import 'package:e_learning/core/theme/app_colors.dart';
// TODO: Advertisement feature not implemented yet
// import 'package:e_learning/features/Course/presentation/manager/advertisment_cubit/advertisment_cubit.dart';
// import 'package:e_learning/features/Course/presentation/manager/advertisment_cubit/advertisment_state.dart';
import 'package:e_learning/features/home/presentation/widgets/steps_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
    // TODO: Advertisement feature not implemented yet
    return const SizedBox.shrink();
    /* 
    return BlocBuilder<AdvertisementCubit, AdvertisementState>(
      builder: (context, state) {
        if (state.status == ResponseStatusEnum.loading) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Container(
              height: 140.h,
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }

        final advertisements = state.advertisements;
        if (state.status == ResponseStatusEnum.failure || 
            advertisements == null || 
            advertisements.isEmpty) {
          return const SizedBox.shrink();
        }

        final banners = advertisements
            .where((ad) => ad.isCurrentlyActive)
            .toList();

        if (banners.isEmpty) {
          return const SizedBox.shrink();
        }

        return Column(
          children: [
            CarouselSlider(
              items: banners.map((advertisement) {
                return Builder(builder: (context) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.r),
                      child: CachedNetworkImage(
                        imageUrl: advertisement.imageUrl,
                        height: 140.h,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          height: 140.h,
                          color: AppColors.background,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          height: 140.h,
                          decoration: BoxDecoration(
                            color: AppColors.background,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: const Icon(Icons.error),
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
                autoPlay: banners.length > 1,
                autoPlayInterval: const Duration(seconds: 3),
                enlargeCenterPage: true,
                onPageChanged: (index, reason) {
                  setState(() => activeIndex = index);
                },
              ),
            ),
            20.sizedH,
            StepsDotsIndecator(
              stepsCount: banners.length,
              selectedIndex: activeIndex,
            ),
          ],
        );
      },
    ); 
    */
  }
}
