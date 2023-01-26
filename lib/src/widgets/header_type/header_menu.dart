import 'package:flutter/material.dart';

import '../../../utils/constant.dart';

enum HeaderMenuType {
  vertical,
  horizontal,
  verticalRevease,
  horizontalRevease,
}

class HeaderMenu extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  final HeaderMenuType headerMenuType;

  const HeaderMenu({
    super.key,
    required this.title,
    required this.value,
    this.headerMenuType = HeaderMenuType.vertical,
    this.color = fontColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (headerMenuType == HeaderMenuType.vertical) ...[
          vertical(),
        ] else if (headerMenuType == HeaderMenuType.horizontal) ...[
          horizontal(),
        ] else if (headerMenuType == HeaderMenuType.verticalRevease) ...[
          verticalRevease(),
        ] else if (headerMenuType == HeaderMenuType.horizontalRevease) ...[
          horizontalRevease(),
        ],
      ],
    );
  }

  Column vertical() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        textBox(value),
        textBox(title),
      ],
    );
  }

  Column verticalRevease() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        textBox(title),
        textBox(value),
      ],
    );
  }

  Row horizontal() {
    return Row(
      children: [
        textBox(value),
        const SizedBox(width: 5),
        textBox(title),
      ],
    );
  }

  Row horizontalRevease() {
    return Row(
      children: [
        textBox(title),
        const SizedBox(width: 5),
        textBox(value),
      ],
    );
  }

  Text textBox(String text) {
    return Text(
      text,
      style: TextStyle(
          color: color,
          fontFamily: "narrow",
          fontWeight: FontWeight.w600,
          fontSize: 16,
          decoration: TextDecoration.none),
    );
  }
}
