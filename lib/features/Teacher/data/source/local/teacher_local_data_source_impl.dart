import 'package:e_learning/features/Teacher/data/models/teacher_model.dart';
import 'package:e_learning/features/Teacher/data/source/local/teacher_local_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class TeacherLocalDataSourceImpl implements TeacherLocalDataSource {
  final SharedPreferences sharedPreferences;
  static const String _cacheKey = 'cached_teachers';

  TeacherLocalDataSourceImpl({required this.sharedPreferences});

  //?--- Teachers -------------------------------------------------

  //* Get Teachers From Cache
  @override
  List<TeacherModel> getTeachersInCache() {
    try {
      final cachedData = sharedPreferences.getString(_cacheKey);
      if (cachedData != null) {
        final List<dynamic> jsonList = json.decode(cachedData);
        return jsonList
            .map((json) => TeacherModel.fromMap(json as Map<String, dynamic>))
            .toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  //* Save Teachers To Cache
  @override
  Future<void> saveTeachersInCache(List<TeacherModel> teachers) async {
    try {
      final jsonList = teachers.map((teacher) => teacher.toMap()).toList();
      await sharedPreferences.setString(_cacheKey, json.encode(jsonList));
    } catch (_) {}
  }

  //?----------------------------------------------------
}
