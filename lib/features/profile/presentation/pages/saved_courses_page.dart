import 'dart:developer';
import 'package:e_learning/core/initial/app_init_dependencies.dart';
import 'package:e_learning/core/router/route_names.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/core/themes/theme_extensions.dart';
import 'package:e_learning/core/widgets/app_bar/custom_app_bar_widget.dart';
import 'package:e_learning/features/Course/data/source/repo/courcese_repository.dart';
import 'package:e_learning/features/Course/presentation/manager/course_cubit.dart';
import 'package:e_learning/features/Course/presentation/widgets/course_info_card_widget.dart';
import 'package:e_learning/features/profile/data/source/repo/profile_repository.dart';
import 'package:e_learning/features/profile/presentation/manager/profile_cubit.dart';
import 'package:e_learning/features/profile/presentation/manager/profile_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SavedCoursesPage extends StatefulWidget {
  const SavedCoursesPage({super.key});

  @override
  State<SavedCoursesPage> createState() => _SavedCoursesPageState();
}

class _SavedCoursesPageState extends State<SavedCoursesPage> {
  final ScrollController _scrollController = ScrollController();
  late final ProfileCubit profileCubit;
  // bool isLoadingMore = false;
  bool isRefreshing = false;
  @override
  void initState() {
    super.initState();
    profileCubit = ProfileCubit(appLocator<ProfileRepository>());
    profileCubit.getDataSavedCourse();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    // print(isLoadingMore);
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent &&
        !profileCubit.state.isLoadingMore!) {
      // profileCubit.counterPage();
      _loadMore();
      // log('icrease pagination');
    }
  }

  // void _loadMore() async {
  //   setState(() => isLoadingMore = true);
  //   await profileCubit.getDataSavedCourse();
  //   await Future.delayed(Duration(minutes: 1));
  //   //
  //   // log('✅ Loaded more');
  //   setState(() => isLoadingMore = false);
  // }
  Future<void> _loadMore() async {
    // 🔒 تحقق أولاً أن التحميل مش شغال داخل الكيوبت
    // if (profileCubit.state.isLoadingMore!) {
    //   log('⏳ تجاهل الطلب — التحميل جاري بالفعل.');
    //   return;
    // }

    // ✅ نبلغ الكيوبت أنه بدأ التحميل
    // profileCubit.emit(
    //   profileCubit.state.copyWith(isLoadingMore: true),
    // );

    // 📨 نرسل الطلب لجلب المزيد من الدورات
    await profileCubit.getDataSavedCourse();

    // ⏱️ (اختياري) تأخير بسيط لتوضيح التحميل
    // await Future.delayed(const Duration(seconds: 1));

    // // ✅ نبلغ الكيوبت أنه انتهى التحميل
    // profileCubit.emit(
    //   profileCubit.state.copyWith(isLoadingMore: false),
    // );

    // log('✅ تم تحميل المزيد من الدورات');
  }

  String formatNumberString(String value) {
    // نحاول نحول النص إلى double بأمان
    final number = double.tryParse(value);
    if (number == null) return value; // إذا ما قدر يحوله، نرجّع النص كما هو

    // إذا الرقم بدون كسور (مثلاً 500.00 أو 12.0)
    if (number.truncateToDouble() == number) {
      return number.toInt().toString(); // ✅ ترجع "500"
    } else {
      // نحذف الأصفار الزائدة فقط (مثلاً 12.50 → 12.5)
      return number.toString().replaceAll(RegExp(r'([.]*0+)(?!.*\d)'), '');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProfileCubit>(
          create: (context) => profileCubit,
        ),
        BlocProvider<CourseCubit>(
          create: (context) =>
              CourseCubit(repo: appLocator<CourceseRepository>()),
        ),
      ],
      child: Scaffold(
        appBar: CustomAppBarWidget(title: 'saved_courses'.tr(), showBack: true),
        body: Padding(
          padding:
              EdgeInsetsGeometry.symmetric(horizontal: 16.w, vertical: 32.h),
          child: BlocBuilder<ProfileCubit, ProfileState>(
            bloc: profileCubit,
            buildWhen: (previous, current) =>
                previous.dataSavedcourses != current.dataSavedcourses,
            builder: (context, state) {
              if (state.isLoadingdataSavedcourses == true) {
                return Center(child: CircularProgressIndicator());
              }
              if (state.errorFetchdataSavedcourses != null) {
                return SizedBox(
                  height: 500.h,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.wifi_tethering_error,
                          size: 64.sp,
                          color: context.colors.iconRed,
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          'Error loading saved courses',
                          style: AppTextStyles.s16w500.copyWith(
                            color: context.colors.textPrimary,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          state.errorFetchdataSavedcourses!.message,
                          style: AppTextStyles.s14w400.copyWith(
                            color: context.colors.textPrimary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              }

              return ListView.separated(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                itemCount: state.dataSavedcourses.data.length,
                itemBuilder: (context, index) {
                  var item = state.dataSavedcourses.data[index];
                  // log('😒 ${state.dataSavedcourses}------------------');
                  return CourseInfoCardWidget(
                    onTap: () {
                      // context.push(RouteNames.courceInf);
                      final cubit = BlocProvider.of<CourseCubit>(context);
                      context.pushNamed(
                        RouteNames.courceInf,
                        extra: {
                          "courseSlug": item.id.toString(),
                          "courseCubit": cubit,
                        },
                      );
                    },
                    imageUrl: "https://picsum.photos/361/180",
                    title: item.title,
                    subtitle: '',
                    rating: 4.8,
                    price: formatNumberString(item.price),
                    onSave: () {
                      log("Course saved!");
                    },
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 22.h);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
