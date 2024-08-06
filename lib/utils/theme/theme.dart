
import 'package:final_year_project/utils/theme/custom_themes/appbar_theme.dart';
import 'package:final_year_project/utils/theme/custom_themes/bottom_sheet_theme.dart';
import 'package:final_year_project/utils/theme/custom_themes/checkbox_theme.dart';
import 'package:final_year_project/utils/theme/custom_themes/chip_theme.dart';
import 'package:final_year_project/utils/theme/custom_themes/text_field_theme.dart';
import 'package:flutter/material.dart';

import 'custom_themes/elevated_button_theme.dart';
import 'custom_themes/text_theme.dart';

class TAppTheme {
  TAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Kanit',
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    textTheme: TTextTheme.lightTextTheme,
    chipTheme: TChipTheme.lightChipTheme,
    elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
    appBarTheme: TAppBarTheme.lightAppBarTheme,
    checkboxTheme: TCheckboxTheme.LightCheckboxTheme,
    bottomSheetTheme: TBottomSheetTheme.lightBottomSheetTheme,
    inputDecorationTheme: TTextFormFieldTheme.lightInputDecorationTheme,
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Kanit',
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.black,
    textTheme:  TTextTheme.darkTextTheme,
    chipTheme: TChipTheme.darkChipTheme,
    elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme,
    appBarTheme: TAppBarTheme.darkAppBarTheme,
    checkboxTheme: TCheckboxTheme.darkCheckboxTheme,
    bottomSheetTheme: TBottomSheetTheme.darkBottomSheetTheme,
    inputDecorationTheme: TTextFormFieldTheme.darkInputDecorationTheme,
  );

}