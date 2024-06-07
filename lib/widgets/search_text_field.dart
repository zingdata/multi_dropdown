import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    super.key,
    required this.searchController,
    required this.focusNode,
    required this.searchBoxHeight,
    required this.searchBoxPadding,
    required this.searchKeyboardType,
    required this.searchInputFormatters,
    required this.searchInputDecoration,
    required this.onClear,
    required this.onChanged,
    required this.onFieldSubmitted,
    required this.closeOverlay,
    required this.onSelectValue,
    required this.onArrowUp,
    required this.onArrowDown,
  });
  final TextEditingController searchController;
  final double? searchBoxHeight;
  final EdgeInsets? searchBoxPadding;
  final FocusNode focusNode;
  final TextInputType? searchKeyboardType;
  final List<TextInputFormatter> searchInputFormatters;
  final InputDecoration? searchInputDecoration;
  final VoidCallback onClear;
  final ValueChanged<String> onChanged;
  final Function(String)? onFieldSubmitted;
  final VoidCallback closeOverlay;
  final VoidCallback onSelectValue;
  final VoidCallback onArrowUp;
  final VoidCallback onArrowDown;

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: FocusNode(),
      onKeyEvent: (event) {
        if (event is KeyDownEvent &&
            HardwareKeyboard.instance.isLogicalKeyPressed(LogicalKeyboardKey.escape)) {
          closeOverlay();
        }
        if (event.logicalKey == LogicalKeyboardKey.enter) {
          onSelectValue();
        }
        if (event is KeyDownEvent &&
            HardwareKeyboard.instance.isLogicalKeyPressed(LogicalKeyboardKey.arrowDown)) {
          onArrowDown();
        }
        if (event is KeyDownEvent &&
            HardwareKeyboard.instance.isLogicalKeyPressed(LogicalKeyboardKey.arrowUp)) {
          onArrowUp();
        }
      },
      child: Container(
        height: searchBoxHeight,
        padding: searchBoxPadding ?? const EdgeInsets.all(8.0),
        child: Center(
          child: TextFormField(
            controller: searchController,
            focusNode: focusNode,
            keyboardType: searchKeyboardType,
            textInputAction: TextInputAction.done,
            inputFormatters: searchInputFormatters,
            decoration: searchInputDecoration ??
                InputDecoration(
                  fillColor: Colors.grey.shade200,
                  isDense: true,
                  hintText: 'Search',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.grey.shade300,
                      width: 0.8,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 0.8,
                    ),
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: onClear,
                  ),
                ),
            onChanged: onChanged,
            onFieldSubmitted: onFieldSubmitted,
          ),
        ),
      ),
    );
  }
}
