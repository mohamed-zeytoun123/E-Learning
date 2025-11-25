import 'package:dio/dio.dart';

class ApiRequestParameters {
  static const Map<String, String> noAuthHeaders = {
    "Content-Type": Headers.jsonContentType,
    // "Authorization": ""
  };
  static const Map<String, String> authHeaders = {
    "Content-Type": Headers.jsonContentType,
    "Authorization":
        "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoyNjYzOTk5NzY3LCJpYXQiOjE3NjM5OTk3NjcsImp0aSI6ImFiMTg4OGE1MzkzYjQ1N2ZhN2RlZjdkMWVlZTY0MDUxIiwidXNlcl9pZCI6IjciLCJyb2xlIjoiU1RVREVOVCJ9.myKDHkXVXxAcwoxKbx3xKRJ_iOxGLeuCsLkOpjAdssA",
  };
}
