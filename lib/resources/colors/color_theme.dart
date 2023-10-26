import 'package:flutter/material.dart';

@immutable
class ColorAppTheme extends ThemeExtension<ColorAppTheme> {
  const ColorAppTheme({
    required this.splashColor,
  });

  final Color? splashColor;

  @override
  ColorAppTheme copyWith({Color? brandColor, Color? danger}) {
    return ColorAppTheme(
      splashColor: brandColor ?? this.splashColor,
    );
  }

  @override
  ColorAppTheme lerp(ColorAppTheme? other, double t) {
    if (other is! ColorAppTheme) {
      return this;
    }
    return ColorAppTheme(
      splashColor: Color.lerp(splashColor, other.splashColor, t),
    );
  }
}

const lightColorTheme = ColorAppTheme(splashColor: Colors.white);
const darkColorTheme = ColorAppTheme(splashColor: Colors.black);