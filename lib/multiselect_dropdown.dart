library multiselect_dropdown;

import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:multi_dropdown/models/network_config.dart';
import 'package:multi_dropdown/widgets/hint_text.dart';
import 'package:multi_dropdown/widgets/selection_chip.dart';
import 'package:multi_dropdown/widgets/single_selected_item.dart';
import 'package:http/http.dart' as http;
import 'package:collection/collection.dart';
import 'models/chip_config.dart';
import 'models/value_item.dart';
import 'enum/app_enums.dart';

export 'enum/app_enums.dart';
export 'models/chip_config.dart';
export 'models/value_item.dart';
export 'models/network_config.dart';

typedef OnOptionSelected<T> = void Function(
    List<ValueItem<T>> selectedOptions, TextEditingController? controller);

class MultiSelectDropDown<T> extends StatefulWidget {
  // selection type of the dropdown
  final SelectionType selectionType;

  final String? title;
  final TextStyle? titleStyle;
  final double minHeight;
  final double contentHeight;

  // Hint
  final String hint;
  final Color? hintColor;
  final double? hintFontSize;
  final TextStyle? hintStyle;
  final EdgeInsets hintPadding;

  // Options
  final List<ValueItem<T>> options;
  final List<ValueItem<T>> selectedOptions;
  final List<ValueItem<T>> disabledOptions;
  final OnOptionSelected<T>? onOptionSelected;

  // selected option
  final Widget? selectedOptionIcon;
  final Widget? unSelectedOptionIcon;
  final Color? selectedOptionTextColor;
  final Color? selectedOptionBackgroundColor;
  final ShapeBorder? selectedOptionShapeBorder;
  final Widget Function(BuildContext, ValueItem<T>)? selectedItemBuilder;
  final bool showSelectedIconOnTrailing;
  final MainAxisAlignment selectedOptionRowAlignment;

  // chip configuration
  final bool showChipInSingleSelectMode;
  final ChipConfig chipConfig;

  // options configuration
  final Color? optionsBackgroundColor;
  final TextStyle? optionTextStyle;
  final Widget? optionSeperator;
  final double dropdownHeight;
  final double? dropDownWidth;
  final Decoration? dropDownBoxDecoration;
  final Widget? optionSeparator;
  final bool alwaysShowOptionIcon;
  final double? optionItemHeight;
  final double? optionHorizontalTitleGap;
  final Widget? noOptionWidget;

  // dropdownfield configuration
  final Color? backgroundColor;
  final Widget? suffixIcon;
  final Icon? clearIcon;
  final Decoration? inputDecoration;
  final double? borderRadius;
  final BorderRadius? radiusGeometry;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final double? borderWidth;
  final double? focusedBorderWidth;
  final EdgeInsets? padding;
  final bool showClearIcon;
  final int? maxItems;
  final bool showDropDownOnStart;

  // network configuration
  final NetworkConfig? networkConfig;
  final Future<List<ValueItem<T>>> Function(dynamic)? responseParser;
  final Widget Function(BuildContext, dynamic)? responseErrorBuilder;

  /// focus node
  final FocusNode? focusNode;

  /// Controller for the dropdown
  /// [controller] is the controller for the dropdown. It can be used to programmatically open and close the dropdown.
  final MultiSelectController<T>? controller;

  /// Enable search
  /// [searchEnabled] is the flag to enable search in dropdown. It is used to show search bar in dropdown.
  final bool searchEnabled;
  final double? searchBoxHeight;
  final EdgeInsets? searchBoxPadding;
  final InputDecoration? searchInputDecoration;
  final TextInputType? searchKeyboardType;
  final Function(String value, List<ValueItem<T>> searchedOptions)? onSearch;
  final VoidCallback? reachedMaxOptionsScroll;
  final Function(OverlayEntry? overlayEntry)? onShowOverlay;
  final bool gettingOptions;
  final EdgeInsets? optionsContentPadding;
  final EdgeInsets optionItemPadding;
  final bool allowCustomValues;
  final List<TextInputFormatter> searchInputFormatters;

  final bool expandedSelectedOptions;

  final Widget? customChild;
  final bool updateState;

  /// [customChild] is a widget if user don't want to show selected value and mostly is container or any custom widget

  /// [updateState] is true by default but if we want to not show the selection option and just want to show options without any selection we can pass updateState as false

