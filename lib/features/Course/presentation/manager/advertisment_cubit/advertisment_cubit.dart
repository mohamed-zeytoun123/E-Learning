import 'dart:developer';
import 'package:e_learning/core/utils/state_forms/response_status_enum.dart';
import 'package:e_learning/features/Course/data/source/repo/advertisement_repository.dart';
import 'package:e_learning/features/Course/presentation/manager/advertisment_cubit/advertisment_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdvertisementCubit extends Cubit<AdvertisementState> {
  AdvertisementCubit({required this.repo}) : super(AdvertisementState());
  final AdvertisementRepository repo;

  //?-------------------------------------------------

  //* Get Advertisements
  Future<void> getAdvertisements() async {
    emit(state.copyWith(status: ResponseStatusEnum.loading, error: null));

    final result = await repo.getAdvertisementsRepo();

    result.fold(
      (failure) {
        log('❌ AdvertisementCubit: Failed to get advertisements - ${failure.message}');
        emit(
          state.copyWith(
            status: ResponseStatusEnum.failure,
            error: failure.message,
          ),
        );
      },
      (advertisementResponse) {
        log(
            '✅ AdvertisementCubit: Successfully loaded ${advertisementResponse.results.length} advertisements');
        emit(
          state.copyWith(
            status: ResponseStatusEnum.success,
            advertisements: advertisementResponse.results,
          ),
        );
      },
    );
  }

  //?-------------------------------------------------
}

