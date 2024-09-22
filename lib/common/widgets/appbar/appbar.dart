import 'package:final_year_project/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../features/application/controllers/cart_controller.dart';
import '../../../utils/constants/sizes.dart';

class TAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TAppBar({
    super.key,
    this.title,
    this.leadingIcon,
    this.actions,
    this.leadingOnPressed,
    this.showBackArrow = false,
  });

  final Widget? title;
  final bool showBackArrow;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;

  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(CartController());
    return WillPopScope(
      onWillPop: () async {
        cartController.clearCart();
        return true;
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: TSizes.sm),
        child: AppBar(
           automaticallyImplyLeading: false,
          leading: showBackArrow
              ? IconButton(
                  onPressed: () =>{ Get.back(), cartController.clearCart()},
                  icon: const Icon(Iconsax.arrow_left))
              : leadingIcon != null
                  ? IconButton(
                      onPressed: leadingOnPressed, icon: Icon(leadingIcon))
                  : null,
          title: title,
          actions: actions,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(TDeviceUtils.getAppBarHeight());
}
