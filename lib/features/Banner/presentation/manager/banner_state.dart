import 'package:e_learning/core/utils/state_forms/response_status_enum.dart';
import 'package:e_learning/features/Banner/data/models/banner_model/banner_model.dart';

class BannerState {
  //?---------------------------------------------------------------

  //* Get Banners
  final List<BannerModel>? banners;
  final ResponseStatusEnum bannersStatus;
  final String? bannersError;

  //?----------------------------------------------------------------
  BannerState({
    //* Get Banners
    this.banners,
    this.bannersStatus = ResponseStatusEnum.initial,
    this.bannersError,
  });

  //?------------------------------------------------------------------

  BannerState copyWith({
    //* Get Banners
    List<BannerModel>? banners,
    ResponseStatusEnum? bannersStatus,
    String? bannersError,
  }) {
    return BannerState(
      //* Get Banners
      banners: banners ?? this.banners,
      bannersStatus: bannersStatus ?? this.bannersStatus,
      bannersError: bannersError ?? this.bannersError,
    );
  }

  //?-------------------------------------------------
}