  /// MultiSelectDropDown is a widget that allows the user to select multiple options from a list of options. It is a dropdown that allows the user to select multiple options.
  ///
  ///  **Selection Type**
  ///
  ///   [selectionType] is the type of selection that the user can make. The default is [SelectionType.single].
  /// * [SelectionType.single] - allows the user to select only one option.
  /// * [SelectionType.multi] - allows the user to select multiple options.
  ///
  ///  **Options**
  ///
  /// [options] is the list of options that the user can select from. The options need to be of type [ValueItem].
  ///
  /// [selectedOptions] is the list of options that are pre-selected when the widget is first displayed. The options need to be of type [ValueItem].
  ///
  /// [disabledOptions] is the list of options that the user cannot select. The options need to be of type [ValueItem]. If the items in this list are not available in options, will be ignored.
  ///
  /// [onOptionSelected] is the callback that is called when an option is selected or unselected. The callback takes one argument of type `List<ValueItem>`.
  ///
  /// **Selected Option**
  ///
  /// [selectedOptionIcon] is the icon that is used to indicate the selected option.
  ///
  /// [selectedOptionTextColor] is the color of the selected option.
  ///
  /// [selectedOptionBackgroundColor] is the background color of the selected option.
  ///
  /// [selectedItemBuilder] is the builder that is used to build the selected option. If this is not provided, the default builder is used.
  ///
  /// **Chip Configuration**
  ///
  /// [showChipInSingleSelectMode] is used to show the chip in single select mode. The default is false.
  ///
  /// [chipConfig] is the configuration for the chip.
  ///
  /// **Options Configuration**
  ///
  /// [optionsBackgroundColor] is the background color of the options. The default is [Colors.white].
  ///
  /// [optionTextStyle] is the text style of the options.
  ///
  /// [optionSeperator] is the seperator between the options.
  ///
  /// [dropdownHeight] is the height of the dropdown options. The default is 200.
  ///
  ///  **Dropdown Configuration**
  ///
  /// [backgroundColor] is the background color of the dropdown. The default is [Colors.white].
  ///
  /// [suffixIcon] is the icon that is used to indicate the dropdown. The default is [Icons.arrow_drop_down].
  ///
  /// [inputDecoration] is the decoration of the dropdown.
  ///
  /// [dropdownHeight] is the height of the dropdown. The default is 200.
  ///
  ///  **Hint**
  ///
  /// [hint] is the hint text to be displayed when no option is selected.
  ///
  /// [hintColor] is the color of the hint text. The default is [Colors.grey.shade300].
  ///
  /// [hintFontSize] is the font size of the hint text. The default is 14.0.
  ///
  /// [hintStyle] is the style of the hint text.
  ///
  ///  **Example**
  ///
  /// ```dart
  ///  final List<ValueItem> options = [
  ///     ValueItem(label: 'Option 1', value: '1'),
  ///     ValueItem(label: 'Option 2', value: '2'),
  ///     ValueItem(label: 'Option 3', value: '3'),
  ///   ];
  ///
  ///   final List<ValueItem> selectedOptions = [
  ///     ValueItem(label: 'Option 1', value: '1'),
  ///   ];
  ///
  ///   final List<ValueItem> disabledOptions = [
  ///     ValueItem(label: 'Option 2', value: '2'),
  ///   ];
  ///
  ///  MultiSelectDropDown(
  ///    onOptionSelected: (option) {},
  ///    options: const <ValueItem>[
  ///       ValueItem(label: 'Option 1', value: '1'),
  ///       ValueItem(label: 'Option 2', value: '2'),
  ///       ValueItem(label: 'Option 3', value: '3'),
  ///       ValueItem(label: 'Option 4', value: '4'),
  ///       ValueItem(label: 'Option 5', value: '5'),
  ///       ValueItem(label: 'Option 6', value: '6'),
  ///    ],
  ///    selectionType: SelectionType.multi,
  ///    selectedOptions: selectedOptions,
  ///    disabledOptions: disabledOptions,
  ///    onOptionSelected: (List<ValueItem> selectedOptions) {
  ///      debugPrint('onOptionSelected: $option');
  ///    },
  ///    chipConfig: const ChipConfig(wrapType: WrapType.scroll),
  ///    );
  /// ```

  /// [expandedSelectedOptions] is for spacing between dropdown icon and option

  const MultiSelectDropDown({
    Key? key,
    required this.onOptionSelected,
    required this.options,
    this.minHeight = 52,
    this.contentHeight = 28,
    this.title,
    this.titleStyle,
    this.selectedOptionTextColor,
    this.optionSeperator,
    this.chipConfig = const ChipConfig(),
    this.selectionType = SelectionType.multi,
    this.hint = 'Select',
    this.hintColor = Colors.grey,
    this.hintFontSize = 14.0,
    this.hintPadding = const EdgeInsets.symmetric(horizontal: 10.0),
    this.selectedOptions = const [],
    this.disabledOptions = const [],
    this.alwaysShowOptionIcon = false,
    this.optionTextStyle,
    this.selectedOptionIcon = const Icon(Icons.check),
    this.unSelectedOptionIcon = const Icon(Icons.check),
    this.showSelectedIconOnTrailing = true,
    this.selectedOptionBackgroundColor,
    this.selectedOptionShapeBorder,
    this.optionsBackgroundColor,
    this.backgroundColor = Colors.white,
    this.dropdownHeight = 200,
    this.optionItemHeight,
    this.showChipInSingleSelectMode = false,
    this.suffixIcon = const Icon(Icons.arrow_drop_down),
    this.clearIcon = const Icon(Icons.close_outlined, size: 14),
    this.selectedItemBuilder,
    this.optionSeparator,
    this.inputDecoration,
    this.hintStyle,
    this.padding,
    this.focusedBorderColor = Colors.black54,
    this.borderColor = Colors.grey,
    this.borderWidth = 0.4,
    this.focusedBorderWidth = 0.4,
    this.borderRadius = 12.0,
    this.radiusGeometry,
    this.showClearIcon = true,
    this.maxItems,
    this.focusNode,
    this.controller,
    this.searchEnabled = false,
    this.searchBoxHeight,
    this.searchInputDecoration,
    this.searchKeyboardType,
    this.searchBoxPadding,
    this.searchInputFormatters = const [],
    this.onSearch,
    this.dropDownBoxDecoration,
    this.showDropDownOnStart = false,
    this.reachedMaxOptionsScroll,
    this.gettingOptions = false,
    this.onShowOverlay,
    this.optionItemPadding = const EdgeInsets.symmetric(horizontal: 6),
    this.optionsContentPadding,
    this.allowCustomValues = false,
    this.dropDownWidth,
    this.expandedSelectedOptions = true,
    this.optionHorizontalTitleGap,
    this.selectedOptionRowAlignment = MainAxisAlignment.start,
    this.noOptionWidget,
    this.customChild,
    this.updateState = true,
  })  : networkConfig = null,
        responseParser = null,
        responseErrorBuilder = null,
        super(key: key);

  /// Constructor for MultiSelectDropDown that fetches the options from a network call.
  /// [networkConfig] is the configuration for the network call.
  /// [responseParser] is the parser that is used to parse the response from the network call.
  /// [responseErrorBuilder] is the builder that is used to build the error widget when the network call fails.

