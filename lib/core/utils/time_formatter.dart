import 'package:intl/intl.dart';

class TimeFormatter {
  /// Formats a DateTime to a relative time string like "just now", "5 minutes ago", etc.
  static String formatRelativeTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    
    if (difference.inSeconds < 60) {
      return "just now";
    } else if (difference.inMinutes < 60) {
      final minutes = difference.inMinutes;
      return "$minutes ${minutes == 1 ? 'minute' : 'minutes'} ago";
    } else if (difference.inHours < 24) {
      final hours = difference.inHours;
      return "$hours ${hours == 1 ? 'hour' : 'hours'} ago";
    } else if (difference.inDays < 7) {
      final days = difference.inDays;
      return "$days ${days == 1 ? 'day' : 'days'} ago";
    } else {
      // For older dates, show the actual date
      return DateFormat('MMM d, yyyy').format(dateTime);
    }
  }
  
  /// Formats a DateTime string to a relative time string
  static String formatRelativeTimeString(String dateTimeString) {
    final dateTime = DateTime.tryParse(dateTimeString);
    if (dateTime == null) {
      return "just now";
    }
    return formatRelativeTime(dateTime);
  }
}