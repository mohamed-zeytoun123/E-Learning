import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:e_learning/core/network/app_url.dart';
import 'package:e_learning/features/chapter/data/models/video_models/download_item.dart';
import 'package:e_learning/features/chapter/presentation/manager/chapter_cubit.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart' as crypto;
import 'package:path_provider/path_provider.dart';
import 'package:pointycastle/api.dart' as pc;
import 'package:pointycastle/block/aes.dart';
import 'package:pointycastle/block/modes/cbc.dart';
import 'package:pointycastle/padded_block_cipher/padded_block_cipher_impl.dart';
import 'package:pointycastle/paddings/pkcs7.dart';
import 'package:permission_handler/permission_handler.dart';

extension ChapterCubitDownload on ChapterCubit {
  Future<void> downloadAttachmentWithProgress({
    required int attachmentId,
    required String token,
    required String fileName,
  }) async {
    // 1️⃣ إضافة الفيديو للقائمة إذا مش موجود
    final existing = state.downloads.indexWhere(
      (d) => d.videoId == attachmentId.toString(),
    );
    if (existing == -1) {
      final newItem = DownloadItem(
        videoId: attachmentId.toString(),
        fileName: fileName,
        isDownloading: true,
        progress: 0.0,
      );
      emit(state.copyWith(downloads: [...state.downloads, newItem]));
    }

    try {
      // 2️⃣ جلب رابط الفيديو أو الملف المشفر
      final url = Uri.parse(
        '${AppUrls.baseURl}/attachments/$attachmentId/download-encrypted/',
      );

      final resp = await http.get(
        url,
        headers: {'Authorization': 'Bearer $token'},
      );

      if (resp.statusCode != 200) {
        throw Exception('Failed to get encrypted token: ${resp.statusCode}');
      }

      final tokenStr = resp.body.trim();
      final tokenBytes = base64UrlDecodeLenient(tokenStr);

      // 🔑 إنشاء المفتاح
      final keyMaterial = '${attachmentId}_${AppUrls.drmKey}';
      final keyHash = crypto.sha256.convert(utf8.encode(keyMaterial)).bytes;
      final fullKey = Uint8List.fromList(keyHash);
      final encKey = fullKey.sublist(0, 16);
      final signKey = fullKey.sublist(16, 32);

      // HMAC Verification
      final sigStart = tokenBytes.length - 32;
      final signedPart = tokenBytes.sublist(0, sigStart);
      final signature = tokenBytes.sublist(sigStart);
      final hmac = crypto.Hmac(crypto.sha256, signKey);
      final computed = Uint8List.fromList(hmac.convert(signedPart).bytes);
      if (!constantTimeEquals(computed, signature)) {
        throw Exception('HMAC Verification Failed');
      }

      // استخراج IV و ciphertext
      final iv = tokenBytes.sublist(9, 25);
      final cipherText = tokenBytes.sublist(25, sigStart);

      // فك التشفير AES-CBC-PKCS7
      final keyParam = pc.KeyParameter(encKey);
      final paramsWithIv = pc.ParametersWithIV(keyParam, iv);
      final paddedParams = pc.PaddedBlockCipherParameters(paramsWithIv, null);
      final paddedCipher = PaddedBlockCipherImpl(
        PKCS7Padding(),
        CBCBlockCipher(AESEngine()),
      );
      paddedCipher.init(false, paddedParams);

      final decrypted = paddedCipher.process(cipherText);

      // حفظ الملف
      if (!await Permission.storage.request().isGranted) {
        throw Exception("Storage permission denied");
      }

      Directory? extDir = await getExternalStorageDirectory();
      extDir ??= await getApplicationDocumentsDirectory();
      final folder = Directory('${extDir.path}/MyAttachments');
      await folder.create(recursive: true);

      final filePath = '${folder.path}/$fileName';
      final file = File(filePath);

      // كتابة bytes مع تحديث progress
      final chunkSize = 1024; // 1KB per chunk
      final sink = file.openWrite();
      for (var i = 0; i < decrypted.length; i += chunkSize) {
        final end = (i + chunkSize < decrypted.length)
            ? i + chunkSize
            : decrypted.length;
        sink.add(decrypted.sublist(i, end));
        final progress = (end / decrypted.length);
        _updateDownloadProgress(attachmentId.toString(), progress);
      }
      await sink.close();

      // اكتمال التحميل
      _completeDownload(attachmentId.toString());
    } catch (e, st) {
      log("Download Error: $e\n$st");
      _setDownloadError(attachmentId.toString());
    }
  }

  void _updateDownloadProgress(String videoId, double progress) {
    final idx = state.downloads.indexWhere((d) => d.videoId == videoId);
    if (idx == -1) return;

    final updated = state.downloads[idx].copyWith(progress: progress);
    final downloads = List<DownloadItem>.from(state.downloads);
    downloads[idx] = updated;
    emit(state.copyWith(downloads: downloads));
  }

  void _completeDownload(String videoId) {
    final idx = state.downloads.indexWhere((d) => d.videoId == videoId);
    if (idx == -1) return;

    final updated = state.downloads[idx].copyWith(
      isDownloading: false,
      isCompleted: true,
      progress: 1.0,
    );
    final downloads = List<DownloadItem>.from(state.downloads);
    downloads[idx] = updated;
    emit(state.copyWith(downloads: downloads));
  }

  void _setDownloadError(String videoId) {
    final idx = state.downloads.indexWhere((d) => d.videoId == videoId);
    if (idx == -1) return;

    final updated = state.downloads[idx].copyWith(
      isDownloading: false,
      hasError: true,
    );
    final downloads = List<DownloadItem>.from(state.downloads);
    downloads[idx] = updated;
    emit(state.copyWith(downloads: downloads));
  }
}

bool constantTimeEquals(Uint8List a, Uint8List b) {
  if (a.length != b.length) return false;
  int diff = 0;
  for (int i = 0; i < a.length; i++) {
    diff |= a[i] ^ b[i];
  }
  return diff == 0;
}

Uint8List base64UrlDecodeLenient(String input) {
  String s = input.replaceAll('-', '+').replaceAll('_', '/');
  int pad = (4 - s.length % 4) % 4;
  s += '=' * pad;
  return base64.decode(s);
}







