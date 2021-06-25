import 'package:flutter/material.dart';

class RoundIconButton extends StatelessWidget {
  RoundIconButton(
      {@required this.child,
      @required this.onPressed,
      this.color,
      this.width,
      this.height,
      this.elevation,
      this.shape});

  final Widget child;
  final Function onPressed;
  final Color color;
  final double width;
  final double height;
  final double elevation;
  final ShapeBorder shape;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: child,
      onPressed: onPressed,
      elevation: elevation ?? 6.0,
      constraints: BoxConstraints.tightFor(
        width: width ?? 56.0,
        height: height ?? 56.0,
      ),
      shape: shape ?? CircleBorder(),
      fillColor: color ?? Color(0xFF4C4F5E),
    );
  }
}
