import 'package:example/context_extension.dart';
import 'package:example/zing_icons_widget.dart';
import 'package:flutter/material.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

class MultiSelectDropDownWidget<T> extends StatelessWidget {
  const MultiSelectDropDownWidget({
    super.key,
    this.minHeight,
    this.controller,
    this.decoration,
    this.title,
    this.titleStyle,
    this.hintText,
    this.hintStyle,
    this.options,
    this.selectedOptions,
    this.selectionType = SelectionType.multi,
    required this.onOptionSelected,
    this.networkConfig,
    this.responseParser,
    this.searchEnabled = true,
    this.onSearch,
    this.alwaysShowOptionIcon = true,
    this.canDeleteChip = true,
    this.searchKeyboardType = TextInputType.text,
    this.onShowOverlay,
    this.reachedMaxOptionsScroll,
    this.gettingOptions = false,
    this.showDropDownOnStart = false,
    this.allowCustomValues = false,
    this.dropDownWidth,
    this.showChipInSingleSelectMode = true,
    this.chipTextStyle,
    this.optionTextStyle,
    this.expandedSelectedOptions = true,
    this.optionItemHeight,
    this.dropdownHeight = 300,
    this.optionHorizontalTitleGap,
    this.selectedOptionRowAlignment = MainAxisAlignment.start,
    this.optionsContentPadding,
    this.suffixIcon,
    this.containerPadding,
  });
  final double? minHeight;
  final BoxDecoration? decoration;
  final String? title;
  final TextStyle? titleStyle;
  final List<ValueItem<T>>? options;
  final List<ValueItem<T>>? selectedOptions;
  final String? hintText;
  final TextStyle? hintStyle;
  final SelectionType selectionType;
  final Function(List<ValueItem<T>> selectedOptions) onOptionSelected;

  final NetworkConfig? networkConfig;
  final Future<List<ValueItem<T>>> Function(dynamic)? responseParser;
  final bool searchEnabled;
  final Function(String value, List<ValueItem<T>> searchedOptions)? onSearch;
  final bool alwaysShowOptionIcon;
  final bool canDeleteChip;
  final MultiSelectController<T>? controller;
  final TextInputType? searchKeyboardType;
  final Function(OverlayEntry? overlayEntry)? onShowOverlay;
  final VoidCallback? reachedMaxOptionsScroll;
  final bool gettingOptions;
  final bool showDropDownOnStart;
  final bool allowCustomValues;
  final double? dropDownWidth;
  final bool showChipInSingleSelectMode;
  final TextStyle? chipTextStyle;
  final TextStyle? optionTextStyle;
  final bool expandedSelectedOptions;
  final double? optionItemHeight;
  final double dropdownHeight;
  final double? optionHorizontalTitleGap;
  final MainAxisAlignment selectedOptionRowAlignment;
  final EdgeInsets? optionsContentPadding;
  final Icon? suffixIcon;
  final EdgeInsets? containerPadding;

  @override
  Widget build(BuildContext context) {
    final outlineBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: BorderSide(color: context.colorTheme.outline, width: 1),
    );
    final suffixIcon = this.suffixIcon ??
        Icon(
          Icons.keyboard_arrow_down_rounded,
          size: 24,
          color: context.colorTheme.secondary,
        );