  const MultiSelectDropDown.network({
    Key? key,
    required this.networkConfig,
    required this.responseParser,
    this.minHeight = 52,
    this.contentHeight = 28,
    this.title,
    this.titleStyle,
    this.responseErrorBuilder,
    required this.onOptionSelected,
    this.selectedOptionTextColor,
    this.optionSeperator,
    this.chipConfig = const ChipConfig(),
    this.selectionType = SelectionType.multi,
    this.hint = 'Select',
    this.hintColor = Colors.grey,
    this.hintFontSize = 14.0,
    this.hintPadding = const EdgeInsets.symmetric(horizontal: 10.0),
    this.selectedOptions = const [],
    this.disabledOptions = const [],
    this.alwaysShowOptionIcon = false,
    this.optionTextStyle,
    this.selectedOptionIcon = const Icon(Icons.check),
    this.unSelectedOptionIcon = const Icon(Icons.check),
    this.showSelectedIconOnTrailing = true,
    this.selectedOptionBackgroundColor,
    this.selectedOptionShapeBorder,
    this.optionsBackgroundColor,
    this.backgroundColor = Colors.white,
    this.dropdownHeight = 200,
    this.optionItemHeight,
    this.showChipInSingleSelectMode = false,
    this.suffixIcon = const Icon(Icons.arrow_drop_down),
    this.clearIcon = const Icon(Icons.close_outlined, size: 14),
    this.selectedItemBuilder,
    this.optionSeparator,
    this.inputDecoration,
    this.hintStyle,
    this.padding,
    this.borderColor = Colors.grey,
    this.focusedBorderColor = Colors.black54,
    this.borderWidth = 0.4,
    this.focusedBorderWidth = 0.4,
    this.borderRadius = 12.0,
    this.radiusGeometry,
    this.showClearIcon = true,
    this.maxItems,
    this.focusNode,
    this.controller,
    this.searchEnabled = false,
    this.searchBoxHeight,
    this.searchInputDecoration,
    this.searchKeyboardType,
    this.searchBoxPadding,
    this.onSearch,
    this.searchInputFormatters = const [],
    this.dropDownBoxDecoration,
    this.showDropDownOnStart = false,
    this.reachedMaxOptionsScroll,
    this.onShowOverlay,
    this.gettingOptions = false,
    this.optionItemPadding = const EdgeInsets.symmetric(horizontal: 6),
    this.optionsContentPadding,
    this.allowCustomValues = false,
    this.dropDownWidth,
    this.expandedSelectedOptions = true,
    this.optionHorizontalTitleGap,
    this.selectedOptionRowAlignment = MainAxisAlignment.start,
    this.noOptionWidget,
    this.customChild,
    this.updateState = true,
  })  : options = const [],
        super(key: key);

  @override
  State<MultiSelectDropDown<T>> createState() => _MultiSelectDropDownState<T>();
}

class _MultiSelectDropDownState<T> extends State<MultiSelectDropDown<T>> {
  /// Options list that is used to display the options.
  final List<ValueItem<T>> _options = [];

  /// Selected options list that is used to display the selected options.
  final List<ValueItem<T>> _selectedOptions = [];

  /// Disabled options list that is used to display the disabled options.
  final List<ValueItem<T>> _disabledOptions = [];

  /// The controller for the dropdown.
  OverlayState? _overlayState;
  OverlayEntry? _overlayEntry;
  bool _selectionMode = false;
  bool _isOverlayVisible = false;
  late final FocusNode _focusNode;
  final LayerLink _layerLink = LayerLink();

  /// Response from the network call.
  dynamic _responseBody;

  /// value notifier that is used for controller.
  MultiSelectController<T>? _controller;

  /// search field focus node
  FocusNode? _searchFocusNode;

