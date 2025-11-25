import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  final bool showAppName;

  const AppLogo({
    super.key,
    this.showAppName = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 120,
          width: 120,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        if (showAppName) ...[
          24.sizedH,
          Text(
            "App Name",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ],
    );
  }
}
