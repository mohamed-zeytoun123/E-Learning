
import 'package:network/enums/app_enums.dart';
import 'package:network/exceptions/exceptions.dart';
import 'package:network/extensions/exception_extension.dart';
import 'package:network/extensions/string_extension.dart';
import 'package:network/logger/log.dart';
import 'package:network/mapper/base_model.dart';
import 'package:network/network/api/paginated_api_response.dart';


abstract class _Mapper {
  List<T> mapFromList<T extends Model>(
      List jsonList, T Function(Map json) toModel);
  PaginatedList<T> mapFromPaginatedList<T extends Model>(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic> json) toModel,
  );
  T mapFromJson<T extends Model>(
    Map<String, dynamic> json,
    T Function(Map json) toModel,
  );
}

class Mapper extends _Mapper {
  @override
  T mapFromJson<T extends Model>(Map<String, dynamic> json,
      T Function(Map<String, dynamic> json) toModel) {
    try {
 
      Logger.logProcess(
          tag: LogTags.mapping, message: "Mapping model $T to json file");
      Map<String, dynamic> convertedJson = json ?? {};
      return toModel(convertedJson);
    } catch (e) {
      Logger.logError(e.toString(), LogTags.mapping);
      throw MappingToModelException(
          message: ExceptionCode.MAPPING.extractMessage,
          code: ExceptionCode.MAPPING);
    }
  }

  @override
  List<T> mapFromList<T extends Model>(
      List<dynamic> jsonList, T Function( Map<String, dynamic> json ) toModel) {
    List<T> res = [];
    for (Map json in jsonList) {
      final convertingModel = toModel(json as Map<String, dynamic>);
      res.add(convertingModel);
    }
    return res;
  }

  @override
  PaginatedList<T> mapFromPaginatedList<T extends Model>(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic> json) toModel,
  ) {
    List<T> res = ((json['data'] ?? []) as List)
        .map((item) => toModel(item as Map<String, dynamic>))
        .toList();

    final metaData = PaginationMetaData.fromJson(
        (json['meta'] ?? {}) as Map<String, dynamic>);

    return PaginatedList<T>(meta: metaData, items: res);
  }

  static bool objectToBool(dynamic value) {
    if (value is bool) {
      return value;
    } else {
      return false;
    }
  }

  static String objectToString(dynamic s) => s.toString().toStringValidate;
  static int objectToInt(dynamic s) => s.toString().toInt;
  static double objectToDouble(dynamic s) => s.toString().toDouble;
  
}