  final _chipScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    if (widget.controller != null) {
      _controller = widget.controller;
    }
    _setupOptions();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initialize();
    });
  }

  /// Initializes the options, selected options and disabled options.
  /// If the options are fetched from the network, then the network call is made.
  /// If the options are passed as a parameter, then the options are initialized.
  void _setupOptions() async {
    if (!mounted) return;
    if (widget.networkConfig?.url != null) {
      await _fetchNetwork();
    } else {
      _options.addAll(widget.options);
    }
    _addOptions();
  }

  void _initialize() async {
    _overlayState ??= Overlay.of(context);
    _focusNode.addListener(_handleFocusChange);

    if (widget.searchEnabled) {
      _searchFocusNode = FocusNode();
      _searchFocusNode!.addListener(_handleFocusChange);
    }
    if (widget.showDropDownOnStart) {
      Future.delayed(const Duration(milliseconds: 400)).then((value) {
        if (mounted) {
          _focusNode.requestFocus();
          _searchFocusNode?.requestFocus();
        }
      });
    }
  }

  /// Adds the selected options and disabled options to the options list.
  void _addOptions() {
    if (mounted) {
      setState(() {
        _selectedOptions.addAll(widget.selectedOptions);
        _disabledOptions.addAll(widget.disabledOptions);
      });
    }

    if (_controller != null) {
      _controller!.setOptions(_options);
      _controller!.setSelectedOptions(_selectedOptions);
      _controller!.setDisabledOptions(_disabledOptions);

      _controller!.addListener(_handleControllerChange);
    }
  }

  /// Handles the focus change to show/hide the dropdown.
  _handleFocusChange() {
    Future.delayed(const Duration(milliseconds: 100)).then((value) {
      if (_focusNode.hasFocus && mounted && !_isOverlayVisible) {
        _isOverlayVisible = true;
        _overlayEntry = _responseBody != null && widget.networkConfig != null
            ? _buildNetworkErrorOverlayEntry()
            : _buildOverlayEntry();
        Overlay.of(context).insert(_overlayEntry!);
        if (widget.onShowOverlay != null) widget.onShowOverlay!(_overlayEntry!);
        _searchFocusNode?.requestFocus();
        return;
      }

      //   if ((_searchFocusNode == null || _searchFocusNode?.hasFocus == false) &&
      //       _overlayEntry != null) {
      //     _overlayEntry?.remove();
      //     if (widget.onShowOverlay != null) widget.onShowOverlay!(null);
      //   }

      if (mounted) {
        setState(() {
          _selectionMode = _focusNode.hasFocus || _searchFocusNode?.hasFocus == true;
        });
      }

      if (_controller != null) {
        _controller!.value._isDropdownOpen =
            _focusNode.hasFocus || _searchFocusNode?.hasFocus == true;
      }
    });
  }

  /// Handles the widget rebuild when the options are changed externally.
  @override
  void didUpdateWidget(covariant MultiSelectDropDown<T> oldWidget) {
    bool needUpdate = false;
    // If the options are changed externally, then the options are updated.
    if (listEquals(widget.options, oldWidget.options) == false) {
      _options.clear();
      _options.addAll(widget.options);

      // If the controller is not null, then the options are updated in the controller.
      if (_controller != null) {
        _controller!.setOptions(_options);
      }
      needUpdate = true;
    }

    // If the selected options are changed externally, then the selected options are updated.
    if (listEquals(widget.selectedOptions, oldWidget.selectedOptions) == false) {
      _selectedOptions.clear();
      _selectedOptions.addAll(widget.selectedOptions);

      // If the controller is not null, then the selected options are updated in the controller.
      if (_controller != null) {
        _controller!.setSelectedOptions(_selectedOptions);
      }
      needUpdate = true;
    }

    // If the disabled options are changed externally, then the disabled options are updated.
    if (listEquals(widget.disabledOptions, oldWidget.disabledOptions) == false) {
      _disabledOptions.clear();
      _disabledOptions.addAll(widget.disabledOptions);

      // If the controller is not null, then the disabled options are updated in the controller.
      if (_controller != null) {
        _controller!.setDisabledOptions(_disabledOptions);
      }
      needUpdate = true;
    }
    if (widget.gettingOptions != oldWidget.gettingOptions) {
      needUpdate = true;
    }
    if (needUpdate) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() {});
          _overlayEntry?.markNeedsBuild();
        }
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  /// Calculate offset size for dropdown.
  ({
    Size size,
    bool heightIsGreater,
    double leftAvailableSpace,
    double rightAvailableSpace,
  }) _calculateOffsetSize() {
    RenderBox? renderBox = context.findRenderObject() as RenderBox?;

    var size = renderBox?.size ?? Size.zero;
    var offset = renderBox?.localToGlobal(Offset.zero) ?? Offset.zero;

    final availableHeight = MediaQuery.of(context).size.height - offset.dy;
    final leftAvailableSpace = offset.dx;
    final rightAvailableSpace = MediaQuery.of(context).size.width -
        leftAvailableSpace -
        (widget.dropDownWidth ?? size.width);

    return (
      size: size,
      heightIsGreater: availableHeight < widget.dropdownHeight,
      leftAvailableSpace: leftAvailableSpace,
      rightAvailableSpace: rightAvailableSpace,
    );
  }

  @override
  Widget build(BuildContext context) {
    final row = SizedBox(
      height: widget.contentHeight,
      child: Row(
        children: [
          Expanded(
            child: _getContainerContent(),
          ),
          if (widget.showClearIcon && _anyItemSelected) ...[
            const SizedBox(width: 4),
            InkWell(
              onTap: () => clear(),
              child: const Icon(
                Icons.close_outlined,
                size: 20,
              ),
            ),
            const SizedBox(width: 4)
          ],
          if (!_selectionMode)
            AnimatedRotation(
              turns: _selectionMode ? 0.5 : 0,
              duration: const Duration(milliseconds: 200),
              child: widget.suffixIcon,
            ),
        ],
      ),
    );
    return CompositedTransformTarget(
      link: _layerLink,
      child: Focus(
        canRequestFocus: true,
        skipTraversal: true,
        focusNode: _focusNode,
        child: InkWell(
          splashColor: null,
          splashFactory: null,
          borderRadius: widget.radiusGeometry ?? BorderRadius.circular(widget.borderRadius ?? 12.0),
          onTap: () {
            _toggleFocus();
          },
          child: widget.customChild ??
              Container(
                constraints: BoxConstraints(
                  minWidth: MediaQuery.of(context).size.width,
                  minHeight: widget.minHeight,
                ),
                padding: _getContainerPadding(),
                decoration: _getContainerDecoration(),
                child: widget.title != null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  widget.title!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: widget.titleStyle,
                                ),
                              ),
                            ),
                          ),
                          row,
                        ],
                      )
                    : row,
              ),
        ),
      ),
    );
  }

  /// Container Content for the dropdown.
  Widget _getContainerContent() {
    if (_selectedOptions.isEmpty) {
      return HintText(
        hintText: widget.hint,
        hintColor: widget.hintColor,
        hintStyle: widget.hintStyle,
        padding: widget.hintPadding,
      );
    }

    if (widget.selectionType == SelectionType.single && !widget.showChipInSingleSelectMode) {
      return SingleSelectedItem(
        label: _selectedOptions.first.label,
        labelStyle: widget.chipConfig.labelStyle,
        icon: _selectedOptions.first.icon,
        showOnlyIcon: _selectedOptions.first.showOnlyIcon,
        rowAlignment: widget.selectedOptionRowAlignment,
      );
    }

    return _buildSelectedItems();
  }

  /// return true if any item is selected.
  bool get _anyItemSelected => _selectedOptions.isNotEmpty;

  /// Container decoration for the dropdown.
  Decoration _getContainerDecoration() {
    return widget.inputDecoration ??
        BoxDecoration(
          color: widget.backgroundColor ?? Colors.white,
          borderRadius: widget.radiusGeometry ?? BorderRadius.circular(widget.borderRadius ?? 12.0),
          border: _selectionMode
              ? Border.all(
                  color: widget.focusedBorderColor ?? Colors.grey,
                  width: widget.focusedBorderWidth ?? 0.4,
                )
              : Border.all(
                  color: widget.borderColor ?? Colors.grey,
                  width: widget.borderWidth ?? 0.4,
                ),
        );
  }

  /// Dispose the focus node and overlay entry.
  @override
  void dispose() {
    try {
      _isOverlayVisible = false;
      if (_overlayEntry?.mounted == true) {
        if (_overlayState != null && _overlayEntry != null && _overlayEntry!.mounted) {
          _overlayEntry?.remove();
        }
        _overlayEntry = null;
        _overlayState?.dispose();
      }
      _focusNode.dispose();
      if (_controller != null) {
        _controller!.dispose();
      }

      // ignore: empty_catches
    } catch (e) {
      if (widget.onShowOverlay != null) widget.onShowOverlay!(null);
    }

    super.dispose();
  }

  /// Build the selected items for the dropdown.
  Widget _buildSelectedItems() {
    if (widget.chipConfig.wrapType == WrapType.scroll) {
      return ListView.separated(
        controller: _chipScrollController,
        separatorBuilder: (context, index) => _getChipSeparator(widget.chipConfig),
        scrollDirection: Axis.horizontal,
        itemCount: _selectedOptions.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final option = _selectedOptions[index];
          if (widget.selectedItemBuilder != null) {
            return widget.selectedItemBuilder!(context, option);
          }
          return _buildChip(option, widget.chipConfig);
        },
      );
    }
    return Wrap(
      spacing: widget.chipConfig.spacing,
      runSpacing: widget.chipConfig.runSpacing,
      children: mapIndexed(_selectedOptions, (index, item) {
        if (widget.selectedItemBuilder != null) {
          return widget.selectedItemBuilder!(context, _selectedOptions[index]);
        }
        return _buildChip(_selectedOptions[index], widget.chipConfig);
      }).toList(),
    );
  }

  /// Util method to map with index.
  Iterable<E> mapIndexed<E, F>(Iterable<F> items, E Function(int index, F item) f) sync* {
    var index = 0;

    for (final item in items) {
      yield f(index, item);
      index = index + 1;
    }
  }

  /// Get the chip separator.
  Widget _getChipSeparator(ChipConfig chipConfig) {
    if (chipConfig.separator != null) {
      return chipConfig.separator!;
    }

    return SizedBox(
      width: chipConfig.spacing,
    );
  }

  /// Handle the focus change on tap outside of the dropdown.
  void _onOutSideTap() {
    try {
      _isOverlayVisible = false;
      if (_searchFocusNode != null) {
        _searchFocusNode!.unfocus();
      }
      _focusNode.unfocus();
      _overlayEntry?.remove();
      if (widget.onShowOverlay != null) widget.onShowOverlay!(null);
    } catch (e) {
      if (widget.onShowOverlay != null) widget.onShowOverlay!(null);
    }
  }

  /// Build the selected item chip.
  Widget _buildChip(ValueItem<T> item, ChipConfig chipConfig) {
    return SelectionChip<T>(
      item: item,
      chipConfig: chipConfig,
      onItemDelete: (removedItem) {
        if (chipConfig.canDelete) {
          if (_controller != null) {
            _controller!.clearSelection(removedItem);
          } else {
            if (mounted) {
              setState(() {
                _selectedOptions.remove(removedItem);
              });
            }
            widget.onOptionSelected?.call(_selectedOptions, null);
          }
          if (_focusNode.hasFocus) _focusNode.unfocus();
        }
      },
    );
  }

  /// Method to toggle the focus of the dropdown.
  void _toggleFocus() {
    if (_focusNode.hasFocus) {
      _focusNode.unfocus();
    } else {
      _focusNode.requestFocus();
    }
  }

  /// Get the selectedItem icon for the dropdown
  Widget? _getSelectedIcon(
    bool isSelected,
    Color primaryColor,
    Widget? optionIcon,
    bool forDropDown,
  ) {
    if (!widget.alwaysShowOptionIcon && forDropDown) {
      return null;
    }
    if (optionIcon != null) {
      return optionIcon;
    }
    if (!forDropDown) {
      return null;
    }
    if (isSelected) {
      return widget.selectedOptionIcon ??
          Icon(
            Icons.check,
            color: primaryColor,
          );
    }

    final Widget icon = (isSelected ? widget.selectedOptionIcon : widget.unSelectedOptionIcon) ??
        Icon(
          Icons.check,
          color: widget.optionTextStyle?.color ?? Colors.grey,
        );

    return icon;
  }

  /// Create the overlay entry for the dropdown.
  OverlayEntry _buildOverlayEntry() {
    // Calculate the offset and the size of the dropdown button
    final values = _calculateOffsetSize();
    // Get the size from the first item in the values list
    final size = values.size;
    // Get the showOnTop value from the second item in the values list
    final showOnTop = values.heightIsGreater;

    final compositedTransformFollowerOffset =
        widget.dropDownWidth == null || values.rightAvailableSpace > widget.dropDownWidth!
            ? Offset.zero
            : Offset(
                0 -
                    (values.leftAvailableSpace < 0
                        ? values.leftAvailableSpace - 10
                        : values.rightAvailableSpace < 0
                            ? -values.rightAvailableSpace + 10
                            : 0),
                4,
              );

    final searchController = TextEditingController();

    // Get the visual density of the theme
    // final visualDensity = Theme.of(context).visualDensity;

    // Calculate the height of the tile
    // final tileHeight = 48.0 + visualDensity.vertical;
    // Calculate the current height of the dropdown button
    // final currentHeight = tileHeight * _options.length;

    // Check if the dropdown height is less than the current height and greater than 0
    // final bool isScrollable =
    //     widget.dropdownHeight < currentHeight && widget.dropdownHeight > 0;
    // Calculate the offset in the Y direction
    // final _offsetY = showOnTop
    //     ? isScrollable
    //         ? -widget.dropdownHeight - 5
    //         : -currentHeight - 5
    //     : size.height + 5;

    return OverlayEntry(builder: (context) {
      List<ValueItem<T>> options = _options;
      List<ValueItem<T>> selectedOptions = [..._selectedOptions];
      final _scrollBarController = ScrollController();

      return StatefulBuilder(builder: ((context, dropdownState) {
        return Stack(
          children: [
            Positioned.fill(
                child: GestureDetector(
              onTap: _onOutSideTap,
              child: Container(
                color: Colors.transparent,
              ),
            )),
            CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: true,
              targetAnchor: showOnTop ? Alignment.topLeft : Alignment.bottomLeft,
              followerAnchor: showOnTop ? Alignment.bottomLeft : Alignment.topLeft,
              offset: compositedTransformFollowerOffset,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: widget.dropDownWidth ?? size.width,
                    maxHeight: widget.dropdownHeight,
                  ),
                  decoration: widget.dropDownBoxDecoration,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.searchEnabled) ...[
                        Container(
                          height: widget.searchBoxHeight,
                          padding: widget.searchBoxPadding ?? const EdgeInsets.all(8.0),
                          child: Center(
                            child: TextFormField(
                              controller: searchController,
                              focusNode: _searchFocusNode,
                              keyboardType: widget.searchKeyboardType,
                              textInputAction: TextInputAction.done,
                              inputFormatters: widget.searchInputFormatters,
                              decoration: widget.searchInputDecoration ??
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
                                      onPressed: () {
                                        searchController.clear();
                                        dropdownState(() {
                                          options = _options;
                                        });
                                      },
                                    ),
                                  ),
                              onChanged: (value) {
                                dropdownState(() {
                                  options = _options
                                      .where((element) =>
                                          element.label.toLowerCase().contains(value.toLowerCase()))
                                      .toList();
                                  if (widget.onSearch != null) widget.onSearch!(value, options);
                                });
                              },
                              onFieldSubmitted: widget.allowCustomValues
                                  ? (value) {
                                      _onDropDownOptionTap(
                                        searchController,
                                        ValueItem<T>(label: value, value: value as T),
                                        false,
                                        dropdownState,
                                        selectedOptions,
                                      );
                                    }
                                  : null,
                            ),
                          ),
                        ),
                        const Divider(height: 1),
                      ],
                      Flexible(
                        child: widget.gettingOptions && options.isEmpty
                            ? Align(
                                alignment: Alignment.center,
                                child: SizedBox(
                                  height: 15,
                                  width: 15,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              )
                            : options.isEmpty
                                ? Center(
                                    child: widget.noOptionWidget ??
                                        Text(
                                          'No option to show',
                                          style: Theme.of(context).textTheme.bodyMedium,
                                        ),
                                  )
                                : MediaQuery.removePadding(
                                    context: context,
                                    removeTop: true,
                                    child: NotificationListener<ScrollEndNotification>(
                                      onNotification: (scrollEnd) {
                                        final metrics = scrollEnd.metrics;
                                        if (metrics.atEdge &&
                                            widget.reachedMaxOptionsScroll != null) {
                                          bool isTop = metrics.pixels == 0;
                                          if (!isTop) {
                                            widget.reachedMaxOptionsScroll!();
                                          }
                                        }
                                        return true;
                                      },
                                      child: Scrollbar(
                                        interactive: true,
                                        thumbVisibility: true,
                                        controller: _scrollBarController,
                                        child: ListView.separated(
                                          controller: _scrollBarController,
                                          separatorBuilder: (context, index) {
                                            return widget.optionSeparator ??
                                                const SizedBox.shrink();
                                          },
                                          padding: const EdgeInsets.symmetric(vertical: 8),
                                          itemCount: options.length,
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            final option = options[index];
                                            final isSelected = selectedOptions.firstWhereOrNull(
                                                  (element) => element.label == option.label,
                                                ) !=
                                                null;
                                            final primaryColor = Theme.of(context).primaryColor;
                                            return Padding(
                                              padding: widget.optionItemPadding,
                                              child: Material(
                                                color: Colors.transparent,
                                                borderRadius: BorderRadius.circular(6),
                                                child: _buildOption(
                                                  searchController,
                                                  option,
                                                  primaryColor,
                                                  isSelected,
                                                  dropdownState,
                                                  selectedOptions,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                      ),
                      if (options.isNotEmpty && widget.gettingOptions) ...[
                        Align(
                          alignment: Alignment.topCenter,
                          child: SizedBox(
                            height: 10,
                            width: 10,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                      ]
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }));
    });
  }

  void _onDropDownOptionTap(
    TextEditingController searchController,
    ValueItem<T> option,
    bool isSelected,
    StateSetter dropdownState,
    selectedOptions,
  ) {
    if (widget.selectionType == SelectionType.multi) {
      if (isSelected) {
        dropdownState(() {
          selectedOptions.remove(option);
        });
        if (mounted) {
          setState(() {
            _selectedOptions.remove(option);
          });
        }
      } else {
        final bool hasReachMax =
            widget.maxItems == null ? false : (_selectedOptions.length + 1) > widget.maxItems!;
        if (hasReachMax) return;

        dropdownState(() {
          selectedOptions.add(option);
        });
        if (mounted) {
          setState(() {
            _selectedOptions.add(option);
          });
        }
      }
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (widget.chipConfig.wrapType == WrapType.scroll &&
            _chipScrollController.positions.isNotEmpty) {
          _chipScrollController.animateTo(_chipScrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 300), curve: Curves.easeInToLinear);
        }
      });
    } else {
      if (widget.updateState) {
        dropdownState(() {
          selectedOptions.clear();
          selectedOptions.add(option);
        });
        if (mounted) {
          setState(() {
            _selectedOptions.clear();
            _selectedOptions.add(option);
          });
        }
      }

      _onOutSideTap();
    }

    if (_controller != null) {
      _controller!.value._selectedOptions.clear();
      _controller!.value._selectedOptions.addAll(_selectedOptions);
    }

    widget.onOptionSelected?.call(_selectedOptions, searchController);
  }

  Widget _buildOption(
    TextEditingController searchController,
    ValueItem<T> option,
    Color primaryColor,
    bool isSelected,
    StateSetter dropdownState,
    List<ValueItem<T>> selectedOptions,
  ) {
    return SizedBox(
      height: widget.optionItemHeight,
      child: ListTile(
        title: option.showOnlyIcon
            ? null
            : Text(
                option.label,
                style: widget.optionTextStyle ??
                    TextStyle(
                      fontSize: widget.hintFontSize,
                    ),
              ),
        horizontalTitleGap: widget.optionHorizontalTitleGap,
        selectedColor: widget.selectedOptionTextColor ?? primaryColor,
        selected: isSelected,
        autofocus: true,
        contentPadding: widget.optionsContentPadding,
        dense: true,
        tileColor: widget.optionsBackgroundColor ?? Colors.white,
        selectedTileColor: widget.alwaysShowOptionIcon && widget.options.firstOrNull?.icon == null
            ? Colors.transparent
            : widget.selectedOptionBackgroundColor ?? Colors.grey.shade200,
        shape: widget.selectedOptionShapeBorder,
        enabled: !(_disabledOptions.firstWhereOrNull((element) => element.label == option.label) !=
            null),
        onTap: () {
          _onDropDownOptionTap(
              searchController, option, isSelected, dropdownState, selectedOptions);
        },
        trailing: widget.showSelectedIconOnTrailing || option.trailingIcon != null
            ? _getSelectedIcon(
                isSelected,
                primaryColor,
                option.trailingIcon ?? option.icon,
                true,
              )
            : null,
        leading: !widget.showSelectedIconOnTrailing
            ? _getSelectedIcon(
                isSelected,
                primaryColor,
                option.icon,
                true,
              )
            : null,
      ),
    );
  }

  /// Make a request to the provided url.
  /// The response then is parsed to a list of ValueItem objects.
  Future<void> _fetchNetwork() async {
    final result = await _performNetworkRequest();
    http.get(Uri.parse(widget.networkConfig!.url));
    if (result.statusCode == 200) {
      final data = json.decode(result.body);
      final List<ValueItem<T>> parsedOptions = await widget.responseParser!(data);
      _responseBody = null;
      _options.addAll(parsedOptions);
    } else {
      _responseBody = result.body;
    }
  }

  /// Perform the network request according to the provided configuration.
  Future<Response> _performNetworkRequest() async {
    switch (widget.networkConfig!.method) {
      case RequestMethod.get:
        return await http.get(
          Uri.parse(widget.networkConfig!.url),
          headers: widget.networkConfig!.headers,
        );
      case RequestMethod.post:
        return await http.post(
          Uri.parse(widget.networkConfig!.url),
          body: widget.networkConfig!.body,
          headers: widget.networkConfig!.headers,
        );
      case RequestMethod.put:
        return await http.put(
          Uri.parse(widget.networkConfig!.url),
          body: widget.networkConfig!.body,
          headers: widget.networkConfig!.headers,
        );
      case RequestMethod.patch:
        return await http.patch(
          Uri.parse(widget.networkConfig!.url),
          body: widget.networkConfig!.body,
          headers: widget.networkConfig!.headers,
        );
      case RequestMethod.delete:
        return await http.delete(
          Uri.parse(widget.networkConfig!.url),
          headers: widget.networkConfig!.headers,
        );
      default:
        return await http.get(
          Uri.parse(widget.networkConfig!.url),
          headers: widget.networkConfig!.headers,
        );
    }
  }

  /// Builds overlay entry for showing error when fetching data from network fails.
  OverlayEntry _buildNetworkErrorOverlayEntry() {
    final values = _calculateOffsetSize();
    final size = values.size;
    final showOnTop = values.heightIsGreater;

    // final offsetY = showOnTop ? -(size.height + 5) : size.height + 5;

    return OverlayEntry(builder: (context) {
      return StatefulBuilder(builder: ((context, dropdownState) {
        return Stack(
          children: [
            Positioned.fill(
                child: GestureDetector(
              onTap: _onOutSideTap,
              child: Container(
                color: Colors.transparent,
              ),
            )),
            CompositedTransformFollower(
                link: _layerLink,
                targetAnchor: showOnTop ? Alignment.topLeft : Alignment.bottomLeft,
                followerAnchor: showOnTop ? Alignment.bottomLeft : Alignment.topLeft,
                child: Material(
                    elevation: 4,
                    child: Container(
                        width: size.width,
                        constraints: BoxConstraints.loose(Size(size.width, widget.dropdownHeight)),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            widget.responseErrorBuilder != null
                                ? widget.responseErrorBuilder!(context, _responseBody)
                                : Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text('Error fetching data: $_responseBody'),
                                  ),
                          ],
                        ))))
          ],
        );
      }));
    });
  }

  /// Clear the selected options.
  /// [MultiSelectController] is used to clear the selected options.
  void clear() {
    if (_controller != null) {
      _controller!.clearAllSelection();
    } else {
      if (mounted) {
        setState(() {
          _selectedOptions.clear();
        });
      }

      widget.onOptionSelected?.call(_selectedOptions, null);
    }
    if (_focusNode.hasFocus) _focusNode.unfocus();
  }

  /// handle the controller change.
  void _handleControllerChange() {
    // if the controller is null, return.
    if (_controller == null) return;

    // if current disabled options are not equal to the controller's disabled options, update the state.
    if (_disabledOptions != _controller!.value._disabledOptions) {
      if (mounted) {
        setState(() {
          _disabledOptions.clear();
          _disabledOptions.addAll(_controller!.value._disabledOptions);
        });
      }
    }

    // if current options are not equal to the controller's options, update the state.
    if (_options != _controller!.value._options) {
      if (mounted) {
        setState(() {
          _options.clear();
          _options.addAll(_controller!.value._options);
        });
      }
    }

    // if current selected options are not equal to the controller's selected options, update the state.
    if (_selectedOptions != _controller!.value._selectedOptions) {
      if (mounted) {
        setState(() {
          _selectedOptions.clear();
          _selectedOptions.addAll(_controller!.value._selectedOptions);
        });
      }
      widget.onOptionSelected?.call(_selectedOptions, null);
    }

    if (_selectionMode != _controller!.value._isDropdownOpen) {
      if (_controller!.value._isDropdownOpen) {
        _focusNode.requestFocus();
      } else {
        _focusNode.unfocus();
      }
    }
  }

  // get the container padding.
  EdgeInsetsGeometry _getContainerPadding() {
    if (widget.padding != null) {
      return widget.padding!;
    }
    return widget.selectionType == SelectionType.single
        ? const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0)
        : const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0);
  }
}

