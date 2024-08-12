import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class TSignupForm extends StatelessWidget {
  const TSignupForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Form(
      child: Column(
        children: [
          /// First & Last Name
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  expands: false,
                  decoration: const InputDecoration(
                      labelText: TTexts.firstName,
                      prefixIcon: Icon(Iconsax.user)),
                ),
              ),
              const SizedBox(width: TSizes.spaceBtwInputFields),
              Expanded(
                child: TextFormField(
                  expands: false,
                  decoration: const InputDecoration(
                      labelText: TTexts.lastName,
                      prefixIcon: Icon(Iconsax.user)),
                ),
              ),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          /// User Name
          TextFormField(
            expands: false,
            decoration: const InputDecoration(
                labelText: TTexts.username,
                prefixIcon: Icon(Iconsax.user_edit)),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          /// Phone Number
          TextFormField(
            expands: false,
            decoration: const InputDecoration(
                labelText: TTexts.phoneNo,
                prefixIcon: Icon(Iconsax.call)),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          /// Password
          TextFormField(
            obscureText: true,
            decoration: const InputDecoration(
                labelText: TTexts.password,
                prefixIcon: Icon(Iconsax.password_check),
                suffixIcon: Icon(Iconsax.eye_slash)),
          ),
          const SizedBox(height: TSizes.spaceBtwSections),
          /// Term & Conditions Checkbox
          const TTernAndConditionCheckbox(),
          const SizedBox(height: TSizes.spaceBtwSections),
          /// Sign Up Button
          SizedBox(width: double.infinity, child: ElevatedButton(onPressed: (){},child: const Text(TTexts.createAccount)),)
        ],
      ),
    );
  }
}

class TTernAndConditionCheckbox extends StatelessWidget {
  const TTernAndConditionCheckbox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Row(
      children: [
        SizedBox(width: 24, height: 24,child: Checkbox(value: true, onChanged: (value){})),
        //const SizedBox(width: TSizes.spaceBtwItems),
        Text.rich(TextSpan(
            children: [
              TextSpan(text: ' ${TTexts.iAgreeTo} ', style: Theme.of(context).textTheme.bodySmall),
              TextSpan(text: TTexts.privacyPolicy, style: Theme.of(context).textTheme.bodyMedium!.apply(
                color: dark ? TColors.white : TColors.primary,
                decoration: TextDecoration.underline,
                decorationColor: dark? TColors.white : TColors.primary,
              )),
              TextSpan(text: ' ${TTexts.and} ', style: Theme.of(context).textTheme.bodySmall),
              TextSpan(text: TTexts.termsOfUse, style: Theme.of(context).textTheme.bodyMedium!.apply(
                color: dark ? TColors.white : TColors.primary,
                decoration: TextDecoration.underline,
                decorationColor: dark? TColors.white : TColors.primary,
              )),
            ]),
        )
      ],
    );
  }
}