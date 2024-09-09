import 'package:final_year_project/common/widgets/custom_shapes/containers/rounded_container.dart';
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

class TMyTicketListItem extends StatelessWidget {
  const TMyTicketListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: 5,
      separatorBuilder: (_, __) =>
          const SizedBox(height: TSizes.spaceBtwSections),
      itemBuilder: (_, index) => Row(
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
                const SizedBox(height: TSizes.spaceBtwItems),
                Row(
                  children: [
                    Text('Number of seats: ',
                        style: Theme.of(context).textTheme.bodyMedium),
                    Text('2 ', style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
                Row(
                  children: [
                    Text('Departure date: ',
                        style: Theme.of(context).textTheme.bodyMedium),
                    Text('13/03/2024 ',
                        style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),

                /// -- Divider
                const Divider(),
                Text('Payment method',
                    style: Theme.of(context).textTheme.titleMedium),
                Text('VISA *** 0878',
                    style: Theme.of(context).textTheme.bodyMedium),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total amount: ',
                        style: Theme.of(context).textTheme.titleMedium),
                    const TTicketPriceText(price: '250.000'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
