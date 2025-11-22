// import 'dart:io';
// import 'package:e_learning/core/router/route_names.dart';
// import 'package:e_learning/core/widgets/loading/app_loading.dart';
// import 'package:e_learning/features/chapter/data/models/video_model/download_item.dart';
// import 'package:e_learning/features/chapter/presentation/manager/chapter_cubit.dart';
// import 'package:e_learning/features/chapter/presentation/manager/chapter_state.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:go_router/go_router.dart';

// class CachedVideosScreen extends StatelessWidget {
//   const CachedVideosScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Cached Videos"),
//         backgroundColor: Colors.blueAccent,
//       ),
//       body: FutureBuilder<List<DownloadItem>>(
//         future: context.read<ChapterCubit>().getCachedDownloads(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState != ConnectionState.done) {
//             return Center(child: AppLoading.circular());
//           }
//           final cachedVideos = snapshot.data ?? [];
//           if (cachedVideos.isEmpty) {
//             return const Center(child: Text("No cached videos available"));
//           }
//           return ListView.separated(
//             padding: EdgeInsets.all(12.w),
//             itemCount: cachedVideos.length,
//             separatorBuilder: (_, __) => SizedBox(height: 10.h),
//             itemBuilder: (context, index) {
//               final download = cachedVideos[index];
//               final fileName = download.fileName;
//               return ListTile(
//                 contentPadding: EdgeInsets.symmetric(
//                   horizontal: 12.w,
//                   vertical: 8.h,
//                 ),
//                 tileColor: Colors.grey.shade200,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12.r),
//                 ),
//                 leading: const Icon(
//                   Icons.play_circle_fill,
//                   color: Colors.blueAccent,
//                   size: 36,
//                 ),
//                 title: Text(
//                   fileName,
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 subtitle: Text(
//                   "Video ID: ${download.videoId}",
//                   style: TextStyle(fontSize: 12.sp),
//                 ),
//                 trailing: const Icon(Icons.arrow_forward_ios, size: 18),
//                 onTap: () async {
//                   final cubit = context.read<ChapterCubit>();
//                   try {
//                     final videoFile = await cubit.decryptVideoFromCache(
//                       download.videoId,
//                       download.fileName,
//                     );
//                     if (videoFile == null) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(content: Text("Video file not found")),
//                       );
//                       return;
//                     }
//                     context.push(
//                       RouteNames.viedioPage,
//                       extra: {
//                         "chapterCubit": cubit,
//                         "videoModel": null,
//                         "videoFile": videoFile,
//                       },
//                     );
//                   } catch (e) {
//                     debugPrint("Failed to decrypt video: $e");
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(
//                         content: Text("Video file not found or corrupted"),
//                       ),
//                     );
//                   }
//                 },
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

// // import 'dart:io';

// // import 'package:e_learning/core/router/route_names.dart';
// // import 'package:e_learning/features/chapter/presentation/manager/chapter_cubit.dart';
// // import 'package:e_learning/features/chapter/presentation/manager/chapter_state.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:flutter_screenutil/flutter_screenutil.dart';
// // import 'package:go_router/go_router.dart';

// // class CachedVideosScreen extends StatelessWidget {
// //   const CachedVideosScreen({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text("Cached Videos"),
// //         backgroundColor: Colors.blueAccent,
// //       ),
// //       body: BlocBuilder<ChapterCubit, ChapterState>(
// //         builder: (context, state) {
// //           // 1️⃣ جلب قائمة الفيديوهات المكتملة / المخزنة بالكاش
// //           final cachedVideos = state.downloads
// //               .where((d) => d.isCompleted) // بس الفيديوهات المكتملة
// //               .toList();

// //           if (cachedVideos.isEmpty) {
// //             return const Center(child: Text("No cached videos available"));
// //           }

// //           return ListView.separated(
// //             padding: EdgeInsets.all(12.w),
// //             itemCount: cachedVideos.length,
// //             separatorBuilder: (_, __) => SizedBox(height: 10.h),
// //             itemBuilder: (context, index) {
// //               final download = cachedVideos[index];
// //               final fileName = download.fileName;

// //               return ListTile(
// //                 contentPadding: EdgeInsets.symmetric(
// //                   horizontal: 12.w,
// //                   vertical: 8.h,
// //                 ),
// //                 tileColor: Colors.grey.shade200,
// //                 shape: RoundedRectangleBorder(
// //                   borderRadius: BorderRadius.circular(12.r),
// //                 ),
// //                 leading: const Icon(
// //                   Icons.play_circle_fill,
// //                   color: Colors.blueAccent,
// //                   size: 36,
// //                 ),
// //                 title: Text(
// //                   fileName,
// //                   maxLines: 1,
// //                   overflow: TextOverflow.ellipsis,
// //                 ),
// //                 subtitle: Text(
// //                   "Video ID: ${download.videoId}",
// //                   style: TextStyle(fontSize: 12.sp),
// //                 ),
// //                 trailing: const Icon(Icons.arrow_forward_ios, size: 18),
// //                 onTap: () async {
// //                   final cubit = context.read<ChapterCubit>();
// //                   try {
// //                     final videoFile = await cubit.decryptVideoFromCache(
// //                       download.videoId,
// //                       download.fileName,
// //                     );

// //                     // إذا نجح، ننتقل
// //                     context.push(
// //                       RouteNames.viedioPage,
// //                       extra: {
// //                         "chapterCubit": cubit,
// //                         "videoModel": null,
// //                         "videoFile": videoFile,
// //                       },
// //                     );
// //                   } catch (e) {
// //                     debugPrint("Failed to decrypt video: $e");
// //                     ScaffoldMessenger.of(context).showSnackBar(
// //                       const SnackBar(content: Text("Video file not found")),
// //                     );
// //                   }
// //                 },
// //               );
// //             },
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }
