import 'package:flutter/material.dart';
import '../utilities/constants.dart';

class IconContent extends StatelessWidget {
  IconContent(
      {this.icon,
      this.label,
      this.iconSize,
      this.sizedBoxHeight,
      this.labelTextStyle,
      this.iconColor,
      this.label2,
      this.label2TextStyle,
      this.sizedBox2Height});

  final IconData icon;
  final String label;
  final double iconSize;
  final double sizedBoxHeight;
  final TextStyle labelTextStyle;
  final TextStyle label2TextStyle;
  final Color iconColor;
  final String label2;
  final double sizedBox2Height;

  @override
  Widget build(BuildContext context) {
    List<Widget> _colChildren = [
      Expanded(
        flex: 2,
        child: Icon(
          this.icon,
          size: this.iconSize ?? 80.0,
          color: iconColor ?? Colors.white,
        ),
      ),
      SizedBox(
        height: sizedBoxHeight ?? 15.0,
      ),
      Expanded(
        child: Text(
          label,
          style: labelTextStyle ?? kLabelTextStyle,
        ),
      )
    ];

    if (this.label2 != null) {
      _colChildren.add(
        SizedBox(
          height: sizedBox2Height ?? 15.0,
        ),
      );
      _colChildren.add(
        Expanded(
          child: Text(
            label2,
            style: label2TextStyle ?? kLabelTextStyle,
          ),
        ),
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _colChildren,
    );
  }
}
