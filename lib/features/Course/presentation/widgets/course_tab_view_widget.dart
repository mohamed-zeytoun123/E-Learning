import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CourseTabViewWidget extends StatelessWidget {
  const CourseTabViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: Colors.black,
            indicatorWeight: 2.h,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.play_circle_fill, size: 20.sp),
                    SizedBox(width: 4.w),
                    Text("Chapter"),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.menu, size: 20.sp),
                    SizedBox(width: 4.w),
                    Text("About"),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.chat_outlined, size: 20.sp),
                    SizedBox(width: 4.w),
                    Text("Reviews"),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 300.h,
            child: TabBarView(
              children: [
                Center(child: Text("Chapter content here")),
                Center(child: Text("About content here")),
                Center(child: Text("Reviews content here")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
