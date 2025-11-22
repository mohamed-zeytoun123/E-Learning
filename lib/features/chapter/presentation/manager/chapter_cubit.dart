import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:e_learning/core/utils/state_forms/response_status_enum.dart';
import 'package:e_learning/features/chapter/data/models/attachment_download_state.dart';
import 'package:e_learning/features/chapter/data/models/pag_chapter_model/download/download_attachment_function.dart';
import 'package:e_learning/features/chapter/data/models/video_models/download_item.dart';
import 'package:e_learning/features/chapter/data/models/video_models/video_model.dart';
import 'package:e_learning/features/chapter/data/models/video_models/videos_result_model.dart';
import 'package:e_learning/features/chapter/data/source/local/chapter_local_data_source.dart';
import 'package:e_learning/features/chapter/data/source/repo/chapter_repository.dart';
import 'package:e_learning/features/chapter/presentation/manager/chapter_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pointycastle/api.dart' as pc;
import 'package:pointycastle/block/aes.dart';
import 'package:pointycastle/block/modes/cbc.dart';
import 'package:pointycastle/padded_block_cipher/padded_block_cipher_impl.dart';
import 'package:pointycastle/paddings/pkcs7.dart';

class ChapterCubit extends Cubit<ChapterState> {
  ChapterCubit({required this.repo, required this.local})
    : super(ChapterState());
  final ChapterRepository repo;
  final ChapterLocalDataSource local;

  //?--------------------------------------------------------
  //* Set Selected Answer
  void selectAnswer({required int questionIndex, required int choiceIndex}) {
    final updated = Map<int, int>.from(state.selectedOptions);
    updated[questionIndex] = choiceIndex;

    emit(state.copyWith(selectedOptions: updated));
  }

  //?--------------------------------------------------------
  //* Set Selected Video
  void setSelectedVideo(VideoModel? video) {
    emit(state.copyWith(selectVideo: video));
  }

  void resetVideoStreamingStatus() {
    emit(state.copyWith(videoStreamingStatus: ResponseStatusEnum.initial));
  }

