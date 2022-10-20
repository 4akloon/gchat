part of '../styles.dart';

final ThemeData darkTheme = ThemeData(
  brightness: darkPalette.brightness,
  primarySwatch: darkPalette.swatch,
  indicatorColor: darkPalette.accentBlue,
  primaryColor: darkPalette.accentBlue,
  toggleableActiveColor: darkPalette.accentBlue,
  splashColor: darkPalette.accentBlue.withOpacity(0.1),
  highlightColor: darkPalette.accentBlue.withOpacity(0.1),
  appBarTheme: AppBarTheme(
    centerTitle: true,
    titleTextStyle: AppTextStyles.headlineBold.copyWith(
      color: darkPalette.black,
    ),
    foregroundColor: darkPalette.black,
    backgroundColor: darkPalette.white,
    elevation: 1,
    shadowColor: darkPalette.black.withOpacity(0.08),
    toolbarHeight: 56,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: darkPalette.white,
  ),
  dividerTheme: DividerThemeData(
    color: darkPalette.black.withOpacity(0.08),
    space: 1,
  ),
  iconTheme: IconThemeData(color: darkPalette.black),
  disabledColor: darkPalette.greyGainsboro,
  backgroundColor: darkPalette.whiteSnow,
  scaffoldBackgroundColor: darkPalette.whiteSnow,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith(
        (states) {
          if (states.contains(MaterialState.disabled)) {
            return darkPalette.buttonBackground.withOpacity(0.5);
          }
          return darkPalette.buttonBackground;
        },
      ),
      foregroundColor: MaterialStateProperty.resolveWith(
        (states) {
          if (states.contains(MaterialState.disabled)) {
            return darkPalette.buttonText.withOpacity(0.5);
          }
          return darkPalette.buttonText;
        },
      ),
      minimumSize: MaterialStateProperty.all(const Size(0, 48)),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
      ),
      textStyle: MaterialStateProperty.all(AppTextStyles.headlineBold),
      shadowColor: MaterialStateProperty.all(Colors.transparent),
    ),
  ),
);
