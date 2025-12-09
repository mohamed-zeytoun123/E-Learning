// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:e_learning/core/colors/app_colors.dart';

// class RatingStarsWidget extends StatefulWidget {
//   final double initialRating;
//   final ValueChanged<double> onRatingSelected;

//   const RatingStarsWidget({
//     super.key,
//     this.initialRating = 0.0,
//     required this.onRatingSelected,
//   });

//   @override
//   State<RatingStarsWidget> createState() => _RatingStarsWidgetState();
// }

// class _RatingStarsWidgetState extends State<RatingStarsWidget> {
//   late double _currentRating;

//   @override
//   void initState() {
//     super.initState();
//     _currentRating = widget.initialRating;
//   }

//   void _updateRating(double newRating) {
//     setState(() {
//       _currentRating = newRating;
//     });
//     widget.onRatingSelected(newRating);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: List.generate(5, (index) {
//         final starIndex = index + 1;
//         return GestureDetector(
//           onTap: () => _updateRating(starIndex.toDouble()),
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 5.w),
//             child: Icon(
//               _currentRating >= starIndex
//                   ? Icons.star_rounded
//                   : Icons.star_border_rounded,
//               color: _currentRating >= starIndex
//                   ? AppColors.iconStars
//                   : AppColors.iconGrey,
//               size: 25.sp,
//             ),
//           ),
//         );
//       }),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_learning/core/colors/app_colors.dart';

class RatingStarsWidget extends StatefulWidget {
  final int initialRating;
  final ValueChanged<int> onRatingSelected;

  const RatingStarsWidget({
    super.key,
    this.initialRating = 0,
    required this.onRatingSelected,
  });

  @override
  State<RatingStarsWidget> createState() => _RatingStarsWidgetState();
}

class _RatingStarsWidgetState extends State<RatingStarsWidget> {
  late int _currentRating;

  @override
  void initState() {
    super.initState();
    _currentRating = widget.initialRating;
  }

  void _updateRating(int newRating) {
    setState(() {
      _currentRating = newRating;
    });
    widget.onRatingSelected(newRating);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        final starIndex = index + 1;
        return GestureDetector(
          onTap: () => _updateRating(starIndex),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Icon(
              _currentRating >= starIndex
                  ? Icons.star_rounded
                  : Icons.star_border_rounded,
              color: _currentRating >= starIndex
                  ? AppColors.iconStars
                  : AppColors.iconGrey,
              size: 25.sp,
            ),
          ),
        );
      }),
    );
  }
}
