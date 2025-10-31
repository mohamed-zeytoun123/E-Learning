import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_learning/core/Error/failure.dart';
import 'package:e_learning/core/network/api_general.dart';
import 'package:e_learning/core/network/api_request.dart';
import 'package:e_learning/core/network/api_response.dart';
import 'package:e_learning/core/network/app_url.dart';
import 'package:e_learning/features/auth/data/models/university_model/university_model.dart';
import 'package:e_learning/features/chapter/data/models/chapter_model.dart';
import 'package:e_learning/features/chapter/data/source/remote/chapter_remote_data_source.dart';

class ChapterRemoteDataSourceImpl implements ChapterRemoteDataSource {
  final API api;

  ChapterRemoteDataSourceImpl({required this.api});

  //?----------------------------------------------------

  //* Get Chapter by ID
  @override
  Future<Either<Failure, ChapterModel>> getChapterByIdRemote({
    required String courseSlug,
    required int chapterId,
  }) async {
    try {
      final ApiRequest request = ApiRequest(
        url: AppUrls.getChapterById(courseSlug, chapterId),
      );

      final ApiResponse response = await api.get(request);

      if (response.statusCode == 200) {
        final data = response.body;
        if (data is Map<String, dynamic>) {
          final chapter = ChapterModel.fromMap(data);
          return Right(chapter);
        } else {
          return Left(FailureServer());
        }
      } else {
        return Left(
          Failure(
            message: response.body['message']?.toString() ?? 'Unknown error',
            statusCode: response.statusCode,
          ),
        );
      }
    } catch (exception) {
      log(exception.toString());
      return Left(Failure.handleError(exception as DioException));
    }
  }

  //?--------------------------------------------------------

}
