import 'package:example/context_extension.dart';
import 'package:example/multi_select_dropdown_widget.dart';
import 'package:example/theme.dart';
import 'package:example/zing_icons_widget.dart';
import 'package:flutter/material.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: baseTheme(),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();

  static const _headerStyle = TextStyle(
    fontSize: 12,
    color: Colors.blue,
  );
}

class User {
  final String name;
  final int id;

  User({required this.name, required this.id});

  @override
  String toString() {
    return 'User(name: $name, id: $id)';
  }
}

class _MyHomePageState extends State<MyHomePage> {
  final MultiSelectController<User> _controller = MultiSelectController();

  final List<ValueItem> _selectedOptions = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const Text('WRAP', style: MyHomePage._headerStyle),
                // const SizedBox(
                //   height: 4,
                // ),
                // MultiSelectDropDown<User>(
                //   showClearIcon: true,
                //   controller: _controller,
                //   onOptionSelected: (options) {
                //     debugPrint(options.toString());
                //   },
                //   options: <ValueItem<User>>[
                //     ValueItem(label: 'Option 1', value: User(name: 'User 1', id: 1)),
                //     ValueItem(label: 'Option 2', value: User(name: 'User 2', id: 2)),
                //     ValueItem(label: 'Option 3', value: User(name: 'User 3', id: 3)),
                //     ValueItem(label: 'Option 4', value: User(name: 'User 4', id: 4)),
                //     ValueItem(label: 'Option 5', value: User(name: 'User 5', id: 5)),
                //   ],
                //   maxItems: 4,
                //   selectionType: SelectionType.multi,
                //   chipConfig:
                //       const ChipConfig(wrapType: WrapType.wrap, backgroundColor: Colors.red),
                //   dropdownHeight: 300,
                //   optionTextStyle: const TextStyle(fontSize: 16),
                //   selectedOptionIcon: const Icon(
                //     Icons.check_circle,
                //     color: Colors.pink,
                //   ),
                //   selectedOptionTextColor: Colors.blue,
                // ),
                // const SizedBox(
                //   height: 50,
                // ),
                // Wrap(
                //   children: [
                //     ElevatedButton(
                //       onPressed: () {
                //         _controller.clearAllSelection();
                //         setState(() {
                //           _selectedOptions.clear();
                //         });
                //       },
                //       child: const Text('CLEAR'),
                //     ),
                //     const SizedBox(
                //       width: 8,
                //     ),
                //     ElevatedButton(
                //       onPressed: () {
                //         setState(() {
                //           _selectedOptions.clear();
                //           _selectedOptions.addAll(_controller.selectedOptions);
                //         });
                //       },
                //       child: const Text('Get Selected Options'),
                //     ),
                //     const SizedBox(
                //       width: 8,
                //     ),
                //     ElevatedButton(
                //       onPressed: () {
                //         if (_controller.isDropdownOpen) {
                //           _controller.hideDropdown();
                //         } else {
                //           _controller.showDropdown();
                //         }
                //       },
                //       child: const Text('SHOW/HIDE DROPDOWN'),
                //     ),
                //   ],
                // ),
                // const SizedBox(
                //   height: 12,
                // ),
                // Text(
                //   'Selected Options: $_selectedOptions',
                //   style: const TextStyle(
                //     fontSize: 16,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
                // const SizedBox(
                //   height: 50,
                // ),
                // const Text('SCROLL', style: MyHomePage._headerStyle),
                // const SizedBox(
                //   height: 4,
                // ),
                // MultiSelectDropDown(
                //   onOptionSelected: (options) {
                //     debugPrint(options.toString());
                //   },
                //   options: const <ValueItem>[
                //     ValueItem(label: 'Option 1', value: '1'),
                //     ValueItem(label: 'Option 2', value: '2'),
                //     ValueItem(label: 'Option 3', value: '3'),
                //     ValueItem(label: 'Option 4', value: '4'),
                //     ValueItem(label: 'Option 5', value: '5'),
                //     ValueItem(label: 'Option 6', value: '6'),
                //   ],
                //   selectionType: SelectionType.multi,
                //   chipConfig: const ChipConfig(wrapType: WrapType.scroll),
                //   dropdownHeight: 400,
                //   optionTextStyle: const TextStyle(fontSize: 16),
                //   selectedOptionIcon: const Icon(Icons.check_circle),
                // ),
                // const SizedBox(
                //   height: 50,
                // ),
                // const Text('FROM NETWORK', style: MyHomePage._headerStyle),
                // const SizedBox(
                //   height: 4,
                // ),
                // MultiSelectDropDown.network(
                //   dropdownHeight: 300,
                //   onOptionSelected: (options) {
                //     debugPrint(options.toString());
                //   },
                //   searchEnabled: true,
                //   networkConfig: NetworkConfig(
                //     url: 'https://jsonplaceholder.typicode.com/users',
                //     method: RequestMethod.get,
                //     headers: {
                //       'Content-Type': 'application/json',
                //     },
                //   ),
                //   chipConfig: const ChipConfig(wrapType: WrapType.wrap),
                //   responseParser: (response) {
                //     debugPrint('Response: $response');

                //     final list = (response as List<dynamic>).map((e) {
                //       final item = e as Map<String, dynamic>;
                //       return ValueItem(
                //         label: item['name'],
                //         value: item['id'].toString(),
                //       );
                //     }).toList();

                //     return Future.value(list);
                //   },
                //   responseErrorBuilder: ((context, body) {
                //     return const Padding(
                //       padding: EdgeInsets.all(16.0),
                //       child: Text('Error fetching the data'),
                //     );
                //   }),
                // ),
                // const SizedBox(height: 50),
                SizedBox(
                  height: 59,
                  child: MultiSelectDropDownWidget<String>(
                    title: 'Type',
                    titleStyle: context.textTheme.bodySmall?.copyWith(
                      color: context.colorTheme.secondary,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: context.colorTheme.outline,
                      ),
                    ),
                   // showDropDownOnStart: true,
                    selectionType: SelectionType.single,
                    gettingOptions: false,
                    searchKeyboardType: TextInputType.text,
                    options: const [
                      ValueItem(label: 'Test1', value: 'Test1'),
                      ValueItem(label: 'Test2', value: 'Test2'),
                    ],
                    selectedOptions: [
                      ValueItem(
                        label: 'Test1',
                        value: 'Test1',
                        icon: Padding(
                          padding: const EdgeInsets.only(right: 4),  
                          child: Image.asset(
                            ZingIconsWidget.add,
                            height: 18,
                            width: 18,
                            color: context.colorTheme.onSurface,
                          ),
                        ),
                      ),
                    ],
                    onShowOverlay: (overlayEntry) {},
                    reachedMaxOptionsScroll: () {},
                    suffixIcon: Icon(
                      Icons.arrow_drop_down_rounded,
                      size: 24,
                      color: context.colorTheme.secondary,
                    ),
                    onOptionSelected: (List<ValueItem<String>> selectedOptions,controller) {},
                    onSearch: (value, List<ValueItem<String>> options) {},
                    allowCustomValues: false,
                    alwaysShowOptionIcon: false,
                    searchEnabled: false,
                    canDeleteChip: false,
                    showChipInSingleSelectMode: false,
                    chipTextStyle: context.textTheme.bodyLarge,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
