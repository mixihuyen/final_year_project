import 'package:final_year_project/common/widgets/appbar/appbar.dart';
import 'package:final_year_project/common/widgets/section_heading.dart';
import 'package:final_year_project/features/application/screens/trips/allTrips.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../common/widgets/layouts/grid_layout.dart';
import '../../trips/widgets/ticket_card.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../controllers/trip_controller.dart';
import '../../../models/trip_model.dart';

class PopularTrips extends StatelessWidget {
  const PopularTrips({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TripController());
    return SingleChildScrollView(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(children: [
          Text(TTexts.popularTrips,
              style: Theme.of(context).textTheme.titleLarge),
          Obx(() {
            if (controller.isLoading.value) {
              // Nếu đang tải, hiển thị spinner ở trung tâm
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.5, // Đảm bảo chiều cao đủ lớn để spinner nằm giữa
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            if (controller.allTrips.isEmpty) {
              return Center(
                  child: Text("There are no Trips!.",
                      style: Theme.of(context).textTheme.bodyMedium));
            }
            return TGridLayout(
                itemCount: controller.allTrips.length,
                itemBuilder: (_, index) =>
                    TTicketCard(trip: controller.allTrips[index]));
          }),
        ]));
  }
}
