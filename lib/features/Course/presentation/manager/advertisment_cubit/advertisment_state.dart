import 'package:e_learning/core/model/enums/app_enums.dart';
import 'package:e_learning/features/Course/data/models/advertisment_model.dart';

class AdvertisementState {
  //?---------------------------------------------------------------

  //* Get Advertisements
  final List<AdvertisementModel>? advertisements;
  final ResponseStatusEnum status;
  final String? error;

  //?----------------------------------------------------------------
  AdvertisementState({
    this.advertisements,
    this.status = ResponseStatusEnum.initial,
    this.error,
  });

  //?------------------------------------------------------------------

  AdvertisementState copyWith({
    List<AdvertisementModel>? advertisements,
    ResponseStatusEnum? status,
    String? error,
  }) {
    return AdvertisementState(
      advertisements: advertisements ?? this.advertisements,
      status: status ?? this.status,
      error: error,
    );
  }

  //?-------------------------------------------------
}
