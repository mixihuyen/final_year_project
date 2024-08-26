import 'package:flutter/material.dart';

import '../../../../../common/styles/shadows.dart';
import '../../../../../common/widgets/icons/t_ticket_icon.dart';
import '../../../../../common/widgets/select_date/select_date.dart';
import '../../../../../common/widgets/text/ticket_price_text.dart';
import '../../../../../common/widgets/text/ticket_title_text.dart';
import '../../../../../common/widgets/tickets/cart/add_remove_button.dart';
import '../../../../../common/widgets/tickets/ticket_location/ticket_location.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class TCartItems extends StatelessWidget {
  const TCartItems({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 362,
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          decoration: BoxDecoration(
            color: THelperFunctions.isDarkMode(context)
                ? TColors.textPrimary
                : TColors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [TShadowStyle.ticketShadow],
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// -- Title
              TTicketTitleText(title: TTexts.titleTicket1),
              SizedBox(height: TSizes.spaceBtwItems),

              /// -- Divider
              Divider(),

              /// -- Ticket Details
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// -- Icon
                  TicketDetailIcons(),
                  SizedBox(width: TSizes.defaultSpace),

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
                ],
              ),
              DatePicker(),

              /// -- Divider
              Divider(),

              /// -- Price and Button
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TTicketQuantityWithAddRemoveButton(),
                    /// -- Price
                    TTicketPriceText(price: '250.000'),

                    /// -- Button
                  ]),
            ],
          ),
        ),
      ],
    );
  }
}