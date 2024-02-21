import 'package:flutter/material.dart';

extension MakeUiResponse on BuildContext {
  EdgeInsets get getPadding {
    return MediaQuery.paddingOf(this);
  }

  EdgeInsets get viewPadding {
    return MediaQuery.viewPaddingOf(this);
  }

  EdgeInsets get viewInsets {
    return MediaQuery.viewInsetsOf(this);
  }

  void unFocus() {
    
    FocusScope.of(this).requestFocus(FocusNode());
  }

  bool get forTablet {
    Size size = MediaQuery.sizeOf(this);
    double width = size.width > size.height ? size.height : size.width;
    if (width > 600) {
      // Do something for tablets here
      return true;
    } else {
      // Do something for phones
      return false;
    }
  }

  ColorScheme get colorTheme => Theme.of(this).colorScheme;
  TextTheme get textTheme => Theme.of(this).textTheme;
  Size get mqSize => MediaQuery.sizeOf(this);
  }
