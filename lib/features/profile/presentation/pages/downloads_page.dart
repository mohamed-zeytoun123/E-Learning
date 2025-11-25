import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/router/route_names.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/widgets/app_bar/custom_app_bar_widget.dart';
import 'package:e_learning/core/widgets/buttons/custom_button_widget.dart';
import 'package:e_learning/core/widgets/loading/app_loading.dart';
import 'package:e_learning/core/widgets/message/app_message.dart';
import 'package:e_learning/features/chapter/data/models/video_models/download_item.dart';
import 'package:e_learning/features/chapter/presentation/manager/chapter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class DownloadsPage extends StatefulWidget {
  const DownloadsPage({super.key});

  @override
  State<DownloadsPage> createState() => _DownloadsPageState();
}

class _DownloadsPageState extends State<DownloadsPage> {
  late Future<List<DownloadItem>> _downloadsFuture;
  late ChapterCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<ChapterCubit>();
    _loadDownloads();
  }

  void _loadDownloads() {
    _downloadsFuture = cubit.getCachedDownloads();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: Scaffold(
        appBar: CustomAppBarWidget(title: 'Downloads', showBack: true),
        body: FutureBuilder<List<DownloadItem>>(
          future: _downloadsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return Center(child: AppLoading.circular());
            }

            if (snapshot.hasError) {
              AppMessage.showFlushbar(
                context: context,
                title: "Error",
                message: "Failed to load cached videos",
                backgroundColor: AppColors.messageError,
                iconData: Icons.error,
                iconColor: AppColors.iconWhite,
                isShowProgress: true,
              );
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
                      color: AppColors.iconGrey.withOpacity(0.5),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      "No downloaded videos yet",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textGrey,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      "Download videos from chapters to view them offline",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.textGrey.withOpacity(0.7),
                      ),
                    ),
                    SizedBox(height: 30.h),
                    CustomButtonWidget(
                      title: "Back to Learning",
                      titleStyle: AppTextStyles.s14w600.copyWith(
                        color: AppColors.titlePrimary,
                      ),
                      buttonColor: AppColors.buttonPrimary,
                      borderColor: AppColors.buttonPrimary,
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
                  SizedBox(height: 16.h),
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
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.delete,
                                    color: AppColors.iconRed,
                                    size: 20.sp,
                                  ),
                                  onPressed: () async {
                                    final shouldDelete = await showDialog<bool>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text('Confirm Delete'),
                                          content: Text(
                                            'Are you sure you want to delete "${download.fileName}"?',
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () => Navigator.of(
                                                context,
                                              ).pop(false),
                                              child: const Text('Cancel'),
                                            ),
                                            TextButton(
                                              onPressed: () => Navigator.of(
                                                context,
                                              ).pop(true),
                                              child: const Text(
                                                'Delete',
                                                style: TextStyle(
                                                  color: AppColors.iconRed,
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );

                                    if (shouldDelete == true) {
                                      try {
                                        await cubit.deleteCachedVideo(
                                          download.videoId,
                                        );
                                        AppMessage.showFlushbar(
                                          context: context,
                                          title: "Success",
                                          message: "Video deleted successfully",
                                          backgroundColor:
                                              AppColors.messageSuccess,
                                          iconData: Icons.check_circle,
                                          iconColor: AppColors.iconWhite,
                                          isShowProgress: true,
                                        );

                                        setState(() {
                                          _loadDownloads();
                                        });
                                      } catch (e) {
                                        AppMessage.showFlushbar(
                                          context: context,
                                          title: "Error",
                                          message: "Failed to delete video",
                                          backgroundColor:
                                              AppColors.messageError,
                                          iconData: Icons.error,
                                          iconColor: AppColors.iconWhite,
                                          isShowProgress: true,
                                        );
                                      }
                                    }
                                  },
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 16.sp,
                                  color: AppColors.iconGrey,
                                ),
                              ],
                            ),
                            onTap: () async {
                              try {
                                final videoFile = await cubit
                                    .decryptVideoFromCache(
                                      download.videoId,
                                      download.fileName,
                                    );
                                if (videoFile == null) {
                                  AppMessage.showFlushbar(
                                    context: context,
                                    title: "Error",
                                    message: "Video file not found",
                                    backgroundColor: AppColors.messageError,
                                    iconData: Icons.error,
                                    iconColor: AppColors.iconWhite,
                                    isShowProgress: true,
                                  );
                                  return;
                                }
                                context.push(
                                  RouteNames.viedioPage,
                                  extra: {
                                    "chapterCubit": cubit,
                                    "videoModel": null,
                                    "videoFile": videoFile,
                                    "videoId": null,
                                  },
                                );
                              } catch (e) {
                                debugPrint("Failed to decrypt video: $e");
                                AppMessage.showFlushbar(
                                  context: context,
                                  title: "Error",
                                  message: "Video file not found or corrupted",
                                  backgroundColor: AppColors.messageError,
                                  iconData: Icons.error,
                                  iconColor: AppColors.iconWhite,
                                  isShowProgress: true,
                                );
                              }
                            },
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          SizedBox(height: 12.h),
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
