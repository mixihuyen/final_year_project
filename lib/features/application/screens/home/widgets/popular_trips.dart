import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../../common/widgets/tickets/ticket_card/ticket_card.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/trip_controller.dart';
import '../../../models/trip_model.dart';

class PopularTrips extends StatelessWidget {
  const PopularTrips({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TripController());
    return SingleChildScrollView(
        padding: const EdgeInsets.only(right: 20),
        child: Obx(() {
          if (controller.isLoading.value) return const Center(child: CircularProgressIndicator());
          if (controller.allTrips.isEmpty) {
            return Center(
                child: Text("There are no Trips!.",
                    style: Theme.of(context).textTheme.bodyMedium));
          }
          return TGridLayout(
              itemCount: controller.allTrips.length,
              itemBuilder: (_, index) =>
                  TTicketCard(trip: controller.allTrips[index]));
        }));
  }
}
