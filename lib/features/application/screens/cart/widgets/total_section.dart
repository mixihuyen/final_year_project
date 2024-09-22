import 'package:final_year_project/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../utils/formatters/forrmatter.dart';
import '../../../controllers/cart_controller.dart';

class TTotalSection extends StatelessWidget {
  const TTotalSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(CartController());
    return Obx(() =>
       Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Subtotal', style: Theme.of(context).textTheme.bodyMedium),
              Text(TFormatter.format(cartController.totalCartPrice.value), style: Theme.of(context).textTheme.bodyMedium)
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwItems / 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Tax', style: Theme.of(context).textTheme.bodyMedium),
              Text('0 VND', style: Theme.of(context).textTheme.bodyMedium)
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwItems / 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Order Total', style: Theme.of(context).textTheme.titleMedium),
              Text(TFormatter.format(cartController.totalCartPrice.value), style: Theme.of(context).textTheme.titleMedium)
            ],
          ),
        ],
      ),
    );
  }
}
