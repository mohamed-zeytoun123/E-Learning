import 'package:e_learning/features/Teacher/data/models/teacher_model/teacher_model.dart';

abstract class TeacherLocalDataSource {
  //?----------------------------------------------------

  //* Get Teachers From Cache
  List<TeacherModel> getTeachersInCache();

  //* Save Teachers To Cache
  Future<void> saveTeachersInCache(List<TeacherModel> teachers);

  //?----------------------------------------------------
}

