import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class BusTicketWidget extends StatelessWidget {
  const BusTicketWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Container(
      width: 350,
      margin: const EdgeInsets.only(top: TSizes.defaultSpace, bottom: TSizes.defaultSpace,
      left: TSizes.defaultSpace),
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      decoration: BoxDecoration(
        color: dark ? TColors.textPrimary : TColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(TTexts.titleTicket1,
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: TSizes.spaceBtwItems),
          Divider(color: Colors.grey[400], thickness: 1.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  const Icon(
                    Icons.circle_outlined,
                    color: Colors.grey,
                    size: 14,
                  ),
                  Container(
                    width: 1,
                    height: 65, // adjust as needed
                    color: Colors.grey,
                  ),
                  Transform.rotate(
                    angle: 3.14159 / 2,
                    child: const Icon(
                      Iconsax.send_1,
                      color: Colors.grey,
                      size: 14,
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 65, // adjust as needed
                    color: Colors.grey,
                  ),
                  const Icon(
                    Icons.circle_outlined,
                    color: Colors.grey,
                    size: 14,
                  ),
                ],
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TicketTimeLocation(
                    time: '08:25',
                    location: 'Bx Le Thuy',
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
              const Text(
                'Còn trống: 4',
                style: TextStyle(
                  color: Colors.green,
                ),
              ),
            ],
          ),
          Divider(color: Colors.grey[400], thickness: 1.0),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(TTexts.room34, style: Theme.of(context).textTheme.titleLarge),
            Column(children: [
              const Text(
                '250.000VND',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: TColors.primary,
                  padding: const EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: () {
                  // Action when button is pressed
                },
                child: Text(TTexts.bookTicket,
                    style: Theme.of(context).textTheme.bodyLarge),
              ),
            ]),
          ]),
        ],
      ),
    );
  }
}

class TicketTimeLocation extends StatelessWidget {
  final String time;
  final String location;
  final String province;

  const TicketTimeLocation(
      {super.key,
      required this.time,
      required this.location,
      required this.province});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(time, style: Theme.of(context).textTheme.bodyLarge),
      Text(location, style: Theme.of(context).textTheme.bodyLarge),
      Text(
        province,
        style: TextStyle(
          color: Colors.grey[600],
        ),
      ),
    ]);
  }
}
