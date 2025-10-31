import 'package:e_learning/core/utils/state_forms/response_status_enum.dart';
import 'package:e_learning/features/auth/data/models/university_model/university_model.dart';
import 'package:e_learning/features/chapter/data/models/chapter_model.dart';

class ChapterState {
  //?--------------------------------------------------------
  //* Get Chapter Details
  final ChapterModel? chapter;
  final ResponseStatusEnum chaptersStatus;
  final String? chaptersError;


  //?----------------------------------------------------------
  ChapterState({
    //* Get Chapter Details
    this.chapter,
    this.chaptersStatus = ResponseStatusEnum.initial,
    this.chaptersError,

   
  });

  //?--------------------------------------------------------
  ChapterState copyWith({
    //* Get Chapter Details
    ChapterModel? chapter,
    ResponseStatusEnum? chaptersStatus,
    String? chaptersError,

   
  }) {
    return ChapterState(
      //* Get Chapter Details
      chapter: chapter ?? this.chapter,
      chaptersStatus: chaptersStatus ?? this.chaptersStatus,
      chaptersError: chaptersError,

     
    );
  }
}
