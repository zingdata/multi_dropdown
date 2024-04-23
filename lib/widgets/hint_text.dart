import 'package:flutter/material.dart';

/// [HintText] is a hint text builder.
/// It is used to build the hint text.
class HintText extends StatelessWidget {
  final TextStyle? hintStyle;
  final String hintText;
  final Color? hintColor;
  final EdgeInsets padding;

  const HintText({
    Key? key,
    this.hintStyle,
    required this.hintText,
    this.hintColor,
    required this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Text(
        hintText,
        style: hintStyle ??
            TextStyle(
              fontSize: 13,
              color: hintColor ?? Colors.grey.shade300,
            ),
      ),
    );
  }
}
