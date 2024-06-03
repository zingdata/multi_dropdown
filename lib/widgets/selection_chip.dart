import 'package:flutter/material.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

/// [SelectionChip] is a selected option chip builder.
/// It is used to build the selected option chip.
class SelectionChip<T> extends StatelessWidget {
  final ChipConfig chipConfig;
  final Function(ValueItem<T>) onItemDelete;
  final ValueItem<T> item;

  const SelectionChip({
    Key? key,
    required this.chipConfig,
    required this.item,
    required this.onItemDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final textWidget = Text(
      item.label,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: textTheme.bodyMedium,
    );
    return Container(
      padding: chipConfig.padding,
      decoration: BoxDecoration(
        color: chipConfig.backgroundColor,
        borderRadius: BorderRadius.circular(chipConfig.radius),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(child: textWidget),
          if (chipConfig.canDelete)
            SizedBox(
              height: 24,
              width: 24,
              child: IconButton(
                onPressed: () => onItemDelete(item),
                icon: Icon(
                  Icons.close,
                  size: 16,
                  color: chipConfig.deleteIconColor,
                ),
              ),
            )
        ],
      ),
    );
  }
}
