import 'package:final_year_project/common/widgets/appbar/appbar.dart';
import 'package:final_year_project/common/widgets/custom_shapes/icon/circular_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/styles/shadows.dart';
import '../../../../common/widgets/icons/t_ticket_icon.dart';
import '../../../../common/widgets/select_date/select_date.dart';
import '../../../../common/widgets/text/ticket_price_text.dart';
import '../../../../common/widgets/text/ticket_title_text.dart';
import '../../../../common/widgets/tickets/cart/add_remove_button.dart';
import '../../../../common/widgets/tickets/cart/cart_item.dart';
import '../../../../common/widgets/tickets/ticket_location/ticket_location.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/helpers/helper_functions.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TAppBar(
            showBackArrow: true,
            title: Text('Book Tickets',
                style: Theme.of(context).textTheme.headlineSmall)),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: 1,
            separatorBuilder: (_, __) =>
                const SizedBox(height: TSizes.spaceBtwSections),
            itemBuilder: (_, index) => const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TCartItem(),
              ],
            ),
          ),
        )));
  }
}




