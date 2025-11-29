import 'package:http/http.dart' as http;

Future<Map<String, String>> getHLSQualities(String masterUrl) async {
  final res = await http.get(Uri.parse(masterUrl));
  if (res.statusCode != 200) return {};

  final lines = res.body.split('\n');
  Map<String, String> qualities = {};

  for (int i = 0; i < lines.length; i++) {
    if (lines[i].startsWith('#EXT-X-STREAM-INF')) {
      final nextLine = lines[i + 1].trim();
      final resolutionMatch = RegExp(
        r'RESOLUTION=(\d+x\d+)',
      ).firstMatch(lines[i]);
      if (resolutionMatch != null) {
        qualities[resolutionMatch.group(1)!] = Uri.parse(
          masterUrl,
        ).resolve(nextLine).toString();
      }
    }
  }

  return qualities; // مثال: { "854x480": "https://.../480p/video.m3u8", "1280x720": "https://.../720p/video.m3u8" }
}
