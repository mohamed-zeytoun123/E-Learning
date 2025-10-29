import 'package:flutter/material.dart';

class BubbleArrowPainterWidget extends CustomPainter {
  final bool isMine;
  final Color color;

  BubbleArrowPainterWidget({required this.isMine, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path = Path();

    final mid = size.height / 2;

    if (isMine) {
      path.moveTo(0, mid);
      path.lineTo(size.width, mid - 6);
      path.lineTo(size.width, mid + 6);
    } else {
      path.moveTo(size.width, mid);
      path.lineTo(0, mid - 6);
      path.lineTo(0, mid + 6);
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
