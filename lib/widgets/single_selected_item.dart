import 'package:flutter/material.dart';

/// [SingleSelectedItem] is a selected item builder.
/// It is used to build the selected item.
class SingleSelectedItem extends StatelessWidget {
  const SingleSelectedItem({
    Key? key,
    required this.label,
    required this.labelStyle,
    this.icon,
    this.showOnlyIcon = false,
    this.textStyle,
  }) : super(key: key);

  final String label;
  final TextStyle? labelStyle;

  final bool showOnlyIcon;
  final Widget? icon;
  final TextStyle? textStyle;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          if (icon != null) icon!,
          if (!showOnlyIcon)
            Expanded(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: labelStyle ??
                    TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade700,
                    ),
              ),
            ),
        ],
      ),
    );
  }
}
