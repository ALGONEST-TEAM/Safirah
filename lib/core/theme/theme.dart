import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';

ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: AppColors.scaffoldColor,
  primarySwatch: AppColors.primarySwatch,
  splashColor: AppColors.primaryColor.withValues(alpha: .1),
  highlightColor: AppColors.primaryColor.withValues(alpha: .1),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    elevation: 0.0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  ),
  tabBarTheme: TabBarThemeData(
    labelPadding: const EdgeInsets.symmetric(horizontal: 12),
    dividerColor: AppColors.fontColor,
    labelColor: Colors.black,
    unselectedLabelColor: AppColors.fontColor,
    indicatorColor: Colors.black,
    overlayColor: MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
        return AppColors.primaryColor.withValues(alpha: 0.1);
      },
    ),
    unselectedLabelStyle: const TextStyle(fontFamily: "IBMPlexSansArabic"),
    labelStyle: const TextStyle(fontFamily: "IBMPlexSansArabic"),
    indicatorSize: TabBarIndicatorSize.label,
    indicator: const UnderlineTabIndicator(
      borderSide: BorderSide(width: 1.6, color: Colors.black),
      insets: EdgeInsets.symmetric(vertical: 10),
    ),
    dividerHeight: 0.23,
    tabAlignment: TabAlignment.start,
  ),
  fontFamily: 'IBMPlexSansArabic',
);
