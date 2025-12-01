import 'dart:developer';
import 'package:url_launcher/url_launcher.dart';

Future<void> openLink(String url) async {
  log("Opening link: $url");
  final Uri uri = Uri.parse(url);

  try {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } catch (e) {
    log('Error launching url: $e');
  }
}
