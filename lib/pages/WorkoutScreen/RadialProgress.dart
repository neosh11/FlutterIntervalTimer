import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' as vmath;

class MyPainter extends CustomPainter {
  MyPainter(this.radiansFilled, this.innerColor);
  double radiansFilled;
  Color innerColor;
  @override
  void paint(Canvas canvas, Size size) {
    // Get the center of the canvas
    final center = Offset(size.width / 2, size.height / 2);

    // Draw the gray background seen on the progress indicator
    // This will act as the background layer.
    canvas.drawCircle(
      center,
      85,
      Paint()
        ..style = PaintingStyle.stroke
        ..color = Colors.black12
        ..strokeWidth = 30,
    );

    // Create a new layer where we will be painting the
    // actual progress indicator
    canvas.saveLayer(
      Rect.fromCenter(center: center, width: 200, height: 200),
      Paint(),
    );

    // Draw the light green portion of the progress indicator
    canvas.drawArc(
      Rect.fromCenter(center: center, width: 170, height: 170),
      vmath.radians(0),
      vmath.radians(radiansFilled),
      false,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..color = innerColor
        ..strokeWidth = 30,
    );

    // Draw the dark green portion of the progress indicator
    // Basically, this covers the entire progress indicator circle.
    // But because we have set the blending mode to srouce-in (BlendMode.srcIn),
    // only the segment that is overlapping with the lighter portion will be visible.
    canvas.drawArc(
      Rect.fromCenter(center: center, width: 155, height: 155),
      vmath.radians(0),
      vmath.radians(360),
      false,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..color = innerColor.withAlpha(100)
        ..strokeWidth = 15
        ..blendMode = BlendMode.srcIn,
    );
    // we fatten the layer
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant MyPainter oldDelegate) =>
      radiansFilled != oldDelegate.radiansFilled;
}
