import 'package:http/http.dart' as http;

int closestStandardQuality(int height) {
  if (height == 854) return 480;
  if (height == 1280) return 720;

  final standardHeights = [144, 240, 360, 480, 720, 1080, 2160];
  int closest = standardHeights.first;
  int minDiff = (height - closest).abs();
  for (final h in standardHeights) {
    final diff = (height - h).abs();
    if (diff < minDiff) {
      minDiff = diff;
      closest = h;
    }
  }

  return closest;
}

Future<Map<String, String>> getHLSQualities(String masterUrl) async {
  final res = await http.get(Uri.parse(masterUrl));
  if (res.statusCode != 200) return {};

  final lines = res.body.split('\n');
  Map<String, String> tempQualities = {};

  for (int i = 0; i < lines.length; i++) {
    if (lines[i].startsWith('#EXT-X-STREAM-INF')) {
      final nextLine = lines[i + 1].trim();
      final resolutionMatch = RegExp(
        r'RESOLUTION=(\d+)x(\d+)',
      ).firstMatch(lines[i]);
      if (resolutionMatch != null) {
        final height = int.parse(resolutionMatch.group(2)!);
        final standardHeight = closestStandardQuality(height);
        final label = "${standardHeight}p";

        tempQualities.putIfAbsent(
          label,
          () => Uri.parse(masterUrl).resolve(nextLine).toString(),
        );
      }
    }
  }

  final sortedEntries = tempQualities.entries.toList()
    ..sort((a, b) {
      final h1 = int.parse(a.key.replaceAll('p', ''));
      final h2 = int.parse(b.key.replaceAll('p', ''));
      return h2.compareTo(h1); // العكس
    });

  Map<String, String> qualities = {};

  for (var entry in sortedEntries) {
    qualities[entry.key] = entry.value;
  }

  qualities["AUTO"] = masterUrl;

  return qualities;
}
