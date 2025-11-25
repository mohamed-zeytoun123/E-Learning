// ignore_for_file: unnecessary_this

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension NumEx on num {
  Widget get sizedH => SizedBox(
        height: this.h,
      );
  Widget get sizedW => SizedBox(
        width: this.w,
      );
}
