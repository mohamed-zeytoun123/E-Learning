import 'package:e_learning/core/model/enums/app_enums.dart';
import 'package:e_learning/features/Video/data/models/video_stream_model.dart';
import 'package:e_learning/features/chapter/data/models/attachment_download_state.dart';
import 'package:e_learning/features/chapter/data/models/attachment_model.dart';
import 'package:e_learning/features/chapter/data/models/chapter_details_model.dart';
import 'package:e_learning/features/chapter/data/models/answer_model.dart';
import 'package:e_learning/features/chapter/data/models/quiz_details_model.dart';
import 'package:e_learning/features/chapter/data/models/start_quiz_model.dart';
import 'package:e_learning/features/chapter/data/models/submit_completed_model.dart';
import 'package:e_learning/features/chapter/data/models/download_item.dart';
import 'package:e_learning/features/chapter/data/models/video_model.dart';
import 'package:e_learning/features/chapter/data/models/videos_result_model.dart';

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

  //* Step 4 : Submit Completed Quiz (Final submit + grading)
  final SubmitCompletedModel? submit;
  final ResponseStatusEnum? submitStatus;
  final String? submitError;

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

    //* Step 4 : Submit Completed Quiz (Final submit + grading)
    this.submit,
    this.submitStatus = ResponseStatusEnum.initial,
    this.submitError,

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

    //* Step 4 : Submit Completed Quiz (Final submit + grading)
    SubmitCompletedModel? submit,
    ResponseStatusEnum? submitStatus,
    String? submitError,

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

      //* Step 4 : Submit Completed Quiz (Final submit + grading)
      submit: submit ?? this.submit,
      submitStatus: submitStatus ?? this.submitStatus,
      submitError: submitError ?? this.submitError,

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
    );
  }
}
