import 'dart:ui';

// Light Theme

Color jayFmOrange = Color.fromARGB(200, 255, 168, 0);
Color jayFmBlue = Color.fromARGB(255, 100, 201, 231);
Color jayFmFancyBlack = Color.fromARGB(255, 49, 49, 49);
Color jayFmMaroon = Color.fromARGB(255, 171, 91, 76);

//Dark theme
Color jayFmPurple = Color.fromARGB(200, 149, 11, 205);

//Palette
// rgb(49, 49, 49) Fancy black
// rgb(203, 185, 175) Cream
// rgb(168, 54, 102) Purple
// rgb(171, 91, 76) Maroon
// rgb(171, 91, 76) Maroon

class GlobalAppColors {
  Color mainBackgroundColor;
  Color mainButtonsColor;
  Color mainIconsColor;
  Color mainTextColor;

  GlobalAppColors(
      {this.mainBackgroundColor,
      this.mainButtonsColor,
      this.mainIconsColor,
      this.mainTextColor});
}
