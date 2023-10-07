// Library declaration for the 3D text effect.
library text_3d;

import 'dart:ui';
import 'package:flutter/material.dart';
import 'dart:math';

// Define the different styles available for 3D text.
enum ThreeDStyle {
  standard,
  raised,
  inset,
  perspectiveRaised,
  perspectiveInset,
  perspectiveLeft,
  perspectiveRight,
}

// Main widget for rendering 3D text.
class ThreeDText extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  final double depth; // Depth defines the 'thickness' of the 3D effect.
  final ThreeDStyle style; // The style of 3D effect.
  final double angle; // Angle of shadow layers
  final double perspectiveDepth; // Perspective depth for some effects

  ThreeDText({
    required this.text,
    required this.textStyle,
    this.depth = 10.0,
    this.style = ThreeDStyle.standard,
    this.angle = 0.0,
    this.perspectiveDepth = 300.0, // Default perspective depth
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> layers = [];

    // Choose the appropriate 3D effect based on the style.
    switch (style) {
      case ThreeDStyle.standard:
        layers.addAll(_standardLayers());
        break;
      case ThreeDStyle.raised:
        layers.addAll(_raisedLayers());
        break;
      case ThreeDStyle.inset:
        layers.addAll(_insetLayers());
        break;
      default:
        layers.addAll(_perspectiveLayers());
    }

    return Stack(children: layers);
  }

  // Function to paint the 3D effect on the canvas.
  void paint(Canvas canvas, Size size) {
    final textSpan = TextSpan(text: text, style: textStyle);
    final textPainter =
        TextPainter(text: textSpan, textDirection: TextDirection.ltr);

    for (int i = 1; i <= depth; i++) {
      textPainter.paint(canvas, Offset(i * sin(angle), i * cos(angle)));
    }
    textPainter.paint(canvas, Offset(0, 0)); // Draw the main text
  }

  // Calculate offset based on the angle for 3D shadow.
  Offset _calculateOffset(int i) {
    return Offset(i * sin(angle), i * cos(angle));
  }

  // Normalize the layer number to get 3D effect.
  Offset _calculate3DOffset(int layer) {
    double factor = layer / depth;
    return Offset(lerpDouble(0, _calculateOffset(layer).dx, factor)!,
        lerpDouble(0, _calculateOffset(layer).dy, factor)!);
  }

  // Generate perspective transformation matrix.
  Matrix4 _perspectiveMatrix() {
    return Matrix4.identity()..setEntry(3, 2, 1 / perspectiveDepth);
  }

  // Layers for the standard 3D effect.
  List<Widget> _standardLayers() {
    return [
      for (int i = 1; i <= depth; i++)
        Transform.translate(
          offset: _calculate3DOffset(i),
          child: Text(
            text,
            style: textStyle.copyWith(color: Colors.black.withOpacity(0.2)),
          ),
        ),
      Text(text, style: textStyle),
    ];
  }

  // Layers for the raised 3D effect.
  List<Widget> _raisedLayers() {
    return [
      Text(text, style: textStyle),
      for (int i = 1; i <= depth; i++)
        Transform.translate(
          offset: _calculate3DOffset(i),
          child: Text(
            text,
            style: textStyle.copyWith(color: Colors.black.withOpacity(0.1)),
          ),
        ),
    ];
  }

  // Layers for the inset 3D effect.
  List<Widget> _insetLayers() {
    return [
      for (int i = 1; i <= depth; i++)
        Transform.translate(
          offset: _calculate3DOffset(-i),
          child: Text(
            text,
            style: textStyle.copyWith(color: Colors.black.withOpacity(0.2)),
          ),
        ),
      Text(text, style: textStyle),
    ];
  }

  // Layers for various perspective effects.
  List<Widget> _perspectiveLayers() {
    var transformation = _perspectiveMatrix();

    // Adjust transformation based on the style.
    switch (style) {
      case ThreeDStyle.perspectiveRaised:
        transformation.rotateX(0.2);
        break;
      case ThreeDStyle.perspectiveInset:
        transformation.rotateX(-0.2);
        break;
      case ThreeDStyle.perspectiveLeft:
        transformation.rotateY(0.2);
        break;
      case ThreeDStyle.perspectiveRight:
        transformation.rotateY(-0.2);
        break;
      default:
        break;
    }

    return [
      for (int i = 1; i <= depth; i++)
        Transform(
          alignment: FractionalOffset.center,
          transform: transformation,
          child: Transform.translate(
            offset: _calculate3DOffset(i),
            child: Text(
              text,
              style: textStyle.copyWith(
                  color: Colors.black.withOpacity(
                      0.1 / i)), // Fading the shadow makes it more realistic
            ),
          ),
        ),
      Transform(
        alignment: FractionalOffset.center,
        transform: transformation,
        child: Text(text, style: textStyle),
      ),
    ];
  }
}
