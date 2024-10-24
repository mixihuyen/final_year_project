import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/widgets/icons/t_ticket_icon.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/trip_controller.dart';
import '../../trips/widgets/ticket_card.dart';
import '../widgets/search_trip.dart';

class SearchPage extends StatelessWidget {
  SearchPage({super.key});

  final TripController controller = Get.put(TripController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Results'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              children: [
                Expanded(
                  child: _buildTripCards(context),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // Bố cục thẻ (Card) cho các chuyến đi
  Widget _buildTripCards(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Obx(() {
      final trips = controller.filteredTrips;

      if (trips.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.search_off,
                size: 80,
                color: Colors.grey,
              ),
              const SizedBox(height: 16),
              Text(
                'No trips match.',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Can you try turning off the filter and searching again?',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      }

      return ListView.builder(
        itemCount: trips.length,
        itemBuilder: (context, index) {
          final trip = trips[index];
          return TTicketCard(trip: trip);
        },
      );
    });
  }
}
