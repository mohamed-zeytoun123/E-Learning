import 'package:json_annotation/json_annotation.dart';

/// Converts dynamic value to int, handling null, string numbers, and "null" strings
class IntConverter implements JsonConverter<int, dynamic> {
  const IntConverter();

  @override
  int fromJson(dynamic json) {
    if (json == null) return 0;
    if (json is int) return json;
    if (json is String) {
      if (json == "null" || json.isEmpty) return 0;
      return int.tryParse(json) ?? 0;
    }
    if (json is num) return json.toInt();
    return 0;
  }

  @override
  dynamic toJson(int object) => object;
}

/// Converts dynamic value to nullable int, handling null, string numbers, and "null" strings
class NullableIntConverter implements JsonConverter<int?, dynamic> {
  const NullableIntConverter();

  @override
  int? fromJson(dynamic json) {
    if (json == null) return null;
    if (json is int) return json;
    if (json is String) {
      if (json == "null" || json.isEmpty) return null;
      return int.tryParse(json);
    }
    if (json is num) return json.toInt();
    return null;
  }

  @override
  dynamic toJson(int? object) => object;
}

/// Converts dynamic value to String, handling null and "null" strings
class StringConverter implements JsonConverter<String, dynamic> {
  const StringConverter();

  @override
  String fromJson(dynamic json) {
    if (json == null) return '';
    if (json is String) {
      if (json == "null") return '';
      return json;
    }
    return json.toString();
  }

  @override
  dynamic toJson(String object) => object;
}

/// Converts dynamic value to nullable String, handling null and "null" strings
class NullableStringConverter implements JsonConverter<String?, dynamic> {
  const NullableStringConverter();

  @override
  String? fromJson(dynamic json) {
    if (json == null) return null;
    if (json is String) {
      if (json == "null" || json.isEmpty) return null;
      return json;
    }
    return json.toString();
  }

  @override
  dynamic toJson(String? object) => object;
}

/// Converts dynamic value to double, handling null, string numbers, and "null" strings
class DoubleConverter implements JsonConverter<double, dynamic> {
  const DoubleConverter();

  @override
  double fromJson(dynamic json) {
    if (json == null) return 0.0;
    if (json is double) return json;
    if (json is int) return json.toDouble();
    if (json is String) {
      if (json == "null" || json.isEmpty) return 0.0;
      return double.tryParse(json) ?? 0.0;
    }
    if (json is num) return json.toDouble();
    return 0.0;
  }

  @override
  dynamic toJson(double object) => object;
}

/// Converts dynamic value to nullable double, handling null, string numbers, and "null" strings
class NullableDoubleConverter implements JsonConverter<double?, dynamic> {
  const NullableDoubleConverter();

  @override
  double? fromJson(dynamic json) {
    if (json == null) return null;
    if (json is double) return json;
    if (json is int) return json.toDouble();
    if (json is String) {
      if (json == "null" || json.isEmpty) return null;
      return double.tryParse(json);
    }
    if (json is num) return json.toDouble();
    return null;
  }

  @override
  dynamic toJson(double? object) => object;
}

/// Converts dynamic value to DateTime, handling null and string dates
class DateTimeConverter implements JsonConverter<DateTime, dynamic> {
  const DateTimeConverter();

  @override
  DateTime fromJson(dynamic json) {
    if (json == null) return DateTime.now();
    if (json is DateTime) return json;
    if (json is String) {
      if (json == "null" || json.isEmpty) return DateTime.now();
      try {
        return DateTime.parse(json);
      } catch (e) {
        return DateTime.now();
      }
    }
    return DateTime.now();
  }

  @override
  dynamic toJson(DateTime object) => object.toIso8601String();
}

/// Converts dynamic value to nullable DateTime, handling null and string dates
class NullableDateTimeConverter implements JsonConverter<DateTime?, dynamic> {
  const NullableDateTimeConverter();

  @override
  DateTime? fromJson(dynamic json) {
    if (json == null) return null;
    if (json is DateTime) return json;
    if (json is String) {
      if (json == "null" || json.isEmpty) return null;
      try {
        return DateTime.parse(json);
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  @override
  dynamic toJson(DateTime? object) => object?.toIso8601String();
}

/// Converts dynamic value to bool, handling null, string booleans, and "null" strings
class BoolConverter implements JsonConverter<bool, dynamic> {
  const BoolConverter();

  @override
  bool fromJson(dynamic json) {
    if (json == null) return false;
    if (json is bool) return json;
    if (json is String) {
      if (json == "null" || json.isEmpty) return false;
      if (json.toLowerCase() == "true") return true;
      if (json.toLowerCase() == "false") return false;
      return false;
    }
    if (json is num) return json != 0;
    return false;
  }

  @override
  dynamic toJson(bool object) => object;
}
