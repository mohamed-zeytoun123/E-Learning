
class HomeState {
  final HomeView currentView;
  final int currentTabIndex;

  HomeState({
    required this.currentView,
    required this.currentTabIndex,
  });

  HomeState copyWith({
    HomeView? currentView,
    int? currentTabIndex,
  }) {
    return HomeState(
      currentView: currentView ?? this.currentView,
      currentTabIndex: currentTabIndex ?? this.currentTabIndex,
    );
  }
}

enum HomeView {
  home,
  articles,
  courses,
  teachers,
}