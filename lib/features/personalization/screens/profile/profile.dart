import 'package:final_year_project/common/widgets/appbar/appbar.dart';
import 'package:final_year_project/common/widgets/section_heading.dart';
import 'package:final_year_project/features/personalization/screens/profile/widgets/change_name.dart';
import 'package:final_year_project/features/personalization/screens/profile/widgets/change_phoneNumber.dart';
import 'package:final_year_project/features/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controllers/user_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: TAppBar(
          showBackArrow: true,
          title: Text('Account',
              style: Theme.of(context).textTheme.headlineSmall)),

      /// -- Body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),

          /// -- Profile Picture
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    const Image(
                        height: 80, width: 80, image: AssetImage(TImages.user)),
                    TextButton(
                        onPressed: () {},
                        child: const Text('Change Profile Picture'))
                  ],
                ),
              ),
              /// -- Details
              const SizedBox(height: TSizes.spaceBtwItems/2),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),

              const TSectionHeading(title: 'Account Information', showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),
              TProfileMenu(title: 'Name', icon: Iconsax.arrow_right_34, value: controller.user.value.fullName, onPressed: () => Get.to(() => const ChangeName())),
              const SizedBox(height: TSizes.spaceBtwItems),
              TProfileMenu(title: 'Username', value: controller.user.value.username),

              const SizedBox(height: TSizes.spaceBtwItems),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),

              const TSectionHeading(title: 'Profile Information', showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),

              TProfileMenu(title: 'E-mail', value: controller.user.value.email),
              const SizedBox(height: TSizes.spaceBtwItems),
              TProfileMenu(title: 'Phone',icon: Iconsax.arrow_right_34, value: controller.user.value.phoneNumber, onPressed: () => Get.to(() => const ChangePhoneNumber())),
              const SizedBox(height: TSizes.spaceBtwItems),
              TProfileMenu(title: 'Gender',icon: Iconsax.arrow_right_34, value: 'Female', onPressed: () {}),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),
              Center(
                child: TextButton(
                  onPressed: () => controller.deleteAccountWarningPopup(),
                  child: const Text('Delete Account', style: TextStyle(color: Colors.red)),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}


