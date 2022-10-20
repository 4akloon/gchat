part of '../styles.dart';

final ThemeData lightTheme = ThemeData(
  primarySwatch: lightPalette.swatch,
  indicatorColor: lightPalette.accentBlue,
  primaryColor: lightPalette.accentBlue,
  toggleableActiveColor: lightPalette.accentBlue,
  splashColor: lightPalette.accentBlue.withOpacity(0.1),
  highlightColor: lightPalette.accentBlue.withOpacity(0.1),
  cupertinoOverrideTheme: CupertinoThemeData(
    brightness: lightPalette.brightness,
  ),
  brightness: lightPalette.brightness,
  appBarTheme: AppBarTheme(
    centerTitle: true,
    titleTextStyle: AppTextStyles.headlineBold.copyWith(
      color: lightPalette.black,
    ),
    foregroundColor: lightPalette.black,
    backgroundColor: lightPalette.white,
    elevation: 1,
    shadowColor: lightPalette.black.withOpacity(0.08),
    shape: RoundedRectangleBorder(
        side: BorderSide(color: lightPalette.greyWhisper)),
    toolbarHeight: 56,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: lightPalette.white,
  ),
  dividerTheme: DividerThemeData(
    color: lightPalette.black.withOpacity(0.08),
    space: 1,
  ),
  iconTheme: IconThemeData(color: lightPalette.black),
  disabledColor: lightPalette.greyGainsboro,
  backgroundColor: lightPalette.whiteSnow,
  scaffoldBackgroundColor: lightPalette.whiteSnow,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith(
        (states) {
          if (states.contains(MaterialState.disabled)) {
            return lightPalette.buttonBackground.withOpacity(0.5);
          }
          return lightPalette.buttonBackground;
        },
      ),
      foregroundColor: MaterialStateProperty.all(lightPalette.buttonText),
      minimumSize: MaterialStateProperty.all(const Size(0, 48)),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
      ),
      textStyle: MaterialStateProperty.all(AppTextStyles.headlineBold),
      shadowColor: MaterialStateProperty.all(Colors.transparent),
    ),
  ),
);
