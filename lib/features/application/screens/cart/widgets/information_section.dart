import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/section_heading.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/validators/validation.dart';
import '../../../../personalization/controllers/user_controller.dart';
import '../../../../personalization/screens/profile/widgets/change_name.dart';
import '../../../../personalization/screens/profile/widgets/change_phoneNumber.dart';
import '../../../../personalization/screens/profile/widgets/profile_menu.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/Info_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../utils/constants/sizes.dart';

class TInformationSection extends StatelessWidget {
  const TInformationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final checkoutInfoController = Get.put(CheckoutInfoController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Personal Information', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: TSizes.spaceBtwItems / 2),

        Text('Full name', style: Theme.of(context).textTheme.bodySmall),
        const SizedBox(height: TSizes.spaceBtwItems/4),
        // TextField cho Họ và Tên
        TextField(
          controller: checkoutInfoController.nameController,
          style:  Theme.of(context).textTheme.bodyMedium,
          decoration: const InputDecoration(
            border: UnderlineInputBorder(), // Gạch chân dưới
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey), // Màu gạch chân
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blue), // Màu gạch chân khi focus
            ),

          ),
        ),
        const SizedBox(height: TSizes.spaceBtwItems/2),

        // Label cho Số điện thoại
        Text('Phone number', style: Theme.of(context).textTheme.bodySmall),
        const SizedBox(height: TSizes.spaceBtwItems/4),
        TextFormField(
          controller: checkoutInfoController.phoneController,
          validator: TValidator.validatePhoneNumber,
          keyboardType: TextInputType.phone,
          style: Theme.of(context).textTheme.bodyMedium,
          decoration: const InputDecoration(
            border: UnderlineInputBorder(), // Gạch chân dưới
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey), // Màu gạch chân
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blue), // Màu gạch chân khi focus
            ),
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwSections),
      ],
    );
  }
}


