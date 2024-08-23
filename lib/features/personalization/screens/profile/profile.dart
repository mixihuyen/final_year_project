import 'package:final_year_project/common/widgets/appbar/appbar.dart';
import 'package:final_year_project/common/widgets/section_heading.dart';
import 'package:final_year_project/features/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              TProfileMenu(title: 'Name', value: 'Mixi Huyen', onPressed: () {}),
              const SizedBox(height: TSizes.spaceBtwItems),
              TProfileMenu(title: 'Username', value: 'mixihuyen', onPressed: () {}),

              const SizedBox(height: TSizes.spaceBtwItems),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),

              const TSectionHeading(title: 'Profile Information', showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),


              TProfileMenu(title: 'E-mail', value: 'lehuyen23vn@gmail.com', onPressed: () {}),
              const SizedBox(height: TSizes.spaceBtwItems),
              TProfileMenu(title: 'Phone', value: '+84 971 625 203', onPressed: () {}),
              const SizedBox(height: TSizes.spaceBtwItems),
              TProfileMenu(title: 'Gender', value: 'Female', onPressed: () {}),
              const SizedBox(height: TSizes.spaceBtwItems),
              TProfileMenu(title: 'Date of Birth', value: '16 Dec, 2003', onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}


