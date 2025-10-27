import 'package:e_learning/features/home/presentation/manager/tabs_cubit/tabs_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';





class HomeCubit extends Cubit<HomeState> {
  HomeCubit()
      : super(HomeState(currentView: HomeView.home, currentTabIndex: 0));

  void changeHomeView(HomeView view) {
    emit(state.copyWith(currentView: view));
  }

  void changeTab(int index) {
    emit(state.copyWith(
      currentTabIndex: index,
    ));
  }

  void resetHomeView() {
    emit(state.copyWith(currentView: HomeView.home));
  }
}
