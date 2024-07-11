import 'dart:ui';

import 'package:JayFm/models/global_app_colors.dart';
import 'package:flutter/material.dart';

// Light Theme

const Color jayFmOrange = Color.fromARGB(200, 255, 168, 0);
const Color jayFmBlue = Color.fromARGB(127, 100, 201, 231);
const Color jayFmFancyBlack = Color.fromARGB(255, 49, 49, 49);
const Color jayFmMaroon = Color.fromARGB(255, 171, 91, 76);

//Dark theme
const Color jayFmPurple = Color.fromARGB(200, 149, 11, 205);

/// Text colors for dark theme
const TextTheme darkTextTheme = TextTheme(
    bodyMedium: TextStyle(color: Colors.grey),
    bodyLarge: TextStyle(color: Colors.grey),
    titleLarge: TextStyle(color: Colors.grey));

/// Text colors for dark theme
const TextTheme lightTextTheme = TextTheme(
    bodyMedium: TextStyle(color: Colors.black),
    bodyLarge: TextStyle(color: Colors.black),
    titleLarge: TextStyle(color: Colors.black));

//Palette
// rgb(49, 49, 49) Fancy black
// rgb(203, 185, 175) Cream
// rgb(168, 54, 102) Purple
// rgb(171, 91, 76) Maroon
// rgb(171, 91, 76) Maroon

const darkColors = GlobalAppColors(
    mainBackgroundColor: jayFmFancyBlack,
    mainButtonsColor: Colors.grey,
    mainIconsColor: Colors.blueGrey,
    mainTextColor: Colors.white,
    textTheme: darkTextTheme);

const lightColors = GlobalAppColors(
    mainBackgroundColor: jayFmBlue,
    mainButtonsColor: jayFmFancyBlack,
    mainIconsColor: jayFmOrange,
    mainTextColor: Colors.black,
    textTheme: lightTextTheme);