    final chipConfig = ChipConfig(
      wrapType: WrapType.scroll,
      backgroundColor: context.colorTheme.primaryContainer,
      labelStyle: chipTextStyle ?? context.textTheme.bodyMedium,
      labelPadding: !canDeleteChip ? const EdgeInsets.symmetric(horizontal: 12) : EdgeInsets.zero,
      padding: !canDeleteChip
          ? EdgeInsets.zero
          : const EdgeInsets.only(left: 12, top: 0, right: 4, bottom: 0),
      radius: 8,
      spacing: 4,
      canDelete: canDeleteChip,
      deleteIcon:
          canDeleteChip ? Icon(Icons.close, color: context.colorTheme.secondary, size: 20) : null,
      outlineBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
        side: const BorderSide(color: Colors.transparent),
      ),
    );
    final selectedOptionIcon = Image.asset(
      ZingIconsWidget.filterToggleSelected,
      height: 20,
      width: 20,
    );
    final unSelectedOptionIcon = Image.asset(
      ZingIconsWidget.filterToggleUnSelected,
      height: 20,
      width: 20,
    );
    final dropDownBoxDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(6),
      color: context.colorTheme.background,
      boxShadow: [BoxShadow(color: Colors.black.withOpacity(.2), blurRadius: 4)],
    );
    final searchInputDecoration = InputDecoration(
      hintText: 'Search here...',
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      border: outlineBorder,
      focusedBorder: outlineBorder,
      errorBorder: outlineBorder,
      enabledBorder: outlineBorder,
      disabledBorder: outlineBorder,
      focusedErrorBorder: outlineBorder,
      hintStyle: context.textTheme.bodyMedium?.copyWith(
        color: context.colorTheme.secondary,
      ),
    );

    return SizedBox(
      height: 38,
      child: Center(
        child: networkConfig == null
            ? Padding(
                padding: const EdgeInsets.only(left: 2),
                child: MultiSelectDropDown<T>(
                  controller: controller,
                  title: title,
                  titleStyle: titleStyle,
                  inputDecoration: decoration,
                  gettingOptions: gettingOptions,
                  borderColor: Colors.transparent,
                  borderRadius: 6,
                  padding: containerPadding ?? EdgeInsets.zero,
                  onOptionSelected: onOptionSelected,
                  hint: hintText ?? 'select value',
                  hintStyle: hintStyle ??
                      context.textTheme.bodyLarge?.copyWith(color: context.colorTheme.secondary),
                  options: options ?? [],
                  selectionType: selectionType,
                  searchEnabled: searchEnabled,
                  suffixIcon: suffixIcon,
                  chipConfig: chipConfig,
                  dropdownHeight: dropdownHeight,
                  showChipInSingleSelectMode: showChipInSingleSelectMode,
                  showClearIcon: false,
                  optionTextStyle: optionTextStyle ?? context.textTheme.bodyLarge,
                  selectedOptionIcon: selectedOptionIcon,
                  unSelectedOptionIcon: unSelectedOptionIcon,
                  searchBoxPadding: const EdgeInsets.all(4),
                  searchBoxHeight: 45,
                  alwaysShowOptionIcon: alwaysShowOptionIcon,
                  showSelectedIconOnTrailing: false,
                  focusedBorderColor: Colors.transparent,
                  dropDownBoxDecoration: dropDownBoxDecoration,
                  searchInputDecoration: searchInputDecoration,
                  searchKeyboardType: searchKeyboardType,
                  selectedOptionBackgroundColor: context.colorTheme.primaryContainer,
                  selectedOptionShapeBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  onSearch: onSearch,
                  selectedOptions: selectedOptions ?? [],
                  onShowOverlay: onShowOverlay,
                  reachedMaxOptionsScroll: reachedMaxOptionsScroll,
                  optionItemPadding: const EdgeInsets.symmetric(horizontal: 6),
                  optionsContentPadding: optionsContentPadding ??
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
                  showDropDownOnStart: showDropDownOnStart,
                  allowCustomValues: allowCustomValues,
                  dropDownWidth: dropDownWidth,
                  expandedSelectedOptions: expandedSelectedOptions,
                  optionItemHeight: optionItemHeight,
                  optionHorizontalTitleGap: optionHorizontalTitleGap,
                  selectedOptionRowAlignment: selectedOptionRowAlignment,
                ),
              )
            : MultiSelectDropDown<T>.network(
                borderColor: Colors.transparent,
                inputDecoration: decoration,
                title: title,
                titleStyle: titleStyle,
                gettingOptions: gettingOptions,
                borderRadius: 6,
                padding: containerPadding ?? EdgeInsets.zero,
                onOptionSelected: onOptionSelected,
                hint: hintText ?? 'select value',
                hintStyle: hintStyle ??
                    context.textTheme.bodyLarge?.copyWith(
                      color: context.colorTheme.secondary,
                    ),
                networkConfig: networkConfig,
                responseParser: responseParser,
                selectionType: selectionType,
                searchEnabled: searchEnabled,
                suffixIcon: suffixIcon,
                chipConfig: chipConfig,
                dropdownHeight: dropdownHeight,
                showChipInSingleSelectMode: showChipInSingleSelectMode,
                showClearIcon: false,
                optionTextStyle: optionTextStyle ?? context.textTheme.bodyLarge,
                selectedOptionIcon: selectedOptionIcon,
                unSelectedOptionIcon: unSelectedOptionIcon,
                searchBoxPadding: const EdgeInsets.all(4),
                searchBoxHeight: 45,
                alwaysShowOptionIcon: alwaysShowOptionIcon,
                showSelectedIconOnTrailing: false,
                focusedBorderColor: Colors.transparent,
                dropDownBoxDecoration: dropDownBoxDecoration,
                searchInputDecoration: searchInputDecoration,
                searchKeyboardType: searchKeyboardType,
                selectedOptions: selectedOptions ?? [],
                onShowOverlay: onShowOverlay,
                reachedMaxOptionsScroll: reachedMaxOptionsScroll,
                showDropDownOnStart: showDropDownOnStart,
                allowCustomValues: allowCustomValues,
                dropDownWidth: dropDownWidth,
                expandedSelectedOptions: expandedSelectedOptions,
                optionItemHeight: optionItemHeight,
                optionHorizontalTitleGap: optionHorizontalTitleGap,
                selectedOptionRowAlignment: selectedOptionRowAlignment,
              ),
      ),
    );
  }
}
