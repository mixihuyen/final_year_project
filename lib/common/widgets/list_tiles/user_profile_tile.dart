import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';

class TUserProfileTile extends StatelessWidget {
  const TUserProfileTile({
    super.key, required this.onPressed,
  });
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Image(
        height: 50,
        width: 50,
        image: AssetImage(TImages.user),
      ),
      title: Text('Mixi Huyen', style: Theme
          .of(context)
          .textTheme
          .headlineSmall!
          .apply(color: TColors.white)),
      subtitle: Text('lehuyen23vn@gmail.com', style: Theme
          .of(context)
          .textTheme
          .bodyMedium!
          .apply(color: TColors.white)),
      trailing: IconButton(onPressed: onPressed,
          icon: const Icon(Iconsax.edit, color: TColors.white)),
    );
  }
}