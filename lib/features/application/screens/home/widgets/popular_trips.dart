import 'package:final_year_project/common/widgets/appbar/appbar.dart';
import 'package:final_year_project/common/widgets/section_heading.dart';
import 'package:final_year_project/features/application/screens/trips/allTrips.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../trips/widgets/ticket_card.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../controllers/trip_controller.dart';

class PopularTrips extends StatelessWidget {
  const PopularTrips({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TripController());
    return SingleChildScrollView(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        children: [
          Text(TTexts.popularTrips,
              style: Theme.of(context).textTheme.titleLarge),
          Obx(() {
            if (controller.isLoading.value) {
              // If loading, show a centered spinner
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.5, // Ensure spinner is centered
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            if (controller.allTrips.isEmpty) {
              return Center(
                child: Text(
                  "There are no Trips!",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              );
            }

            // Replace TGridLayout with ListView.builder
            return ListView.builder(
              shrinkWrap: true, // Ensures it only takes up the necessary space
              physics: const NeverScrollableScrollPhysics(), // Allows parent scrolling
              itemCount: controller.allTrips.length,
              itemBuilder: (context, index) {
                final trip = controller.allTrips[index];
                return TTicketCard(trip: trip);
              },
            );
          }),
        ],
      ),
    );
  }
}
