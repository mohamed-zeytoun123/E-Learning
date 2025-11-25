import 'dart:io';

import 'package:netwoek/enums/app_enums.dart';

class MediaOption{
  final List<File> files;
  final List<String> keys;
  final RequestType requestType;

  const MediaOption({
    required this.files,
    required this.keys,
    required this.requestType,
  }) : assert(files.length == keys.length);

 

  @override
  String toString() {
    String res = '';
    for (int i = 0; i < files.length; i++) {
      res += '${keys[i]}:${files[i].path}\n';
    }
    res += "\n//Request type//${requestType.toString()}";
    return res;
  }
}
