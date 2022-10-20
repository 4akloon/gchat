part of '../styles.dart';

class AppColors {
  final Brightness brightness;
  final MaterialColor swatch;
  final Color black;
  final Color grey;
  final Color greyGainsboro;
  final Color greyWhisper;
  final Color whiteSmoke;
  final Color whiteSnow;
  final Color white;
  final Color blueAlice;
  final Gradient bgGradient;
  final Color overlay;
  final Color overlayDark;
  final Color buttonText;
  final Color buttonBackground;
  final Color accentBlue;
  final Color accentRed;
  final Color accentGreen;
  AppColors({
    required this.brightness,
    required this.swatch,
    required this.black,
    required this.grey,
    required this.greyGainsboro,
    required this.greyWhisper,
    required this.whiteSmoke,
    required this.whiteSnow,
    required this.white,
    required this.blueAlice,
    required this.bgGradient,
    required this.overlay,
    required this.overlayDark,
    required this.buttonText,
    required this.buttonBackground,
    required this.accentBlue,
    required this.accentRed,
    required this.accentGreen,
  });

  factory AppColors.of(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light
          ? lightPalette
          : darkPalette;
}
