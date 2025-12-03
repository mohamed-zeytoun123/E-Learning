import 'package:e_learning/core/utils/time_formatter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TimeFormatter Tests', () {
    test('Formats recent time as "just now"', () {
      final now = DateTime.now();
      final result = TimeFormatter.formatRelativeTime(now);
      expect(result, "just now");
    });

    test('Formats time within a minute as "just now"', () {
      final dateTime = DateTime.now().subtract(Duration(seconds: 30));
      final result = TimeFormatter.formatRelativeTime(dateTime);
      expect(result, "just now");
    });

    test('Formats time within an hour as minutes ago', () {
      final dateTime = DateTime.now().subtract(Duration(minutes: 5));
      final result = TimeFormatter.formatRelativeTime(dateTime);
      expect(result, "5 minutes ago");
    });

    test('Formats time within a day as hours ago', () {
      final dateTime = DateTime.now().subtract(Duration(hours: 3));
      final result = TimeFormatter.formatRelativeTime(dateTime);
      expect(result, "3 hours ago");
    });

    test('Formats time within a week as days ago', () {
      final dateTime = DateTime.now().subtract(Duration(days: 2));
      final result = TimeFormatter.formatRelativeTime(dateTime);
      expect(result, "2 days ago");
    });

    test('Formats time older than a week as date', () {
      final dateTime = DateTime.now().subtract(Duration(days: 10));
      final result = TimeFormatter.formatRelativeTime(dateTime);
      // This should format as "MMM d, yyyy"
      expect(result.contains(","), true);
    });

    test('Handles null datetime string gracefully', () {
      final result = TimeFormatter.formatRelativeTimeString("");
      expect(result, "just now");
    });
  });
}