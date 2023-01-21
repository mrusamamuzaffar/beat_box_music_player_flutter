import 'package:flutter/material.dart';

import '../configs/app_theme.dart';

class AppUtils {
  static const String appIcon = 'assets/icon.png';

  static const String dp = 'assets/dp.png';
  static const String male = 'assets/male.png';
  static const String other = 'assets/other.png';
  static const String female = 'assets/female.png';

  static const String song = 'assets/song.png';
  static const String artist = 'assets/artist.png';
  static const String playing = 'assets/playing.png';

  static ButtonStyle textButtonStyle = ButtonStyle(
    foregroundColor: MaterialStateProperty.all(AppTheme.c!.accent),
  );
}
