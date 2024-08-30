import 'package:final_year_project/bindings/general_bindings.dart';
import 'package:final_year_project/features/authentication/screens/onboarding/onboarding.dart';
import 'package:final_year_project/utils/constants/text_strings.dart';
import 'package:final_year_project/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

class App extends StatelessWidget {
  const App ({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: TTexts.appName,
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      initialBinding: GeneralBindings(),
      home: const OnBoardingScreen(),
    );
  }
}
