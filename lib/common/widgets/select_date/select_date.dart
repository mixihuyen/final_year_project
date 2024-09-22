import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

import '../../../features/application/controllers/cart_controller.dart';
import '../../../features/application/models/cart_item_model.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/constants/text_strings.dart';

class DatePicker extends StatelessWidget {
  final CartItemModel cartItem; // Truyền CartItemModel vào widget

  const DatePicker({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>(); // Sử dụng Get.find thay vì Get.put

    return Column(
      children: <Widget>[
        Row(
          children: [
            Text('Departure Date: ', style: Theme.of(context).textTheme.bodySmall),
            TextButton(
              onPressed: () => cartController.datePick(context, cartItem), // Gọi hàm selectDate
              child: Text(
                cartItem.date == null
                    ? 'Please select a date'
                    : '${cartItem.date!.day}/${cartItem.date!.month}/${cartItem.date!.year}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),

            ),
          ],
        ),
      ],
    );
  }
}