  //?--------------------------------------------------------
  //* Get Chapter by ID
  Future<void> getChapterById({
    required String courseSlug,
    required int chapterId,
  }) async {
    emit(
      state.copyWith(
        chaptersStatus: ResponseStatusEnum.loading,
        chaptersError: null,
      ),
    );

    final result = await repo.getChapterByIdRepo(
      courseSlug: courseSlug,
      chapterId: chapterId,
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          chaptersStatus: ResponseStatusEnum.failure,
          chaptersError: failure.message,
        ),
      ),
      (chapter) => emit(
        state.copyWith(
          chaptersStatus: ResponseStatusEnum.success,
          chapter: chapter,
        ),
      ),
    );
  }

  //?--------------------------------------------------------
  //* Get Chapter Attachments
  Future<void> getChapterAttachments({required int chapterId}) async {
    emit(
      state.copyWith(
        attachmentsStatus: ResponseStatusEnum.loading,
        attachmentsError: null,
      ),
    );

    final result = await repo.getChapterAttachmentsRepo(chapterId: chapterId);

    result.fold(
      (failure) => emit(
        state.copyWith(
          attachmentsStatus: ResponseStatusEnum.failure,
          attachmentsError: failure.message,
        ),
      ),
      (attachments) => emit(
        state.copyWith(
          attachmentsStatus: ResponseStatusEnum.success,
          attachments: attachments,
        ),
      ),
    );
  }

  //?--------------------------------------------------------
  //* Download Attachment with Progress
  Future<void> downloadAttachmentWithProgress({
    required int attachmentId,
    required String token,
    required String fileName,
    String? fileUrl,
  }) async {
    try {
      // بداية التحميل
      final updatedDownloads = Map<int, AttachmentDownloadState>.from(
        state.attachmentDownloads,
      );
      updatedDownloads[attachmentId] = AttachmentDownloadState(
        attachmentId: attachmentId,
        isDownloading: true,
        progress: 0.0,
      );
      emit(state.copyWith(attachmentDownloads: updatedDownloads));

      // تحميل الملف مع progress callback
      final filePath = await downloadAttachment(
        attachmentId: attachmentId,
        token: token,
        fileName: fileName,
        fileUrl: fileUrl,
        onProgress: (progress) {
          final downloads = Map<int, AttachmentDownloadState>.from(
            state.attachmentDownloads,
          );
          downloads[attachmentId] = downloads[attachmentId]!.copyWith(
            progress: progress,
          );
          emit(state.copyWith(attachmentDownloads: downloads));
        },
      );

      // اكتمل التحميل
      final finalDownloads = Map<int, AttachmentDownloadState>.from(
        state.attachmentDownloads,
      );
      finalDownloads[attachmentId] = AttachmentDownloadState(
        attachmentId: attachmentId,
        isDownloading: false,
        progress: 1.0,
        isDownloaded: true,
        localPath: filePath,
      );
      emit(state.copyWith(attachmentDownloads: finalDownloads));

      // فتح الملف
      await OpenFilex.open(filePath);
    } catch (e) {
      // حذف حالة التحميل في حالة فشل
      final errorDownloads = Map<int, AttachmentDownloadState>.from(
        state.attachmentDownloads,
      );
      errorDownloads.remove(attachmentId);
      emit(state.copyWith(attachmentDownloads: errorDownloads));
      rethrow;
    }
  }

  //?---- Quiz ----------------------------------------------------

  //* Step 1 : Get Quiz Details by Chapter ID
  Future<void> getQuizDetails({required int chapterId}) async {
    emit(
      state.copyWith(
        quizDetailsStatus: ResponseStatusEnum.loading,
        quizDetailsError: null,
      ),
    );

    final result = await repo.getQuizDetailsByChapterRepo(chapterId: chapterId);

    result.fold(
      (failure) => emit(
        state.copyWith(
          quizDetailsStatus: ResponseStatusEnum.failure,
          quizDetailsError: failure.message,
        ),
      ),
      (quiz) => emit(
        state.copyWith(
          quizDetailsStatus: ResponseStatusEnum.success,
          quizDetails: quiz,
        ),
      ),
    );
  }

  //?--------------------------

  //* Step 2 : Start Quiz
  Future<void> startQuiz({required int quizId}) async {
    emit(
      state.copyWith(
        statrtQuizStatus: ResponseStatusEnum.loading,
        statrtQuizError: null,
      ),
    );

    final result = await repo.startQuizRepo(quizId: quizId);

    result.fold(
      (failure) => emit(
        state.copyWith(
          statrtQuizStatus: ResponseStatusEnum.failure,
          statrtQuizError: failure.message,
        ),
      ),
      (quiz) => emit(
        state.copyWith(
          statrtQuizStatus: ResponseStatusEnum.success,
          statrtQuiz: quiz,
        ),
      ),
    );
  }

  //?--------------------------

  //* Step 3 : Submit Quiz Answer
  Future<void> submitAnswer({
    required int quizId,
    required int questionId,
    required int selectedChoiceId,
  }) async {
    // حفظ نسخة من الخيارات الحالية
    final previousOptions = Map<int, int>.from(state.selectedOptions);

    // تحديث UI مباشرة على أساس questionId
    final questionIndex = state.statrtQuiz?.questions.indexWhere(
      (q) => q.id == questionId,
    );
    if (questionIndex != null && questionIndex >= 0) {
      final updated = Map<int, int>.from(state.selectedOptions);
      updated[questionIndex] = state.selectedOptions[questionIndex] ?? 0;
      emit(state.copyWith(selectedOptions: updated));
    }

    // Emit loading state
    emit(
      state.copyWith(
        answerStatus: ResponseStatusEnum.loading,
        answerError: null,
      ),
    );

    final result = await repo.submitQuizAnswerRepo(
      quizId: quizId,
      questionId: questionId,
      selectedChoiceId: selectedChoiceId,
    );

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            answerStatus: ResponseStatusEnum.failure,
            answerError: failure.message,
            selectedOptions: previousOptions,
          ),
        );
      },
      (answer) {
        emit(
          state.copyWith(
            answerStatus: ResponseStatusEnum.success,
            answer: answer,
          ),
        );
      },
    );
  }

  //?--------------------------------------------------------
  //* Step 4 : Submit Completed Quiz (Final submit + grading)
  Future<void> submitCompletedQuiz({required int attemptId}) async {
    emit(
      state.copyWith(
        submitStatus: ResponseStatusEnum.loading,
        submitError: null,
      ),
    );

    final result = await repo.submitCompletedQuizRepo(attemptId: attemptId);

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            submitStatus: ResponseStatusEnum.failure,
            submitError: failure.message,
          ),
        );
      },
      (submit) {
        emit(
          state.copyWith(
            submitStatus: ResponseStatusEnum.success,
            submit: submit,
          ),
        );
      },
    );
  }

  //?--------------------------------------------------------
  //* Get Videos by Chapter with Pagination
  Future<void> getVideos({
    required int chapterId,
    bool reset = true,
    int page = 1,
  }) async {
    final cubitState = state;

    // 1️⃣ تعيين حالة التحميل
    if (reset) {
      emit(
        cubitState.copyWith(
          videosStatus: ResponseStatusEnum.loading,
          videosMoreStatus: ResponseStatusEnum.initial,
          videosError: null,
          videosMoreError: null,
          videos: VideosResultModel.empty(),
        ),
      );
    } else {
      emit(
        cubitState.copyWith(
          videosMoreStatus: ResponseStatusEnum.loading,
          videosMoreError: null,
        ),
      );
    }

    try {
      // 2️⃣ جلب البيانات من الريبو
      final result = await repo.getVideosRepo(chapterId: chapterId, page: page);

      // 3️⃣ التعامل مع النتيجة
      result.fold(
        (failure) {
          // معالجة الأخطاء
          if (reset) {
            emit(
              cubitState.copyWith(
                videosStatus: ResponseStatusEnum.failure,
                videosError: failure.message,
                videosMoreStatus: ResponseStatusEnum.initial,
              ),
            );
          } else {
            emit(
              cubitState.copyWith(
                videosMoreStatus: ResponseStatusEnum.failure,
                videosMoreError: failure.message,
              ),
            );
          }
        },
        (newVideosResult) {
          // 4️⃣ دمج البيانات القديمة والجديدة
          final oldVideos = reset
              ? <VideoModel>[]
              : (cubitState.videos?.videos ?? <VideoModel>[]);

          final updatedVideos = <VideoModel>[
            ...oldVideos,
            ...?newVideosResult.videos,
          ];

          // 5️⃣ تحديث الحالة في الـ cubit
          emit(
            cubitState.copyWith(
              videosStatus: ResponseStatusEnum.success,
              videosMoreStatus: ResponseStatusEnum.success,
              videos: (cubitState.videos ?? VideosResultModel.empty()).copyWith(
                videos: updatedVideos,
                hasNextPage: newVideosResult.hasNextPage,
              ),
              videosError: null,
              videosMoreError: null,
            ),
          );
        },
      );
    } catch (e) {
      log("❌ getVideos Error: $e");
      if (reset) {
        emit(
          cubitState.copyWith(
            videosStatus: ResponseStatusEnum.failure,
            videosError: "An unexpected error occurred",
            videosMoreStatus: ResponseStatusEnum.initial,
          ),
        );
      } else {
        emit(
          cubitState.copyWith(
            videosMoreStatus: ResponseStatusEnum.failure,
            videosMoreError: "An unexpected error occurred",
          ),
        );
      }
    }
  }

  //?---------------------------------------------------------------
  //* Get Secure Video Streaming
  Future<void> getSecureVideo({required String videoId}) async {
    emit(
      state.copyWith(
        videoStreamingStatus: ResponseStatusEnum.loading,
        videoStreamingError: null,
      ),
    );

    final result = await repo.getSecureVideoUrlRepo(videoId: videoId);

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            videoStreamingStatus: ResponseStatusEnum.failure,
            videoStreamingError: failure.message,
          ),
        );
      },
      (videoModel) {
        emit(
          state.copyWith(
            videoStreamingStatus: ResponseStatusEnum.success,
            videoStreaming: videoModel,
          ),
        );
      },
    );
  }

  //?--------------------------------------------------------
  //* Download Video
  Future<void> downloadVideo({
    required String videoId,
    required String fileName,
  }) async {
    // 1️⃣ إضافة الفيديو للقائمة إذا مش موجود
    final existing = state.downloads.indexWhere((d) => d.videoId == videoId);
    if (existing == -1) {
      final newItem = DownloadItem(
        videoId: videoId,
        fileName: fileName,
        isDownloading: true,
        progress: 0.0,
      );
      emit(state.copyWith(downloads: [...state.downloads, newItem]));
    } else {
      // لو موجود، تحديث الحالة
      final updated = state.downloads[existing].copyWith(
        isDownloading: true,
        progress: 0.0,
        hasError: false,
      );
      final downloads = List<DownloadItem>.from(state.downloads);
      downloads[existing] = updated;
      emit(state.copyWith(downloads: downloads));
    }

    try {
      // 2️⃣ التحقق إذا الفيديو موجود بالكاش
      if (await local.isVideoCached(videoId)) {
        // 3️⃣ إذا موجود، تحديث progress لـ 100% والحالة مكتمل
        _updateDownloadProgress(videoId, 1.0);
        _completeDownload(videoId);
        await local.saveCachedVideoMeta(videoId: videoId, fileName: fileName);
        return;
      }

      // 4️⃣ إذا مش موجود بالكاش لكن في إنترنت → نزلو من الريموت مع progress updates
      if (await repo.isConnected) {
        // استخدام طريقة الريبو موجود لتحميل و تشفير الفيديو مع progress tracking
        final result = await repo.getEncryptedVideoRepo(
          videoId: videoId,
          onProgress: (progress) {
            _updateDownloadProgress(videoId, progress);
          },
        );

        await result.fold(
          (failure) async {
            log('Failed to download video: ${failure.message}');
            _setDownloadError(videoId);
          },
          (encryptedBytes) async {
            // تحديث progress لـ 100% والحالة مكتمل
            _updateDownloadProgress(videoId, 1.0);
            _completeDownload(videoId);

            // حفظ ميتاداتا الكاش لعرضها لاحقًا بعد إعادة التشغيل التطبيق
            await local.saveCachedVideoMeta(
              videoId: videoId,
              fileName: fileName,
            );

            log(
              'Video downloaded and encrypted successfully, size: ${encryptedBytes.length} bytes',
            );
          },
        );
      } else {
        // 5️⃣ لا كاش ولا إنترنت
        log('No internet connection and video not cached');
        _setDownloadError(videoId);
      }
    } catch (e) {
      log('Download error: $e');
      _setDownloadError(videoId);
    }
  }

  //?--------------------------------------------------------
  //* Helpers لتحديث Progress / Complete / Error
  void _updateDownloadProgress(String videoId, double progress) {
    final index = state.downloads.indexWhere((d) => d.videoId == videoId);
    if (index != -1) {
      final downloads = List<DownloadItem>.from(state.downloads);
      downloads[index] = downloads[index].copyWith(progress: progress);
      emit(state.copyWith(downloads: downloads));
    }
  }

  void _completeDownload(String videoId) {
    final index = state.downloads.indexWhere((d) => d.videoId == videoId);
    if (index != -1) {
      final downloads = List<DownloadItem>.from(state.downloads);
      downloads[index] = downloads[index].copyWith(
        isDownloading: false,
        isCompleted: true,
        progress: 1.0,
      );
      emit(state.copyWith(downloads: downloads));
    }
  }

  void _setDownloadError(String videoId) {
    final index = state.downloads.indexWhere((d) => d.videoId == videoId);
    if (index != -1) {
      final downloads = List<DownloadItem>.from(state.downloads);
      downloads[index] = downloads[index].copyWith(
        isDownloading: false,
        hasError: true,
      );
      emit(state.copyWith(downloads: downloads));
    }
  }

  Future<bool> isVideoCachedById(String videoId) async {
    return await local.isVideoCached(videoId);
  }

  Future<List<DownloadItem>> getCachedDownloads() async {
    final metas = await local.getAllCachedVideosMeta();
    final List<DownloadItem> items = [];
    for (final m in metas) {
      final vid = m['videoId'] ?? '';
      final name = m['fileName'] ?? '';
      if (vid.isEmpty) continue;
      if (await local.isVideoCached(vid)) {
        items.add(
          DownloadItem(
            videoId: vid,
            fileName: name.isNotEmpty ? name : 'video_$vid.mp4',
            isDownloading: false,
            isCompleted: true,
            progress: 1.0,
          ),
        );
      }
    }
    return items;
  }

  //* تحميل الفيديو، تشفيره، وحفظه في الكاش
  Future<void> downloadVideoAndEncrypt({
    required String videoId,
    required String videoUrl,
    required String fileName,
  }) async {
    final existing = state.downloads.indexWhere((d) => d.videoId == videoId);
    if (existing == -1) {
      final newItem = DownloadItem(
        videoId: videoId,
        fileName: fileName,
        isDownloading: true,
        progress: 0.0,
      );
      emit(state.copyWith(downloads: [...state.downloads, newItem]));
    }

    try {
      // استخدام طريقة الريبو موجود لتحميل و تشفير الفيديو
      final result = await repo.getEncryptedVideoRepo(videoId: videoId);

      await result.fold(
        (failure) async {
          log('Failed to download video: ${failure.message}');
          _setDownloadError(videoId);
        },
        (encryptedBytes) async {
          // اكتمال التحميل
          _completeDownload(videoId);

          log(
            'Video downloaded and encrypted successfully, size: ${encryptedBytes.length} bytes',
          );
        },
      );
    } catch (e) {
      _setDownloadError(videoId);
    }
  }

  Uint8List _encryptVideoBytesSafe(Uint8List plainBytes, String videoId) {
    final key = _getKeyFromVideoId(videoId);
    final iv = Uint8List(16); // IV ثابت، ممكن تغييره لاحقًا

    // استخدام PaddedBlockCipher مع PKCS7
    final cipher =
        PaddedBlockCipherImpl(PKCS7Padding(), CBCBlockCipher(AESEngine()))
          ..init(
            true,
            pc.PaddedBlockCipherParameters(
              pc.ParametersWithIV(pc.KeyParameter(key), iv),
              null,
            ),
          );

    // لو الطول مش مضاعف 16، PaddedBlockCipherImpl يضيف padding PKCS7 تلقائي
    return cipher.process(plainBytes);
  }

  //* فك تشفير الفيديو من الكاش

  //* فك التشفير من الكاش وتحويله لملف مؤقت
  Future<File?> decryptVideoFromCache(String videoId, String fileName) async {
    try {
      // تحقق إذا الفيديو موجود في الكاش
      final isCached = await local.isVideoCached(videoId);
      if (!isCached) {
        log('Video not cached: $videoId');
        return null;
      }

      final videoBytes = await local.getEncryptedVideo(videoId);
      log('Encrypted video bytes size: ${videoBytes.length}');
      if (videoBytes.isEmpty) {
        log('Video bytes empty for video: $videoId');
        return null;
      }

      final tempDir = await getTemporaryDirectory();

      // استخدام اسم الملف الأصلي بدلاً من اسم عام
      final safeFileName = fileName.isNotEmpty
          ? fileName
          : 'video_$videoId.mp4';
      final tempFile = File('${tempDir.path}/$safeFileName');

      // Always attempt to decrypt the video
      try {
        final decryptedBytes = _decryptVideoBytesSafe(
          Uint8List.fromList(videoBytes),
          videoId,
        );
        log('Decrypted video bytes size: ${decryptedBytes.length}');
        await tempFile.writeAsBytes(decryptedBytes);
        log('Video written to temporary file: ${tempFile.path}');
        log('Temporary file size: ${decryptedBytes.length} bytes');
        return tempFile;
      } catch (decryptError) {
        log('Failed to decrypt video: $decryptError');
        return null;
      }
    } catch (e) {
      log('Failed to load video from cache: $e');
      return null;
    }
  }

  Uint8List _decryptVideoBytesSafe(Uint8List encryptedBytes, String videoId) {
    final key = _getKeyFromVideoId(videoId);
    final iv = Uint8List(16);

    final cipher =
        PaddedBlockCipherImpl(PKCS7Padding(), CBCBlockCipher(AESEngine()))
          ..init(
            false,
            pc.PaddedBlockCipherParameters(
              pc.ParametersWithIV(pc.KeyParameter(key), iv),
              null,
            ),
          );

    return cipher.process(encryptedBytes);
  }

  //* توليد مفتاح AES ثابت 16 بايت من videoId
  Uint8List _getKeyFromVideoId(String videoId) {
    final padded = videoId.padRight(16, '0');
    final keyStr = padded.substring(0, 16);
    return Uint8List.fromList(keyStr.codeUnits);
  }

  //?--------------------------------------------------------

  //* Update Video Progress
  Future<void> updateVideoProgress({
    required int videoId,
    required int watchedSeconds,
  }) async {
    final result = repo.updateVideoProgress(
      videoId: videoId,
      watchedSeconds: watchedSeconds,
    );
  }

  //?--------------------------------------------------------
}
