import 'package:flutter/material.dart';

import '../../../utils/constant.dart';

class MainButton extends StatelessWidget {
  final Function() onTap;
  final String title;
  final bool outlined;
  final Color color;
  final Color fontColor;
  final double? width;
  final double height;
  final double borderRadius;
  final double fontSize;
  const MainButton({
    super.key,
    required this.onTap,
    this.title = "",
    this.outlined = false,
    this.color = primaryColor,
    this.fontColor = Colors.white,
    this.width,
    this.height = 50,
    this.borderRadius = 10,
    this.fontSize = 20,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color,
          border: Border.all(
            color: outlined ? Colors.white : Colors.transparent,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: fontSize,
              color: fontColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
