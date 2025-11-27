import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/router/route_names.dart';
import 'package:e_learning/core/theme/app_colors.dart';
import 'package:e_learning/core/widgets/custom_app_bar_widget.dart';
import 'package:e_learning/core/widgets/custom_button.dart';
import 'package:e_learning/core/widgets/app_loading.dart';
import 'package:e_learning/core/widgets/app_message.dart';
import 'package:e_learning/features/chapter/data/models/video_models/download_item.dart';
import 'package:e_learning/features/chapter/presentation/manager/chapter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class DownloadsPage extends StatelessWidget {
  const DownloadsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<ChapterCubit>(),
      child: Scaffold(
        appBar: CustomAppBarWidget(title: 'Downloads', showBack: true),
        body: FutureBuilder<List<DownloadItem>>(
          future: context.read<ChapterCubit>().getCachedDownloads(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return Center(child: AppLoading.circular());
            }

            if (snapshot.hasError) {
              AppMessage.showError(context, "Failed to load cached videos");
              return const Center(child: Text("Failed to load cached videos"));
            }

            final cachedVideos = snapshot.data ?? [];
            if (cachedVideos.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.video_library_outlined,
                      size: 80.sp,
                      color: AppColors.iconGrey,
                    ),
                    20.sizedH,
                    Text(
                      "No downloaded videos yet",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textGrey,
                      ),
                    ),
                    10.sizedH,
                    Text(
                      "Download videos from chapters to view them offline",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.textGrey.withOpacity(0.7),
                      ),
                    ),
                    30.sizedH,
                    CustomButton(
                      title: "Back to Learning",
                      buttonColor: AppColors.buttonPrimary,
                      onTap: () => context.pop(),
                    ),
                  ],
                ),
              );
            }

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Downloaded Videos (${cachedVideos.length})",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textBlack,
                    ),
                  ),
                  16.sizedH,
                  Expanded(
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemCount: cachedVideos.length,
                      itemBuilder: (context, index) {
                        final download = cachedVideos[index];
                        final fileName = download.fileName;

                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 8.r,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 12.h,
                            ),
                            leading: Container(
                              width: 50.w,
                              height: 50.h,
                              decoration: BoxDecoration(
                                color: AppColors.buttonPrimary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Icon(
                                Icons.play_circle_fill,
                                color: AppColors.buttonPrimary,
                                size: 30.sp,
                              ),
                            ),
                            title: Text(
                              fileName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textBlack,
                              ),
                            ),
                            subtitle: Text(
                              "Video ID: ${download.videoId}",
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: AppColors.textGrey,
                              ),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              size: 16.sp,
                              color: AppColors.iconGrey,
                            ),
                            onTap: () async {
                              final cubit = context.read<ChapterCubit>();
                              try {
                                final videoFile =
                                    await cubit.decryptVideoFromCache(
                                  download.videoId,
                                  download.fileName,
                                );
                                if (videoFile == null) {
                                  AppMessage.showError(
                                      context, "Video file not found");
                                  return;
                                }
                                context.push(
                                  RouteNames.viedioPage,
                                  extra: {
                                    "chapterCubit": cubit,
                                    "videoModel": null,
                                    "videoFile": videoFile,
                                  },
                                );
                              } catch (e) {
                                debugPrint("Failed to decrypt video: $e");
                                AppMessage.showError(context,
                                    "Video file not found or corrupted");
                              }
                            },
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          12.sizedH,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
