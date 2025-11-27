import 'package:dio/dio.dart';

class ApiRequestParameters {
  static const Map<String, String> noAuthHeaders = {
    "Content-Type": Headers.jsonContentType,
    // "Authorization": ""
  };
  static const Map<String, String> authHeaders = {
    "Content-Type": Headers.jsonContentType,
    "Authorization":
        "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoyNjY0MjY2NzU4LCJpYXQiOjE3NjQyNjY3NTgsImp0aSI6IjdmODUwMWJmYmE1MDQ2MDZhZDMwYWU5OGE4YjMyOTQwIiwidXNlcl9pZCI6IjM1Iiwicm9sZSI6IlNUVURFTlQifQ.FnV_4zEBih0Y8Xf1GBX_9TLEKVsIJw8SMBTdmmJIhwQ",
  };
}
