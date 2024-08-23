import 'package:example/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

import 'zing_icons_widget.dart';

class MultiSelectDropDownWidget<T> extends StatelessWidget {
  const MultiSelectDropDownWidget({
    super.key,
    this.hint,
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
    this.showCommaForSelectedValues = false,
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
    this.mainPadding = const EdgeInsets.only(left: 2),
    this.noOptionWidget,
    this.minHeight,
    this.contentHeight = 28,
    this.height = 38,
    this.searchInputFormatters = const [],
    this.customChild,
  });

  final String? hint;
  final double? minHeight;
  final BoxDecoration? decoration;
  final String? title;
  final TextStyle? titleStyle;
  final List<ValueItem<T>>? options;
  final List<ValueItem<T>>? selectedOptions;
  final String? hintText;
  final TextStyle? hintStyle;
  final SelectionType selectionType;
  final Function(List<ValueItem<T>> selectedOptions, TextEditingController? controller)
      onOptionSelected;

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
  final bool showCommaForSelectedValues;
  final TextStyle? chipTextStyle;
  final TextStyle? optionTextStyle;
  final bool expandedSelectedOptions;
  final double? optionItemHeight;
  final double dropdownHeight;
  final double? optionHorizontalTitleGap;
  final MainAxisAlignment selectedOptionRowAlignment;
  final EdgeInsets? optionsContentPadding;
  final Widget? suffixIcon;
  final EdgeInsets? containerPadding;
  final EdgeInsets mainPadding;
  final Widget? noOptionWidget;
  final double height;
  final double contentHeight;
  final List<TextInputFormatter> searchInputFormatters;
  final Widget? customChild;

  @override
  Widget build(BuildContext context) {
    final outlineBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: BorderSide(color: context.colorTheme.outline),
    );
    final suffixIcon = this.suffixIcon ??
        Icon(
          Icons.keyboard_arrow_down_rounded,
          size: 24,
          color: context.colorTheme.secondary,
        );

    final chipConfig = ChipConfig(
      backgroundColor: context.colorTheme.primaryContainer,
      labelStyle: chipTextStyle ?? context.textTheme.bodyMedium,
      labelPadding: !canDeleteChip ? const EdgeInsets.symmetric(horizontal: 12) : EdgeInsets.zero,
      padding: EdgeInsets.only(left: !canDeleteChip ? 4 : 12, right: 4),
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
      color: context.colorTheme.surface,
      boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(.2), blurRadius: 4),
      ],
    );
    final searchInputDecoration = InputDecoration(
      hintText: hint ?? 'Search here...',
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      border: outlineBorder,
      focusedBorder: outlineBorder,
      errorBorder: outlineBorder,
      enabledBorder: outlineBorder,
      disabledBorder: outlineBorder,
      focusedErrorBorder: outlineBorder,
      hintStyle: context.textTheme.bodyMedium?.copyWith(color: context.colorTheme.secondary),
    );

    return SizedBox(
      height: height,
      child: Center(
        child: networkConfig == null
            ? MultiSelectDropDown<T>(
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
                hintPadding: const EdgeInsets.symmetric(horizontal: 8.0),
                options: options ?? [],
                selectionType: selectionType,
                searchEnabled: searchEnabled,
                suffixIcon: suffixIcon,
                chipConfig: chipConfig,
                dropdownHeight: dropdownHeight,
                showChipInSingleSelectMode: showChipInSingleSelectMode,
                showCommaForSelectedValues: showCommaForSelectedValues,
                showClearIcon: false,
                optionTextStyle: optionTextStyle ?? context.textTheme.bodyLarge,
                selectedOptionIcon: selectedOptionIcon,
                unSelectedOptionIcon: unSelectedOptionIcon,
                searchBoxPadding: const EdgeInsets.all(4),
                searchBoxHeight: 45,
                contentHeight: contentHeight,
                alwaysShowOptionIcon: alwaysShowOptionIcon,
                showSelectedIconOnTrailing: false,
                focusedBorderColor: Colors.transparent,
                dropDownBoxDecoration: dropDownBoxDecoration,
                searchInputDecoration: searchInputDecoration,
                searchKeyboardType: searchKeyboardType,
                searchInputFormatters: searchInputFormatters,
                selectedOptionBackgroundColor: context.colorTheme.primaryContainer,
                selectedOptionShapeBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                onSearch: onSearch,
                selectedOptions: selectedOptions ?? [],
                onShowOverlay: onShowOverlay,
                reachedMaxOptionsScroll: reachedMaxOptionsScroll,
                optionsContentPadding:
                    optionsContentPadding ?? const EdgeInsets.symmetric(horizontal: 4),
                showDropDownOnStart: showDropDownOnStart,
                allowCustomValues: allowCustomValues,
                dropDownWidth: dropDownWidth,
                expandedSelectedOptions: expandedSelectedOptions,
                optionItemHeight: optionItemHeight,
                optionHorizontalTitleGap: optionHorizontalTitleGap,
                selectedOptionRowAlignment: selectedOptionRowAlignment,
                noOptionWidget: noOptionWidget,
                customChild: customChild,
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
                searchInputFormatters: searchInputFormatters,
                suffixIcon: suffixIcon,
                chipConfig: chipConfig,
                dropdownHeight: dropdownHeight,
                showChipInSingleSelectMode: showChipInSingleSelectMode,
                showCommaForSelectedValues: showCommaForSelectedValues,
                showClearIcon: false,
                optionTextStyle: optionTextStyle ?? context.textTheme.bodyLarge,
                selectedOptionIcon: selectedOptionIcon,
                unSelectedOptionIcon: unSelectedOptionIcon,
                searchBoxPadding: const EdgeInsets.all(4),
                searchBoxHeight: 45,
                contentHeight: contentHeight,
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
                noOptionWidget: noOptionWidget,
                customChild: customChild,
              ),
      ),
    );
  }
}
