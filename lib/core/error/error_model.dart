import 'package:e_learning/core/api/end_points.dart';

class ErrorModel {
  // these fields can be expanded based on requirements "temp example"
  final int statusCode;
  final String errorMessage;

  ErrorModel({required this.statusCode, required this.errorMessage});
  factory ErrorModel.fromJson(Map<String, dynamic> jsonData) {
    return ErrorModel(
      // These name will be changed based on the API response
      statusCode: jsonData[ApiKeys.status],
      errorMessage: jsonData[ApiKeys.errorMessage],
    );
  }
}
