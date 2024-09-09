import 'package:final_year_project/features/application/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../../common/widgets/tickets/ticket_card/ticket_card.dart';
import '../../../controllers/trip_controller.dart';
class TTripTab extends StatelessWidget {
  const TTripTab({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller  = Get.put(TripController());
    return Padding(
        padding: const EdgeInsets.only(right: 20),
        child: Obx( () {
          if(controller.isLoading.value) return const Center(child: CircularProgressIndicator());
          if (controller.allTrips.isEmpty) {
            return  Center(child: Text("There are no Trips!.",style: Theme.of(context).textTheme.bodyMedium));
          }
          return TGridLayout(
              itemCount: controller.allTrips.length, itemBuilder: (_, index) => TTicketCard(trip: controller.allTrips[index]));
        })
    );
  }
}