/// MultiSelect Controller class.
/// This class is used to control the state of the MultiSelectDropdown widget.
/// This is just base class. The implementation of this class is in the MultiSelectController class.
/// The implementation of this class is hidden from the user.
class _MultiSelectController<T> {
  final List<ValueItem<T>> _disabledOptions = [];
  final List<ValueItem<T>> _options = [];
  final List<ValueItem<T>> _selectedOptions = [];
  bool _isDropdownOpen = false;
}

/// implementation of the MultiSelectController class.
class MultiSelectController<T> extends ValueNotifier<_MultiSelectController<T>> {
  MultiSelectController() : super(_MultiSelectController());

  /// Clear the selected options.
  /// [MultiSelectController] is used to clear the selected options.
  void clearAllSelection() {
    value._selectedOptions.clear();
    notifyListeners();
  }

  /// clear specific selected option
  /// [MultiSelectController] is used to clear specific selected option.
  void clearSelection(ValueItem<T> option) {
    if (value._selectedOptions.firstWhereOrNull((element) => element.label == option.label) ==
        null) {
      return;
    }

    if (value._disabledOptions.firstWhereOrNull((element) => element.label == option.label) !=
        null) {
      throw Exception('Cannot clear selection of a disabled option');
    }

    if (value._options.firstWhereOrNull((element) => element.label == option.label) == null) {
      throw Exception('Cannot clear selection of an option that is not in the options list');
    }

    value._selectedOptions.remove(option);
    notifyListeners();
  }

