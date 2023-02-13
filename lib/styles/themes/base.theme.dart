part of '../styles.dart';

ThemeData getTheme(AppColors colors) => ThemeData(
      primarySwatch: colors.swatch,
      indicatorColor: colors.accentBlue,
      primaryColor: colors.accentBlue,
      toggleableActiveColor: colors.accentBlue,
      splashColor: colors.accentBlue.withOpacity(0.1),
      highlightColor: colors.accentBlue.withOpacity(0.1),
      cupertinoOverrideTheme: CupertinoThemeData(
        brightness: colors.brightness,
      ),
      brightness: colors.brightness,
      appBarTheme: AppBarTheme(
        centerTitle: true,
        titleTextStyle: AppTextStyles.headlineBold.copyWith(
          color: colors.black,
        ),
        foregroundColor: colors.black,
        backgroundColor: colors.white,
        elevation: 1,
        shadowColor: colors.black.withOpacity(0.08),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: colors.greyWhisper),
        ),
        toolbarHeight: 56,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colors.white,
      ),
      dividerTheme: DividerThemeData(
        color: colors.black.withOpacity(0.08),
        space: 1,
      ),
      iconTheme: IconThemeData(color: colors.black),
      disabledColor: colors.greyGainsboro,
      backgroundColor: colors.whiteSnow,
      scaffoldBackgroundColor: colors.whiteSnow,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith(
            (states) {
              if (states.contains(MaterialState.disabled)) {
                return colors.buttonBackground.withOpacity(0.5);
              }
              return colors.buttonBackground;
            },
          ),
          foregroundColor: MaterialStateProperty.all(colors.buttonText),
          minimumSize: MaterialStateProperty.all(const Size(0, 48)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
          ),
          textStyle: MaterialStateProperty.all(AppTextStyles.headlineBold),
          shadowColor: MaterialStateProperty.all(Colors.transparent),
        ),
      ),
    );
