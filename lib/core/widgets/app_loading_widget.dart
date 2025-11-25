import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AppLoadingWidget extends StatelessWidget {
  const AppLoadingWidget(
      {super.key, required this.child, required this.isLoading});
  final Widget child;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return Skeletonizer(enabled: isLoading, child: child ,);
  }
}
