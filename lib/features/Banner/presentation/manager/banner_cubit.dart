import 'package:e_learning/core/utils/state_forms/response_status_enum.dart';
import 'package:e_learning/features/Banner/data/source/repo/banner_repository.dart';
import 'package:e_learning/features/Banner/presentation/manager/banner_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BannerCubit extends Cubit<BannerState> {
  BannerCubit({required this.repo}) : super(BannerState());
  final BannerRepository repo;

  //?-------------------------------------------------

  //* Get Banners
  Future<void> getBanners({
    int? page,
    int? pageSize,
  }) async {
    emit(state.copyWith(bannersStatus: ResponseStatusEnum.loading));

    final result = await repo.getBannersRepo(
      page: page,
      pageSize: pageSize,
    );

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            bannersStatus: ResponseStatusEnum.failure,
            bannersError: failure.message,
          ),
        );
      },
      (bannerResponse) {
        emit(
          state.copyWith(
            bannersStatus: ResponseStatusEnum.success,
            banners: bannerResponse.results,
            bannersError: null,
          ),
        );
      },
    );
  }

  //?-------------------------------------------------
}

