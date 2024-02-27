import 'package:flutter/material.dart';

/// [SingleSelectedItem] is a selected item builder.
/// It is used to build the selected item.
class SingleSelectedItem extends StatelessWidget {
  final String label;
  final TextStyle? labelStyle;
  const SingleSelectedItem({
    Key? key,
    required this.label,
    this.labelStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.fade,
        style: labelStyle ?? TextStyle(
          fontSize: 13,
          color: Colors.grey.shade700,
        ),
      ),
    );
  }
}
