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
    this.rowAlignment = MainAxisAlignment.start,
  }) : super(key: key);

  final String label;
  final TextStyle? labelStyle;
  final Widget? icon;
  final bool showOnlyIcon;
  final MainAxisAlignment rowAlignment;
  
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
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
