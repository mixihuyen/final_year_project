import 'package:final_year_project/common/styles/shadows.dart';
import 'package:final_year_project/common/widgets/text/ticket_title_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../../features/application/screens/cart/cart.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../icons/t_ticket_icon.dart';
import '../../text/ticket_price_text.dart';
import '../ticket_location/ticket_location.dart';

class TTicketCard extends StatelessWidget {
  const TTicketCard({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: (){},
      child: Container(
        width: 350,
        margin: const EdgeInsets.only(
            top: TSizes.defaultSpace,
            bottom: TSizes.defaultSpace,
            left: TSizes.defaultSpace),
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        decoration: BoxDecoration(
          color: dark ? TColors.textPrimary : TColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [TShadowStyle.ticketShadow],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// -- Title
            const TTicketTitleText(title: TTexts.titleTicket1),
            const SizedBox(height: TSizes.spaceBtwItems),
            /// -- Divider
            const Divider(),
            /// -- Ticket Details
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// -- Icon
                TicketDetailIcons(),
                /// -- Details
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TicketTimeLocation(
                      time: '08:25',
                      location: 'BX Le Thuy',
                      province: 'Quang Binh',
                    ),
                    SizedBox(height: TSizes.spaceBtwItems),
                    TicketTimeLocation(
                      time: '14:20',
                      location: 'BX Trung Tam Da Nang',
                      province: 'Da Nang',
                    ),
                  ],
                ),
                Text(
                  'Còn trống: 4',
                  style: TextStyle(
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            /// -- Divider
            const Divider(),
            /// -- Price and Button
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(TTexts.room34, style: Theme.of(context).textTheme.titleMedium),
              Column(children: [
                /// -- Price
                const TTicketPriceText(price: '250.000'),
                /// -- Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: TColors.primary,
                    padding: const EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () => Get.to(() => const CartScreen()),
                  child: Text(TTexts.bookTicket,
                      style: Theme.of(context).textTheme.bodyLarge!.apply(color: TColors.white)),
                ),
              ]),
            ]),
          ],
        ),
      ),
    );
  }
}



