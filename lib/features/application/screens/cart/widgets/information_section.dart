import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/section_heading.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../personalization/controllers/user_controller.dart';
import '../../../../personalization/screens/profile/widgets/change_name.dart';
import '../../../../personalization/screens/profile/widgets/change_phoneNumber.dart';
import '../../../../personalization/screens/profile/widgets/profile_menu.dart';

class TInformationSection extends StatelessWidget {
  const TInformationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return Obx( () =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Personal Information', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: TSizes.spaceBtwItems / 2),
          TProfileMenu(
              title: 'Name',
              icon: Iconsax.arrow_right_34,
              value: controller.user.value.fullName,
              onPressed: () => Get.to(() => const ChangeName())),
          TProfileMenu(
              title: 'Phone',
              icon: Iconsax.arrow_right_34,
              value: controller.user.value.phoneNumber,
              onPressed: () => Get.to(() => const ChangePhoneNumber())),
          const SizedBox(height: TSizes.spaceBtwItems / 2),
        ],
      ),
    );
  }
}
