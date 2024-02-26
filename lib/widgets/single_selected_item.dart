import 'package:flutter/material.dart';

/// [SingleSelectedItem] is a selected item builder.
/// It is used to build the selected item.
class SingleSelectedItem extends StatelessWidget {
  const SingleSelectedItem({
    Key? key,
    required this.label,
    this.textStyle,
    this.icon,
  }) : super(key: key);

  final String label;
  final Widget? icon;
  final TextStyle? textStyle;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (icon != null) ...[
          const SizedBox(width: 10),
          icon!,
        ],
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: icon == null ? 10.0 : 4, right: 10.0),
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textStyle ??
                  TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade700,
                  ),
            ),
          ),
        ),
      ],
    );
  }
}
