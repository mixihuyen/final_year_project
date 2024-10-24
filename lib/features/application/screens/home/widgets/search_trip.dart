import 'package:final_year_project/features/application/screens/home/widgets/search_page.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../../../utils/helpers/location_helper.dart';
import '../../../controllers/trip_controller.dart';
import '../../../models/station_model.dart';

class SearchTrip extends StatefulWidget {
  const SearchTrip({super.key});

  @override
  _SearchTripState createState() => _SearchTripState();
}

class _SearchTripState extends State<SearchTrip> {
  String? selectedStartStation;
  String? selectedEndStation;
  final TripController controller = Get.put(TripController());

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: dark ? TColors.textPrimary : TColors.white,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: TSizes.spaceBtwItems),
            Row(
              children: [
                Text(TTexts.titleSearch,
                    style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwItems),

            // Start Station Picker
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Iconsax.location),
              title: Text(TTexts.pickUpPoint,
                  style: Theme.of(context).textTheme.labelMedium),
              subtitle: Text(
                _getStationName(selectedStartStation),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () => _selectStartStation(),
            ),
            const Divider(),

            // End Station Picker
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Iconsax.send_1),
              title: Text(TTexts.destination,
                  style: Theme.of(context).textTheme.labelMedium),
              subtitle: Text(
                _getStationName(selectedEndStation),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () => _selectEndStation(),
            ),
            const SizedBox(height: TSizes.spaceBtwItems),

            // Search Button
            Row(
              children: [

                // Search button
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: TColors.primary,
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                      onPressed: () {
                        // Apply filtering logic with selected parameters
                        controller.filter(
                          selectedStartStation: selectedStartStation,
                          selectedEndStation: selectedEndStation,
                        );
                        // Navigate to SearchPage with filtered trips
                        Get.to(() => SearchPage());
                      },
                      child: Text(
                        TTexts.search,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .apply(color: TColors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  static String _getStationName(String? stationId) {
    final tripController = Get.find<TripController>();
    final StationModel? station = tripController.stations.firstWhereOrNull(
          (station) => station.id == stationId,
    );
    return station?.name ?? 'Select Station';
  }

  // Method to select start station
  void _selectStartStation() async {
    final String? station = await showModalBottomSheet<String>(
      context: context,
      builder: (BuildContext context) {
        return ListView(
          children: controller.stations.map((station) {
            return ListTile(
              title: Text(
                  '${LocationHelper.getStationName(station.id)} (${LocationHelper.getProvinceName(station.provinceId)})'),
              onTap: () => Navigator.pop(context, station.id),
            );
          }).toList(),
        );
      },
    );

    if (station != null) {
      setState(() {
        selectedStartStation = station;
      });
    }
  }

  // Method to select end station
  void _selectEndStation() async {
    final String? station = await showModalBottomSheet<String>(
      context: context,
      builder: (BuildContext context) {
        return ListView(
          children: controller.stations.map((station) {
            return ListTile(
              title: Text(
                  '${LocationHelper.getStationName(station.id)} (${LocationHelper.getProvinceName(station.provinceId)})'),
              onTap: () => Navigator.pop(context, station.id),
            );
          }).toList(),
        );
      },
    );

    if (station != null) {
      setState(() {
        selectedEndStation = station;
      });
    }
  }
}
