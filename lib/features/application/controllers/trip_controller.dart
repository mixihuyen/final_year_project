import 'package:final_year_project/features/application/models/trip_model.dart';
import 'package:get/get.dart';

import '../../../data/repositories/trips/trip_repository.dart';
import '../../../utils/popups/loaders.dart';

class TripController extends GetxController {
  static TripController get instance => Get.find();

  RxList<TripModel> allTrips = <TripModel>[].obs;
  final isLoading = false.obs;
  final _tripRepository = Get.put(TripRepository());

  @override
  void onInit() {
    fetchAllTrips();
    super.onInit();
  }
  Future<void> fetchAllTrips() async {
    try {
      //Show loader while loading categories
      isLoading.value = true;

      // Fetch categories from data source (Firestore, API, ..)
      final trips = await _tripRepository.getAllTrips();

      //Update the category list
      allTrips.assignAll(trips);


    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}