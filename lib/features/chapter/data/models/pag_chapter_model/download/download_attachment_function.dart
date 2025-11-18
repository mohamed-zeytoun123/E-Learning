import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:e_learning/core/network/app_url.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart' as crypto;
import 'package:path_provider/path_provider.dart';
import 'package:pointycastle/api.dart' as pc;
import 'package:pointycastle/block/aes.dart';
import 'package:pointycastle/block/modes/cbc.dart';
import 'package:pointycastle/padded_block_cipher/padded_block_cipher_impl.dart';
import 'package:pointycastle/paddings/pkcs7.dart';
import 'package:permission_handler/permission_handler.dart';

Future<String> downloadAndDecryptAttachment({
  required String baseUrl,
  required int attachmentId,
  required String drmKey,
  required String authToken,
}) async {
  final url = Uri.parse(
    '$baseUrl/attachments/$attachmentId/download-encrypted/',
  );

  final resp = await http.get(
    url,
    headers: {if (authToken.isNotEmpty) 'Authorization': 'Bearer $authToken'},
  );

  if (resp.statusCode != 200) {
    throw Exception('Failed to download encrypted token: ${resp.statusCode}');
  }

  final tokenStr = resp.body.trim();

  // -----------------------------
  // 🔐 1) فك Base64
  // -----------------------------
  final tokenBytes = base64UrlDecodeLenient(tokenStr);

  // -----------------------------
  // 🔐 2) إنشاء key من drmKey + attachmentId
  // -----------------------------
  final keyMaterial = '${attachmentId}_$drmKey';
  final keyHash = crypto.sha256.convert(utf8.encode(keyMaterial)).bytes;
  final fullKey = Uint8List.fromList(keyHash);

  final encKey = fullKey.sublist(0, 16);
  final signKey = fullKey.sublist(16, 32);

  // -----------------------------
  // 🛡 3) استخراج الـ HMAC
  // -----------------------------
  final sigStart = tokenBytes.length - 32;
  final signedPart = tokenBytes.sublist(0, sigStart);
  final signature = tokenBytes.sublist(sigStart);

  final hmac = crypto.Hmac(crypto.sha256, signKey);
  final computed = Uint8List.fromList(hmac.convert(signedPart).bytes);

  if (!constantTimeEquals(computed, signature)) {
    throw Exception('HMAC Verification Failed');
  }

  // -----------------------------
  // 🔐 4) استخراج IV و ciphertext
  // -----------------------------
  final iv = tokenBytes.sublist(9, 25); // 1 + 8 = 9
  final cipherText = tokenBytes.sublist(25, sigStart);

  // -----------------------------
  // 🔓 5) فك التشفير AES-CBC-PKCS7
  // -----------------------------
  final keyParam = pc.KeyParameter(encKey);
  final paramsWithIv = pc.ParametersWithIV(keyParam, iv);

  final paddedParams = pc.PaddedBlockCipherParameters(paramsWithIv, null);

  final paddedCipher = PaddedBlockCipherImpl(
    PKCS7Padding(),
    CBCBlockCipher(AESEngine()),
  );

  paddedCipher.init(false, paddedParams);

  final decrypted = paddedCipher.process(cipherText);

  // -----------------------------
  // 💾 6) حفظ الملف
  // -----------------------------
  if (!await Permission.storage.request().isGranted) {
    throw Exception("Storage permission denied");
  }

  Directory? extDir = await getExternalStorageDirectory();
  if (extDir == null) throw Exception("Cannot access external storage");

  final folder = Directory('${extDir.path}/MyAttachments');
  await folder.create(recursive: true);

  final filePath = '${folder.path}/file_$attachmentId.bin';
  final file = File(filePath);

  await file.writeAsBytes(decrypted);

  return file.path;
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

void downloadAttachment({
  required int attachmentId,
  required String token,
}) async {
  try {
    String filePath = await downloadAndDecryptAttachment(
      baseUrl: AppUrls.baseURl,
      attachmentId: attachmentId,
      drmKey: AppUrls.drmKey,
      authToken: token,
    );

    log('Saved at: $filePath');
  } catch (e, st) {
    log("Download Error: $e\n$st");
  }
}
