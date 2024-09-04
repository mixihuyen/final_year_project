import 'package:final_year_project/common/widgets/appbar/appbar.dart';
import 'package:final_year_project/features/personalization/controllers/user_controller.dart';
import 'package:final_year_project/utils/validators/validation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../controllers/update_name_controller.dart';

class ReAuthLoginForm  extends StatelessWidget {
  const ReAuthLoginForm ({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: const TAppBar(
        showBackArrow: true,
        title: Text('Re-Authenticate User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Use real name for easy verification.', style: Theme.of(context).textTheme.labelMedium),
            const SizedBox(height: TSizes.spaceBtwSections),
            Form(key: controller.reAuthFormKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: controller.verifyEmail,
                      validator:  TValidator.validateEmail,
                      decoration: const InputDecoration(labelText: TTexts.email, prefixIcon: Icon(Iconsax.direct_right)),
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    Obx(
                          () => TextFormField(
                        validator: (value) => TValidator.validatePassword(value),
                        controller: controller.verifyPassword,
                        obscureText: controller.hidePassword.value,
                        decoration: InputDecoration(
                          labelText: TTexts.password,
                          prefixIcon: const Icon(Iconsax.password_check),
                          suffixIcon: IconButton(
                            onPressed: () => controller.hidePassword.value =
                            !controller.hidePassword.value,
                            icon: Icon(controller.hidePassword.value
                                ? Iconsax.eye_slash
                                : Iconsax.eye),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
            const SizedBox(height: TSizes.spaceBtwSections),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton( onPressed: () => controller.reAuthenticateEmailAndPasswordUser(),child: const Text('Verify')),
            )
          ],
        ),
      ),
    );
  }
}
