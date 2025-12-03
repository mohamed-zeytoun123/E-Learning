import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:e_learning/core/utils/state_forms/response_status_enum.dart';
import 'package:e_learning/features/chapter/data/models/attachment_download_state.dart';
import 'package:e_learning/features/chapter/data/models/pag_chapter_model/download/download_attachment_function.dart';
import 'package:e_learning/features/chapter/data/models/video_models/comment_model.dart';
import 'package:e_learning/features/chapter/data/models/video_models/comments_result_model.dart';
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
    : super(ChapterState()) {
    _loadCachedVideos();
  }
  final ChapterRepository repo;
  final ChapterLocalDataSource local;

  Future<void> _loadCachedVideos() async {
    try {
      final cachedVideos = await getCachedDownloads();
      if (cachedVideos.isNotEmpty) {
        emit(state.copyWith(downloads: [...state.downloads, ...cachedVideos]));
      }
    } catch (e) {
      log('Error loading cached videos: $e');
    }
  }

  //?--------------------------------------------------------
  //* Set Selected Answer
  void selectAnswer({required int questionIndex, required int choiceIndex}) {
    final newOptions = Map<int, int>.from(state.selectedOptions);
    newOptions[questionIndex] = choiceIndex;

    emit(state.copyWith(selectedOptions: newOptions));
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
      final updatedDownloads = Map<int, AttachmentDownloadState>.from(
        state.attachmentDownloads,
      );
      updatedDownloads[attachmentId] = AttachmentDownloadState(
        attachmentId: attachmentId,
        isDownloading: true,
        progress: 0.0,
      );
      emit(state.copyWith(attachmentDownloads: updatedDownloads));

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

      await OpenFilex.open(filePath);
    } catch (e) {
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
      (quizList) => emit(
        state.copyWith(
          quizDetailsStatus: ResponseStatusEnum.success,
          quizList: quizList,
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
    final previousOptions = Map<int, int>.from(state.selectedOptions);

    final questionIndex = state.statrtQuiz?.questions.indexWhere(
      (q) => q.id == questionId,
    );
    if (questionIndex != null && questionIndex >= 0) {
      final updated = Map<int, int>.from(state.selectedOptions);
      updated[questionIndex] = state.selectedOptions[questionIndex] ?? 0;
      emit(state.copyWith(selectedOptions: updated));
    }

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
  //* Get Videos by Chapter with Pagination
  Future<void> getVideos({
    required int chapterId,
    bool reset = true,
    int page = 1,
  }) async {
    final cubitState = state;

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
      final result = await repo.getVideosRepo(chapterId: chapterId, page: page);

      result.fold(
        (failure) {
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
          final oldVideos = reset
              ? <VideoModel>[]
              : (cubitState.videos?.videos ?? <VideoModel>[]);

          final updatedVideos = <VideoModel>[
            ...oldVideos,
            ...?newVideosResult.videos,
          ];

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
      if (await local.isVideoCached(videoId)) {
        _updateDownloadProgress(videoId, 1.0);
        _completeDownload(videoId);
        await local.saveCachedVideoMeta(videoId: videoId, fileName: fileName);
        return;
      }

      if (await repo.isConnected) {
        final result = await repo.getEncryptedVideoRepo(
          videoId: videoId,
          onProgress: (progress) {
            _updateDownloadProgress(videoId, progress);
          },
        );

        await result.fold(
          (failure) async {
            _setDownloadError(videoId, errorMessage: failure.message);
          },
          (encryptedBytes) async {
            _updateDownloadProgress(videoId, 1.0);
            _completeDownload(videoId);

            await local.saveCachedVideoMeta(
              videoId: videoId,
              fileName: fileName,
            );
          },
        );
      } else {
        _setDownloadError(
          videoId,
          errorMessage: "No internet connection and video not cached",
        );
      }
    } catch (e) {
      _setDownloadError(videoId, errorMessage: e.toString());
    }
  }

  //?--------------------------------------------------------

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

  void _setDownloadError(String videoId, {String? errorMessage}) {
    final index = state.downloads.indexWhere((d) => d.videoId == videoId);
    if (index != -1) {
      final updated = state.downloads[index].copyWith(
        isDownloading: false,
        hasError: true,
        progress: 0.0,
        errorMessage: errorMessage,
      );
      final downloads = List<DownloadItem>.from(state.downloads);
      downloads[index] = updated;
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
      final downloadDate = m['downloadDate'] ?? '';
      if (vid.isEmpty) continue;
      if (await local.isVideoCached(vid)) {
        items.add(
          DownloadItem(
            videoId: vid,
            fileName: name.isNotEmpty ? name : 'video_$vid.mp4',
            isDownloading: false,
            isCompleted: true,
            progress: 1.0,
            downloadDate: downloadDate,
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
      final result = await repo.getEncryptedVideoRepo(videoId: videoId);

      await result.fold(
        (failure) async {
          log('Failed to download video: ${failure.message}');
          _setDownloadError(videoId, errorMessage: failure.message);
        },
        (encryptedBytes) async {
          _completeDownload(videoId);
        },
      );
    } catch (e) {
      _setDownloadError(videoId, errorMessage: e.toString());
    }
  }

  Future<File?> decryptVideoFromCache(String videoId, String fileName) async {
    try {
      final isCached = await local.isVideoCached(videoId);
      if (!isCached) {
        log('Video not cached: $videoId');
        return null;
      }

      final videoBytes = await local.getEncryptedVideo(videoId);
      log('Encrypted video bytes size: ${videoBytes.length}');
      if (videoBytes.isEmpty) {
        return null;
      }

      final tempDir = await getTemporaryDirectory();

      final safeFileName = fileName.isNotEmpty
          ? fileName
          : 'video_$videoId.mp4';
      final tempFile = File('${tempDir.path}/$safeFileName');
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

  Future<void> getComments({
    required int videoId,
    bool reset = true,
    int page = 1,
  }) async {
    final currentState = state;

    if (page <= 0) {
      return;
    }

    if (!reset && currentState.comments?.hasNextPage == false) {
      return;
    }

    if (reset) {
      emit(currentState.copyWith(commentsStatus: ResponseStatusEnum.loading));
    } else {
      emit(
        currentState.copyWith(commentsMoreStatus: ResponseStatusEnum.loading),
      );
    }

    final result = await repo.getCommentsRepo(videoId: videoId, page: page);

    result.fold(
      (failure) {
        if (reset) {
          emit(
            currentState.copyWith(
              commentsStatus: ResponseStatusEnum.failure,
              commentsError: failure.message,
            ),
          );
        } else {
          emit(
            currentState.copyWith(
              commentsMoreStatus: ResponseStatusEnum.failure,
              commentsMoreError: failure.message,
            ),
          );
        }
      },
      (commentsResult) {
        if (reset) {
          emit(
            currentState.copyWith(
              commentsStatus: ResponseStatusEnum.success,
              comments: commentsResult,
            ),
          );
        } else {
          final mergedComments = [
            ...?currentState.comments?.comments,
            ...?commentsResult.comments,
          ];
          emit(
            currentState.copyWith(
              commentsMoreStatus: ResponseStatusEnum.success,
              comments: currentState.comments?.copyWith(
                comments: mergedComments,
                hasNextPage: commentsResult.hasNextPage,
              ),
            ),
          );
        }
      },
    );
  }

  //?--------------------------------------------------------
  //* Add Comment to Video
  Future<void> addComment({
    required int videoId,
    required String content,
  }) async {
    emit(
      state.copyWith(
        commentStatus: ResponseStatusEnum.loading,
        commentError: null,
      ),
    );

    try {
      final result = await repo.addVideoCommentRepo(
        videoId: videoId.toString(),
        content: content,
      );

      result.fold(
        (failure) {
          emit(
            state.copyWith(
              commentStatus: ResponseStatusEnum.failure,
              commentError: failure.message,
            ),
          );
        },
        (newComment) {
          final updatedComments = [newComment, ...?state.comments?.comments];

          emit(
            state.copyWith(
              commentStatus: ResponseStatusEnum.success,
              comment: newComment,
              comments:
                  state.comments?.copyWith(comments: updatedComments) ??
                  CommentsResultModel(
                    comments: updatedComments,
                    hasNextPage: true,
                  ),
            ),
          );
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          commentStatus: ResponseStatusEnum.failure,
          commentError: e.toString(),
        ),
      );
    }
  }

  //?--------------------------------------------------------
  //* Delete Cached Video
  Future<void> deleteCachedVideo(String videoId) async {
    try {
      await local.deleteCachedVideo(videoId);

      final updatedDownloads = state.downloads
          .where((download) => download.videoId != videoId)
          .toList();

      emit(state.copyWith(downloads: updatedDownloads));
    } catch (e) {
      log('Failed to delete cached video: $e');
      rethrow;
    }
  }

  //?--------------------------------------------------------

  //* Step 4 : Submit Completed
  Future<void> submitAnswersList({
    required int attemptId,
    required List<Map<String, dynamic>> answers,
  }) async {
    emit(
      state.copyWith(
        submitAnswersListStatus: ResponseStatusEnum.loading,
        submitAnswersListError: null,
      ),
    );

    final result = await repo.submitQuizAnswersListRepo(
      attemptId: attemptId,
      answers: answers,
    );

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            submitAnswersListStatus: ResponseStatusEnum.failure,
            submitAnswersListError: failure.message,
          ),
        );
      },
      (submit) {
        emit(
          state.copyWith(
            submitAnswersListStatus: ResponseStatusEnum.success,
            submitAnswersList: submit,
          ),
        );
      },
    );
  }

  //?--------------------------------------------------------
  //* Reply to a Comment
  Future<void> replyToComment({
    required int commentId,
    required String content,
    int? videoId, // Add videoId parameter
  }) async {
    emit(
      state.copyWith(
        replyStatus: ResponseStatusEnum.loading,
        replyError: null,
      ),
    );

    try {
      final result = await repo.replyToCommentRepo(
        commentId: commentId,
        content: content,
      );

      result.fold(
        (failure) {
          emit(
            state.copyWith(
              replyStatus: ResponseStatusEnum.failure,
              replyError: failure.message,
            ),
          );
        },
        (newReply) {
          final updatedComments = [...?state.comments?.comments];

          for (int i = 0; i < updatedComments.length; i++) {
            if (updatedComments[i].id == commentId) {
              final updatedParent = CommentModel(
                id: updatedComments[i].id,
                video: updatedComments[i].video,
                author: updatedComments[i].author,
                authorName: updatedComments[i].authorName,
                authorType: updatedComments[i].authorType,
                content: updatedComments[i].content,
                isPublic: updatedComments[i].isPublic,
                createdAt: updatedComments[i].createdAt,
                updatedAt: updatedComments[i].updatedAt,
                parent: updatedComments[i].parent,
                replies: [...updatedComments[i].replies, newReply],
              );

              updatedComments[i] = updatedParent;

              break;
            }

            final replies = [...updatedComments[i].replies];
            bool found = false;
            for (int j = 0; j < replies.length; j++) {
              if (replies[j].id == commentId) {
                final updatedParent = CommentModel(
                  id: replies[j].id,
                  video: replies[j].video,
                  author: replies[j].author,
                  authorName: replies[j].authorName,
                  authorType: replies[j].authorType,
                  content: replies[j].content,
                  isPublic: replies[j].isPublic,
                  createdAt: replies[j].createdAt,
                  updatedAt: replies[j].updatedAt,
                  parent: replies[j].parent,
                  replies: [...replies[j].replies, newReply],
                );

                replies[j] = updatedParent;
                found = true;

                break;
              }
            }

            if (found) {
              final updatedComment = CommentModel(
                id: updatedComments[i].id,
                video: updatedComments[i].video,
                author: updatedComments[i].author,
                authorName: updatedComments[i].authorName,
                authorType: updatedComments[i].authorType,
                content: updatedComments[i].content,
                isPublic: updatedComments[i].isPublic,
                createdAt: updatedComments[i].createdAt,
                updatedAt: updatedComments[i].updatedAt,
                parent: updatedComments[i].parent,
                replies: replies,
              );

              updatedComments[i] = updatedComment;
              break;
            }
          }

          emit(
            state.copyWith(
              replyStatus: ResponseStatusEnum.success,
              replyComment: newReply,
              comments:
                  state.comments?.copyWith(comments: updatedComments) ??
                  CommentsResultModel(
                    comments: updatedComments,
                    hasNextPage: true,
                  ),
            ),
          );
          
          // Note: We don't call getComments here anymore as it would create
          // an infinite loop with the UI listener. The UI will update based
          // on the state changes we emit above.
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          replyStatus: ResponseStatusEnum.failure,
          replyError: e.toString(),
        ),
      );
    }
  }

  //?--------------------------------------------------------
}