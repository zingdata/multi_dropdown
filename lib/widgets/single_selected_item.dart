import 'package:flutter/material.dart';

/// [SingleSelectedItem] is a selected item builder.
/// It is used to build the selected item.
class SingleSelectedItem extends StatelessWidget {
  const SingleSelectedItem({
    Key? key,
    required this.label,
    required this.labelStyle,
    required this.padding,
    this.icon,
    this.showOnlyIcon = false,
    this.rowAlignment = MainAxisAlignment.start,
  }) : super(key: key);

  final String label;
  final TextStyle? labelStyle;
  final Widget? icon;
  final bool showOnlyIcon;
  final MainAxisAlignment rowAlignment;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final textWidget = Text(
      label,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: labelStyle ??
          TextStyle(
            fontSize: 13,
            color: Colors.grey.shade700,
          ),
    );
    return Padding(
      padding: padding,
      child: Row(
        mainAxisAlignment: rowAlignment,
        children: [
          if (icon != null) icon!,
          if (!showOnlyIcon)
            rowAlignment == MainAxisAlignment.end
                ? Flexible(child: textWidget)
                : Expanded(child: textWidget),
        ],
      ),
    );
  }
}
