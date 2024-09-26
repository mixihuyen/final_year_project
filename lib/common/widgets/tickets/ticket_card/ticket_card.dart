import 'package:final_year_project/common/styles/shadows.dart';
import 'package:final_year_project/common/widgets/text/ticket_title_text.dart';
import 'package:final_year_project/features/application/controllers/cart_controller.dart';
import 'package:final_year_project/features/application/controllers/trip_controller.dart';
import 'package:final_year_project/features/application/models/start_model.dart';
import 'package:final_year_project/features/application/models/trip_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../../features/application/controllers/category_controller.dart';
import '../../../../features/application/models/category_model.dart';
import '../../../../features/application/screens/cart/cart.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../icons/t_ticket_icon.dart';
import '../../text/ticket_price_text.dart';
import '../ticket_location/ticket_location.dart';

class TTicketCard extends StatelessWidget {
  const TTicketCard({super.key, required this.trip});

  final TripModel trip;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final categoryController = Get.put(CategoryController());
    return Obx(() {
      CategoryModel? category =
          categoryController.allCategories.firstWhereOrNull(
        (category) => category.id == trip.categoryId,
      );

      return GestureDetector(
        onTap: () {},
        child: Container(
          width: 350,
          margin: const EdgeInsets.only(
            top: TSizes.defaultSpace,
            bottom: TSizes.defaultSpace,
          ),
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
              TTicketTitleText(
                  title:
                      '${trip.start != null ? trip.start!.startProvince : ''} - ${trip.end != null ? trip.end!.endProvince : ''}'),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// -- Divider
              const Divider(),

              /// -- Ticket Details
              Row(

                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// -- Icon
                  const TicketDetailIcons(),
                  const SizedBox(width: TSizes.spaceBtwItems*2),
                  /// -- Details
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TicketTimeLocation(
                          time: trip.start != null
                              ? trip.start!.departureTime
                              : '',
                          location: trip.start != null
                              ? trip.start!.startLocation
                              : '',
                          province: trip.start != null
                              ? trip.start!.startProvince
                              : ''),
                      const SizedBox(height: TSizes.spaceBtwItems),
                      TicketTimeLocation(
                          time: trip.end != null ? trip.end!.arrivalTime : '',
                          location:
                              trip.end != null ? trip.end!.endLocation : '',
                          province:
                              trip.end != null ? trip.end!.endProvince : '')
                    ],
                  ),
                ],
              ),

              /// -- Divider
              const Divider(),

              /// -- Price and Button
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(category != null ? category.name : 'Unknown Category',
                    style: Theme.of(context).textTheme.titleMedium),
                Column(children: [
                  /// -- Price
                  TTicketPriceText(price: trip.getFormattedPrice()),

                  /// -- Button
                  BookButton(trip: trip)
                ]),
              ]),
            ],
          ),
        ),
      );
    });
  }
}

class BookButton extends StatelessWidget {
  const BookButton({
    super.key,
    required this.trip,
  });

  final TripModel trip;
  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(CartController());
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: TColors.primary,
        padding: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      onPressed: () {
        cartController.addItemToCart(trip);
      },
      child: Text(TTexts.bookTicket,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .apply(color: TColors.white)),
    );
  }
}
