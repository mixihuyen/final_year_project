import 'package:final_year_project/common/widgets/login_signup/form_divider.dart';
import 'package:final_year_project/common/widgets/login_signup/social_buttons.dart';
import 'package:final_year_project/features/authentication/screens/login/widgets/login_form.dart';
import 'package:final_year_project/features/authentication/screens/login/widgets/login_header.dart';
import 'package:final_year_project/features/authentication/screens/login/widgets/login_logo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/styles/spacing_styles.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: TSpacingStyle.paddingWithAppBarHeight,
        child: Column(
          children: [
            const TLoginLogo(),
            const SizedBox(height: TSizes.spaceBtwItems),
            const TLoginHeader(),
            const TLoginForm(),

            /// Divider
            TFormDivider(dividerText: TTexts.orSignInWith.capitalize!),
            const SizedBox(height: TSizes.spaceBtwItems),
            /// Footer
            const TSocialButton()
          ],
        ),
      ),
    );
  }
}
