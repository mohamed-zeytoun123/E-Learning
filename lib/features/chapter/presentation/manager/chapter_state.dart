import 'package:e_learning/core/utils/state_forms/response_status_enum.dart';
import 'package:e_learning/features/Video/data/model/video_stream_model.dart';
import 'package:e_learning/features/chapter/data/models/attachment_download_state.dart';
import 'package:e_learning/features/chapter/data/models/attachment_model.dart';
import 'package:e_learning/features/chapter/data/models/chapter_details_model.dart';
import 'package:e_learning/features/chapter/data/models/quize/quiz_model/answer_model.dart';
import 'package:e_learning/features/chapter/data/models/quize/quiz_model/quiz_details_model.dart';
import 'package:e_learning/features/chapter/data/models/quize/quiz_model/start_quiz_model.dart';
import 'package:e_learning/features/chapter/data/models/quize/submit/submit_completed_model.dart';
import 'package:e_learning/features/chapter/data/models/video_models/comment_model.dart';
import 'package:e_learning/features/chapter/data/models/video_models/comments_result_model.dart';
import 'package:e_learning/features/chapter/data/models/video_models/download_item.dart';
import 'package:e_learning/features/chapter/data/models/video_models/video_model.dart';
import 'package:e_learning/features/chapter/data/models/video_models/videos_result_model.dart';

class ChapterState {
  //?--------------------------------------------------------
  //* Get Chapter Details
  final ChapterDetailsModel? chapter;
  final ResponseStatusEnum chaptersStatus;
  final String? chaptersError;

  //* Get Chapter Attachments
  final List<AttachmentModel>? attachments;
  final ResponseStatusEnum attachmentsStatus;
  final String? attachmentsError;

  //* Attachment Downloads Map (attachmentId -> download state)
  final Map<int, AttachmentDownloadState> attachmentDownloads;

  //*---  Quize  ---------------------------
  //* Step 1 : Get Quiz Details by Chapter ID
  final QuizDetailsModel? quizDetails;
  final ResponseStatusEnum quizDetailsStatus;
  final String? quizDetailsError;

  //* Step 2 : Start Quiz
  final StartQuizModel? statrtQuiz;
  final ResponseStatusEnum statrtQuizStatus;
  final String? statrtQuizError;

  //* Step 3 : Submit Quiz Answer
  final AnswerModel? answer;
  final ResponseStatusEnum answerStatus;
  final String? answerError;
  final Map<int, int> selectedOptions;

  //* Get Videos by Chapter with Pagination
  final VideosResultModel? videos;
  final ResponseStatusEnum? videosStatus;
  final String? videosError;
  final String? videosMoreError;
  final ResponseStatusEnum? videosMoreStatus;

  //* Get Video Streaming
  final VideoStreamModel? videoStreaming;
  final ResponseStatusEnum videoStreamingStatus;
  final String? videoStreamingError;
  final VideoModel? selectVideo;

  //* Video Downloads (progress + state)
  final List<DownloadItem> downloads;

  //* Get Comments
  final CommentsResultModel? comments;
  final ResponseStatusEnum? commentsStatus;
  final String? commentsError;
  final String? commentsMoreError;
  final ResponseStatusEnum? commentsMoreStatus;

  //* Add Comment 
  final CommentModel? comment;
  final ResponseStatusEnum commentStatus;
  final String? commentError;

  //* Step 4 : Submit Completed
  final SubmitCompletedModel? submitAnswersList;
  final ResponseStatusEnum submitAnswersListStatus;
  final String? submitAnswersListError;

  //* Add Comment
  final CommentModel? newComment;
  final ResponseStatusEnum addCommentStatus;
  final String? addCommentError;

  //?----------------------------------------------------------
  ChapterState({
    //* Get Chapter Details
    this.chapter,
    this.chaptersStatus = ResponseStatusEnum.initial,
    this.chaptersError,

    //* Get Chapter Attachments
    this.attachments,
    this.attachmentsStatus = ResponseStatusEnum.initial,
    this.attachmentsError,

    //* Attachment Downloads
    this.attachmentDownloads = const {},

    //*---  Quize  ---------------------------
    //* Step 1  : Get Quiz Details by Chapter ID
    this.quizDetails,
    this.quizDetailsStatus = ResponseStatusEnum.initial,
    this.quizDetailsError,

    //* Step 2 : Start Quiz
    this.statrtQuiz,
    this.statrtQuizStatus = ResponseStatusEnum.initial,
    this.statrtQuizError,

    //* Step 3 : Submit Quiz Answer
    this.answer,
    this.answerStatus = ResponseStatusEnum.initial,
    this.answerError,
    this.selectedOptions = const {},

    //* Get Videos by Chapter with Pagination
    this.videos,
    this.videosStatus = ResponseStatusEnum.initial,
    this.videosError,
    this.videosMoreError,
    this.videosMoreStatus = ResponseStatusEnum.initial,

    //* Get Video Streaming
    this.videoStreaming,
    this.videoStreamingStatus = ResponseStatusEnum.initial,
    this.videoStreamingError,
    this.selectVideo,

    //* Download Video
    this.downloads = const [],

    //* Get Comments
    this.comments,
    this.commentsStatus = ResponseStatusEnum.initial,
    this.commentsError,
    this.commentsMoreError,
    this.commentsMoreStatus,

    //* Add Comment Repository
    this.comment,
    this.commentStatus = ResponseStatusEnum.initial,
    this.commentError,

    //* Step 4 : Submit Completed
    this.submitAnswersList,
    this.submitAnswersListStatus = ResponseStatusEnum.initial,
    this.submitAnswersListError,

    //* Add Comment
    this.newComment,
    this.addCommentStatus = ResponseStatusEnum.initial,
    this.addCommentError,
  });

