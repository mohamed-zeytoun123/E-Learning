import 'package:e_learning/features/Video/presentation/widgets/bottom_sheet_comments_widget.dart';
import 'package:e_learning/features/chapter/presentation/manager/chapter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void openCommentsSheet(BuildContext context, int videoId) {
  final chapterCubit = context.read<ChapterCubit>();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (BuildContext bottomSheetContext) {
      final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

      return Padding(
        padding: EdgeInsets.only(bottom: keyboardHeight),
        child: BlocProvider.value(
          value: chapterCubit,
          child: SizedBox(
            height: 605.h,
            child: BottomSheetCommentsWidget(
              videoId: videoId,
              onClose: () => Navigator.pop(bottomSheetContext),
            ),
          ),
        ),
      );
    },
  );
}