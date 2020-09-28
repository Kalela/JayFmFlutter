import 'package:flutter/material.dart';
import 'package:jay_fm_flutter/res/colors.dart';
import 'package:jay_fm_flutter/res/strings.dart';

/// These are the tab bar pop up choices
const List<String> choices = <String>[darkTheme, lightTheme];

/// Default text styling that is used by all text
TextStyle defaultTextStyle(GlobalAppColors colors, [textStyle]) {
  if (textStyle != null)
    return TextStyle(color: colors.mainTextColor).merge(textStyle);
    
  return TextStyle(color: colors.mainTextColor);
}

double topBarHeight = 35.0;