  //?--------------------------------------------------------
  ChapterState copyWith({
    //* Get Chapter Details
    ChapterDetailsModel? chapter,
    ResponseStatusEnum? chaptersStatus,
    String? chaptersError,

    //* Get Chapter Attachments
    List<AttachmentModel>? attachments,
    ResponseStatusEnum? attachmentsStatus,
    String? attachmentsError,

    //* Attachment Downloads
    Map<int, AttachmentDownloadState>? attachmentDownloads,

    //*---  Quize  ----
    //* Step 1  : Get Quiz Details by Chapter ID
    QuizDetailsModel? quizDetails,
    ResponseStatusEnum? quizDetailsStatus,
    String? quizDetailsError,

    //* Step 2 : Start Quiz
    StartQuizModel? statrtQuiz,
    ResponseStatusEnum? statrtQuizStatus,
    String? statrtQuizError,

    //* Step 3 : Submit Quiz Answer
    AnswerModel? answer,
    ResponseStatusEnum? answerStatus,
    String? answerError,
    Map<int, int>? selectedOptions,

    //* Get Videos by Chapter with Pagination
    VideosResultModel? videos,
    ResponseStatusEnum? videosStatus,
    String? videosError,
    String? videosMoreError,
    ResponseStatusEnum? videosMoreStatus,

    //* Get Video Streaming
    VideoStreamModel? videoStreaming,
    ResponseStatusEnum? videoStreamingStatus,
    String? videoStreamingError,
    VideoModel? selectVideo,

    //* Video Downloads (progress + state)
    List<DownloadItem>? downloads,

    //* Get Comments
    CommentsResultModel? comments,
    ResponseStatusEnum? commentsStatus,
    String? commentsError,
    String? commentsMoreError,
    ResponseStatusEnum? commentsMoreStatus,

    //* Add Comment Repository
    CommentModel? comment,
    ResponseStatusEnum? commentStatus,
    String? commentError,

    //* Step 4 : Submit Completed
    SubmitCompletedModel? submitAnswersList,
    ResponseStatusEnum? submitAnswersListStatus,
    String? submitAnswersListError,

    //* Add Comment
    CommentModel? newComment,
    ResponseStatusEnum? addCommentStatus,
    String? addCommentError,
  }) {
    return ChapterState(
      //* Get Chapter Details
      chapter: chapter ?? this.chapter,
      chaptersStatus: chaptersStatus ?? this.chaptersStatus,
      chaptersError: chaptersError,

      //* Get Chapter Attachments
      attachments: attachments ?? this.attachments,
      attachmentsStatus: attachmentsStatus ?? this.attachmentsStatus,
      attachmentsError: attachmentsError,

      //* Attachment Downloads
      attachmentDownloads: attachmentDownloads ?? this.attachmentDownloads,

      //*---  Quize  ---------------------------
      //* Step 1  : Get Quiz Details by Chapter ID
      quizDetails: quizDetails ?? this.quizDetails,
      quizDetailsStatus: quizDetailsStatus ?? this.quizDetailsStatus,
      quizDetailsError: quizDetailsError,

      //* Step 2 : Start Quiz
      statrtQuiz: statrtQuiz ?? this.statrtQuiz,
      statrtQuizStatus: statrtQuizStatus ?? this.statrtQuizStatus,
      statrtQuizError: statrtQuizError,

      //* Step 3 : Submit Quiz Answer
      answer: answer ?? this.answer,
      answerStatus: answerStatus ?? this.answerStatus,
      answerError: answerError,
      selectedOptions: selectedOptions ?? this.selectedOptions,

      //* Get Videos by Chapter with Pagination
      videos: videos ?? this.videos,
      videosStatus: videosStatus ?? this.videosStatus,
      videosError: videosError ?? this.videosError,
      videosMoreError: videosMoreError ?? this.videosMoreError,
      videosMoreStatus: videosMoreStatus ?? this.videosMoreStatus,

      //* Get Video Streaming
      videoStreaming: videoStreaming ?? this.videoStreaming,
      videoStreamingStatus: videoStreamingStatus ?? this.videoStreamingStatus,
      videoStreamingError: videoStreamingError,
      selectVideo: selectVideo ?? this.selectVideo,

      //* Video Downloads (progress + state)
      downloads: downloads ?? this.downloads,

      //* Get Comments
      comments: comments ?? this.comments,
      commentsStatus: commentsStatus ?? this.commentsStatus,
      commentsError: commentsError,
      commentsMoreError: commentsMoreError,
      commentsMoreStatus: commentsMoreStatus ?? this.commentsMoreStatus,

      //* Add Comment Repository
      comment: comment ?? this.comment,
      commentStatus: commentStatus ?? this.commentStatus,
      commentError: commentError,

      //* Step 4 : Submit Completed
      submitAnswersList: submitAnswersList ?? this.submitAnswersList,
      submitAnswersListStatus:
          submitAnswersListStatus ?? this.submitAnswersListStatus,
      submitAnswersListError: submitAnswersListError,

      //* Add Comment
      newComment: newComment ?? this.newComment,
      addCommentStatus: addCommentStatus ?? this.addCommentStatus,
      addCommentError: addCommentError,
    );
  }
}
