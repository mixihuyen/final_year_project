import 'package:final_year_project/common/widgets/appbar/appbar.dart';
import 'package:final_year_project/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:final_year_project/common/widgets/list_tiles/setting_menu_tile.dart';
import 'package:final_year_project/common/widgets/section_heading.dart';
import 'package:final_year_project/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/list_tiles/user_profile_tile.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../profile/profile.dart';
import '../../../../data/repositories/authentication/authentication_repository.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// -- Header
            TPrimaryHeaderContainer(
                child: Column(
                  children: [
                    TAppBar(
                        title: Text('Account',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .apply(color: TColors.white))),
                    TUserProfileTile(onPressed: () => Get.to(() => const ProfileScreen())),
                    const SizedBox(height: TSizes.spaceBtwSections),
                  ],
                )),

            /// -- Body
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  /// -- Account Setting
                  const TSectionHeading(title: 'Account Setting', showActionButton: false),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  TSettingMenuTile(
                    icon: Iconsax.security_card,
                    title: 'Account',
                    onTap: () {
                      // Navigate to ProfileScreen when the tile is tapped
                      Get.to(() => const  ProfileScreen()); // Using GetX for navigation
                    }, subTitle: 'Personal information management',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: OutlinedButton(
            onPressed: () => AuthenticationRepository.instance.logout(),
            child: const Text('Logout')),
      ),
    );
  }
}
