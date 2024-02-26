import 'package:flutter/material.dart';

/// [SingleSelectedItem] is a selected item builder.
/// It is used to build the selected item.
class SingleSelectedItem extends StatelessWidget {
  const SingleSelectedItem({
    Key? key,
    required this.label,
    this.textStyle,
  }) : super(key: key);

  final String label;
  final TextStyle? textStyle;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Text(
        label,
        style: textStyle ??
            TextStyle(
              fontSize: 13,
              color: Colors.grey.shade700,
            ),
      ),
    );
  }
}