  /// select the options
  /// [MultiSelectController] is used to select the options.
  void setSelectedOptions(List<ValueItem<T>> options) {
    if (options.any((option) =>
        value._disabledOptions.firstWhereOrNull((element) => element.label == option.label) !=
        null)) {
      throw Exception('Cannot select disabled options');
    }

    if (options.any((element) =>
        value._options.firstWhereOrNull((option) => element.label == option.label) == null)) {
      throw Exception('Cannot select options that are not in the options list');
    }

    value._selectedOptions.clear();
    value._selectedOptions.addAll(options);
    notifyListeners();
  }

  /// add selected option
  /// [MultiSelectController] is used to add selected option.
  void addSelectedOption(ValueItem<T> option) {
    if (value._disabledOptions.firstWhereOrNull((element) => element.label == option.label) !=
        null) {
      throw Exception('Cannot select disabled option');
    }

    if (value._options.firstWhereOrNull((element) => element.label == option.label) == null) {
      throw Exception('Cannot select option that is not in the options list');
    }

    value._selectedOptions.add(option);
    notifyListeners();
  }

  /// set disabled options
  /// [MultiSelectController] is used to set disabled options.
  void setDisabledOptions(List<ValueItem<T>> disabledOptions) {
    if (disabledOptions.any((element) =>
        value._options.firstWhereOrNull((option) => element.label == option.label) == null)) {
      throw Exception('Cannot disable options that are not in the options list');
    }

    value._disabledOptions.clear();
    value._disabledOptions.addAll(disabledOptions);
    notifyListeners();
  }

