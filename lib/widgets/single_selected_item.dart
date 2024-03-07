import 'package:flutter/material.dart';

/// [SingleSelectedItem] is a selected item builder.
/// It is used to build the selected item.
class SingleSelectedItem extends StatelessWidget {
  final String label;
  final TextStyle? labelStyle;
  final Widget? icon;
  final bool showOnlyIcon;
  const SingleSelectedItem({
    Key? key,
    required this.label,
    this.labelStyle,
    this.icon,
    this.showOnlyIcon = false,
  }) : super(key: key);

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
