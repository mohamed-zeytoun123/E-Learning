import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:netwoek/network/api/api_request.dart';
import 'package:netwoek/network/api/api_response.dart';

class Logger {
  static void logProcess({
    required String tag,
    required String message,
    bool success = false,
  }) {
    log("${success ? "✅✅✅" : ""}::$message", name: tag, time: DateTime.now());
  }

  static void logError(dynamic error, String errorLocation) {
    if (kDebugMode) {
      log("", error: error, name: errorLocation);
    }
  }

  static String _formatJson(Map<dynamic, dynamic> json, {int indent = 0}) {
    final indentStr = '  ' * indent;
    final buffer = StringBuffer();
    buffer.writeln('{');
    
    json.forEach((key, value) {
      if (value is Map) {
        buffer.writeln('$indentStr  "$key":');
        buffer.write(_formatJson(value, indent: indent + 1));
      } else if (value is List) {
        buffer.writeln('$indentStr  "$key": [');
        for (var item in value) {
          if (item is Map) {
            buffer.write(_formatJson(item, indent: indent + 2));
          } else {
            buffer.writeln('$indentStr    "$item",');
          }
        }
        buffer.writeln('$indentStr  ],');
      } else {
        buffer.writeln('$indentStr  "$key": "$value",');
      }
    });
    
    buffer.writeln('$indentStr}');
    return buffer.toString();
  }

  static String _bodyConverter(Map body, String label) {
    if (body.isEmpty) {
      return '  $label: (empty)\n';
    }
    
    try {
      final formatted = _formatJson(Map<String, dynamic>.from(body));
      return '  $label:\n$formatted';
    } catch (e) {
      // Fallback to simple format if JSON formatting fails
      final buffer = StringBuffer();
      buffer.writeln('  $label:');
      body.forEach((key, value) {
        buffer.writeln('    $key: $value');
      });
      return buffer.toString();
    }
  }

  static void logApiRequest(ApiRequest request, String type,
      {bool isMedia = false, Map<String, dynamic>? media}) {
    if (kDebugMode) {
      final buffer = StringBuffer();
      buffer.writeln('═══════════════════════════════════════════════════════');
      buffer.writeln('📤 API REQUEST');
      buffer.writeln('═══════════════════════════════════════════════════════');
      buffer.writeln('Method: $type');
      buffer.writeln('URL: ${request.url}');
      
      if (request.headers != null && request.headers!.isNotEmpty) {
        buffer.writeln('\nHeaders:');
        request.headers!.forEach((key, value) {
          buffer.writeln('  $key: $value');
        });
      }
      
      if (isMedia && media != null && media.isNotEmpty) {
        buffer.writeln('\nMedia:');
        media.forEach((key, value) {
          buffer.writeln('  $key: $value');
        });
      }
      
      if (request.body != null && request.body!.isNotEmpty) {
        buffer.writeln('\nBody:');
        buffer.write(_bodyConverter(request.body!, ''));
      } else if (request.params != null && request.params!.isNotEmpty) {
        buffer.writeln('\nQuery Parameters:');
        buffer.write(_bodyConverter(request.params!, ''));
      }
      
      buffer.writeln('═══════════════════════════════════════════════════════');
      
      log(buffer.toString(), name: "🌐 API REQUEST");
    }
  }

  static void logApiResponse(ApiResponse response) {
    if (kDebugMode) {
      final buffer = StringBuffer();
      buffer.writeln('═══════════════════════════════════════════════════════');
      buffer.writeln('📥 API RESPONSE');
      buffer.writeln('═══════════════════════════════════════════════════════');
      buffer.writeln('URL: ${response.url}');
      buffer.writeln('Status Code: ${response.statusCode}');
      buffer.writeln('Success: ${response.success ? "✅ YES" : "❌ NO"}');
      
      if (response.body != null && response.body!.isNotEmpty) {
        buffer.writeln('\nResponse Body:');
        buffer.write(_bodyConverter(response.body!, ''));
      } else {
        buffer.writeln('\nResponse Body: (empty)');
      }
      
      buffer.writeln('═══════════════════════════════════════════════════════');
      
      log(buffer.toString(), name: "🌐 API RESPONSE");
    }
  }
}

class LogTags {
  static const String internetConnection = "Internet connection";

  static const String geolocator = "Geolocator";

  static const String permission = "Permission";

  static const String cash = "Cash";

  static const String navigator = "Navigator";

  static const String mapping = "Mapping";

  static const String firebaseMessaging = "Firebase Messaging";

  static const String initiateApp = "Initiate App";

  static const String performanceTracking = "PERFORMANCE TRACKER";

  static const String unknown = "Unknown";

  static const String widgetRebuild = "REBUILDING WIDGET";

  static const String otp = "OTP";

  static const String camera = "camera";

  static const String map = "MAP";

  static const String downloading = "DOWNLOADING";

  static const String savingImageToGallery = "SAVING IMAGE TO GALLERY";
  static const String appodeal = "APPODEAL";
}
