import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/validators/validation.dart';
import '../../../controllers/update_name_controller.dart';
import '../../../controllers/update_phone_number_controller.dart';

class ChangePhoneNumber  extends StatelessWidget {
  const ChangePhoneNumber ({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdatePhoneNumberController());
    return Scaffold(
      appBar: TAppBar(
        title: Text('Change Phone Number', style: Theme.of(context).textTheme.headlineSmall), showBackArrow: true
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Change your Phone Number', style: Theme.of(context).textTheme.labelMedium),
            const SizedBox(height: TSizes.spaceBtwSections),
            Form(key: controller.updatePhoneNumberFormKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: controller.phoneNumber,
                      validator: (value) => TValidator.validatePhoneNumber(value),
                      expands: false,
                      decoration: const InputDecoration(labelText: TTexts.phoneNo, prefixIcon: Icon(Iconsax.call)),
                    )
                  ],
                )),
            const SizedBox(height: TSizes.spaceBtwSections),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton( onPressed: () => controller.updatePhoneNumber(),child: const Text('Save')),
            )
          ],
        ),
      ),
    );
  }
}