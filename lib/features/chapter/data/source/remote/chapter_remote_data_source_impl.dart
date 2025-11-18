import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_learning/core/Error/failure.dart';
import 'package:e_learning/core/network/api_general.dart';
import 'package:e_learning/core/network/api_request.dart';
import 'package:e_learning/core/network/api_response.dart';
import 'package:e_learning/core/network/app_url.dart';
import 'package:e_learning/features/chapter/data/models/attachment_model.dart';
import 'package:e_learning/features/chapter/data/models/chapter_details_model.dart';
import 'package:e_learning/features/chapter/data/models/quize/quiz_model/answer_model.dart';
import 'package:e_learning/features/chapter/data/models/quize/quiz_model/quiz_details_model.dart';
import 'package:e_learning/features/chapter/data/models/quize/quiz_model/start_quiz_model.dart';
import 'package:e_learning/features/chapter/data/models/quize/submit/submit_completed_model.dart';
import 'package:e_learning/features/chapter/data/source/remote/chapter_remote_data_source.dart';

class ChapterRemoteDataSourceImpl implements ChapterRemoteDataSource {
  final API api;

  ChapterRemoteDataSourceImpl({required this.api});

  //?----------------------------------------------------

  //* Get Chapter by ID
  @override
  Future<Either<Failure, ChapterDetailsModel>> getChapterByIdRemote({
    required String courseSlug,
    required int chapterId,
  }) async {
    try {
      final ApiRequest request = ApiRequest(
        url: AppUrls.getChapterById(courseSlug, chapterId.toString()),
      );

      final ApiResponse response = await api.get(request);

      if (response.statusCode == 200) {
        final data = response.body;
        if (data is Map<String, dynamic>) {
          final chapter = ChapterDetailsModel.fromMap(data);
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

  //?----------------------------------------------------

  //* Get Chapter Attachments
  @override
  Future<Either<Failure, List<AttachmentModel>>> getChapterAttachmentsRemote({
    required int chapterId,
  }) async {
    try {
      final ApiRequest request = ApiRequest(
        url: AppUrls.getChapterAttachments(chapterId),
      );

      final ApiResponse response = await api.get(request);

      if (response.statusCode == 200) {
        final data = response.body;

        if (data is List) {
          final attachments = data
              .map((e) => AttachmentModel.fromMap(e as Map<String, dynamic>))
              .toList();

          return Right(attachments);
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

  //?--  Quiz --------------------------------------------------

  //* Step 1 : Get Quiz Details by Chapter ID
  @override
  Future<Either<Failure, QuizDetailsModel>> getQuizDetailsByChapterRemote({
    required int chapterId,
  }) async {
    try {
      final ApiRequest request = ApiRequest(
        url: AppUrls.getQuizByChapter("$chapterId"),
      );

      final ApiResponse response = await api.get(request);

      log("QUIZ RESPONSE: ${response.body}");

      if (response.statusCode == 200) {
        final data = response.body;

        if (data is Map<String, dynamic> && data.containsKey("error")) {
          return Left(
            Failure(message: data["error"].toString(), statusCode: 404),
          );
        }

        if (data is Map<String, dynamic>) {
          final quiz = QuizDetailsModel.fromJson(data);
          return Right(quiz);
        }

        return Left(FailureServer());
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

  //?------------------------------------
  //* Step 2 : Start Quiz
  @override
  Future<Either<Failure, StartQuizModel>> startQuizRemote({
    required int quizId,
  }) async {
    try {
      final ApiRequest request = ApiRequest(url: AppUrls.startQuiz(quizId));

      final ApiResponse response = await api.post(request);

      log("START QUIZ RESPONSE: ${response.body}");

      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = response.body;
        if (data is Map<String, dynamic>) {
          final quiz = StartQuizModel.fromJson(data);
          return Right(quiz);
        } else {
          return Left(FailureServer());
        }
      } else {
        return Left(
          Failure(
            message: response.body['error']?.toString() ?? 'Unknown error',
            statusCode: response.statusCode,
          ),
        );
      }
    } catch (exception) {
      log(exception.toString());
      return Left(Failure.handleError(exception as DioException));
    }
  }

  //?------------------------------------

  //* Step 3 : Submit Quiz Answer
  @override
  Future<Either<Failure, AnswerModel>> submitQuizAnswerRemote({
    required int quizId,
    required int questionId,
    required int selectedChoiceId,
  }) async {
    try {
      final ApiRequest request = ApiRequest(
        url: AppUrls.submitQuizAnswer(quizId),
        body: {
          "question_id": questionId,
          "selected_choice_id": selectedChoiceId,
        },
      );

      final ApiResponse response = await api.post(request);

      log("SUBMIT QUIZ ANSWER RESPONSE: ${response.body}");

      final data = response.body;

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (data is Map<String, dynamic>) {
          // حالة النجاح أو حتى الخطأ المرسل في body
          if (data.containsKey("error")) {
            return Left(
              Failure(
                message: data["error"].toString(),
                statusCode: response.statusCode,
              ),
            );
          } else {
            final answer = AnswerModel.fromJson(data);
            return Right(answer);
          }
        } else {
          return Left(FailureServer());
        }
      } else {
        if (data is Map<String, dynamic> && data.containsKey("error")) {
          return Left(
            Failure(
              message: data["error"].toString(),
              statusCode: response.statusCode,
            ),
          );
        }
        return Left(
          Failure(message: "Unknown error", statusCode: response.statusCode),
        );
      }
    } catch (exception) {
      log(exception.toString());
      return Left(Failure.handleError(exception as DioException));
    }
  }

  //?------------------------------------
  //* Step 4 : Submit Completed Quiz (Final submit + grading)
  @override
  Future<Either<Failure, SubmitCompletedModel>> submitCompletedQuizRemote({
    required int attemptId,
  }) async {
    try {
      final ApiRequest request = ApiRequest(
        url: AppUrls.submitCompletedQuiz(attemptId),
      );

      final ApiResponse response = await api.post(request);

      log("SUBMIT COMPLETED QUIZ RESPONSE: ${response.body}");

      final data = response.body;

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (data is Map<String, dynamic>) {
          if (data.containsKey("error")) {
            return Left(
              Failure(
                message: data["error"].toString(),
                statusCode: response.statusCode,
              ),
            );
          }

          final submit = SubmitCompletedModel.fromJson(data);
          return Right(submit);
        } else {
          return Left(FailureServer());
        }
      }

      if (data is Map<String, dynamic> && data.containsKey("error")) {
        return Left(
          Failure(
            message: data["error"].toString(),
            statusCode: response.statusCode,
          ),
        );
      }

      return Left(
        Failure(message: "Unknown error", statusCode: response.statusCode),
      );
    } catch (exception) {
      log(exception.toString());
      return Left(Failure.handleError(exception as DioException));
    }
  }

  //?--------------------------------------------------------
}