  /// setDisabledOption method
  /// [MultiSelectController] is used to set disabled option.
  void setDisabledOption(ValueItem<T> disabledOption) {
    if (value._options.firstWhereOrNull((element) => element.label == disabledOption.label) ==
        null) {
      throw Exception('Cannot disable option that is not in the options list');
    }

    value._disabledOptions.add(disabledOption);
    notifyListeners();
  }

  /// set options
  /// [MultiSelectController] is used to set options.
  void setOptions(List<ValueItem<T>> options) {
    value._options.clear();
    value._options.addAll(options);
    notifyListeners();
  }

  /// get disabled options
  List<ValueItem<T>> get disabledOptions => value._disabledOptions;

  /// get enabled options
  List<ValueItem<T>> get enabledOptions => value._options
      .where((option) =>
          value._disabledOptions.firstWhereOrNull((element) => element.label == option.label) ==
          null)
      .toList();

  /// get options
  List<ValueItem<T>> get options => value._options;

  /// get selected options
  List<ValueItem<T>> get selectedOptions => value._selectedOptions;

  /// get is dropdown open
  bool get isDropdownOpen => value._isDropdownOpen;

  /// show dropdown
  /// [MultiSelectController] is used to show dropdown.
  void showDropdown() {
    if (value._isDropdownOpen) return;
    value._isDropdownOpen = true;
    notifyListeners();
  }

  /// hide dropdown
  /// [MultiSelectController] is used to hide dropdown.
  void hideDropdown() {
    if (!value._isDropdownOpen) return;
    value._isDropdownOpen = false;
    notifyListeners();
  }
}
