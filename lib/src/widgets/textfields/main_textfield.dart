import 'package:flutter/material.dart';

class MainTextField extends StatelessWidget {
  final double? width;
  final double? height;
  final TextEditingController? controller;
  final String hintText;
  final bool obscureText;
  final TextInputType keyboardType;
  final String? error;
  final Function(String value)? onChanged;
  final Widget? prefix;
  final Widget? suffix;

  const MainTextField({
    super.key,
    this.width,
    this.height,
    this.controller,
    this.hintText = "",
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.error,
    this.onChanged,
    this.prefix,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: width,
          height: height,
          margin: const EdgeInsets.only(top: 5, bottom: 5),
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          decoration: BoxDecoration(
            border: Border.all(
              width: error != null ? 1.5 : 1,
              color: error != null ? Colors.red : Colors.grey,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            obscureText: obscureText,
            controller: controller,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              prefixIcon: prefix,
              suffixIcon: suffix,
            ),
            onChanged: onChanged,
          ),
        ),
        Visibility(
          visible: error != null,
          child: Row(
            children: [
              Text(
                " * $error",
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
