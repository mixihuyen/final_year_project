import 'package:final_year_project/features/application/models/trip_model.dart';
import 'package:final_year_project/features/application/models/category_model.dart';
import 'package:final_year_project/features/application/models/province_model.dart';
import 'package:final_year_project/features/application/models/station_model.dart';
import 'package:get/get.dart';
import '../../../data/repositories/trips/trip_repository.dart';
import '../../../utils/formatters/forrmatter.dart';
import '../../../utils/helpers/location_helper.dart';
import '../../../utils/popups/loaders.dart';

class TripController extends GetxController {
  static TripController get instance => Get.find();

  // Danh sách tất cả các chuyến đi
  RxList<TripModel> allTrips = <TripModel>[].obs;

  // Danh sách tất cả các category, province, và station
  RxList<CategoryModel> categories = <CategoryModel>[].obs;
  RxList<ProvinceModel> provinces = <ProvinceModel>[].obs;
  RxList<StationModel> stations = <StationModel>[].obs;
  var trips = <TripModel>[].obs;
  var filteredTrips = <TripModel>[].obs; // List to store filtered trips
  var searchQuery = ''.obs; // Search query

  final isLoading = false.obs;
  final _tripRepository = Get.put(TripRepository());

  @override
  void onInit() {
    super.onInit();
    fetchAllTrips();
    fetchAllCategories();
    fetchAllProvinces();
    fetchAllStations();
  }

  // Fetch tất cả các chuyến đi
  Future<void> fetchAllTrips() async {
    try {
      isLoading.value = true;
      final trips = await _tripRepository.getAllTrips();
      allTrips.assignAll(trips);
      filteredTrips.assignAll(trips); // Default to show all trips initially
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Fetch tất cả các categories
  Future<void> fetchAllCategories() async {
    try {
      final fetchedCategories = await _tripRepository.getAllCategories();
      categories.assignAll(fetchedCategories);
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  // Fetch tất cả các provinces
  Future<void> fetchAllProvinces() async {
    try {
      final fetchedProvinces = await _tripRepository.getAllProvinces();
      provinces.assignAll(fetchedProvinces);
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  // Fetch tất cả các stations
  Future<void> fetchAllStations() async {
    try {
      final fetchedStations = await _tripRepository.getAllStations();
      stations.assignAll(fetchedStations);
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  // Method to filter trips based on selected start and end stations
  void filter({String? selectedStartStation, String? selectedEndStation}) {
    if (selectedStartStation == null && selectedEndStation == null) {
      filteredTrips.assignAll(allTrips); // No filters, show all trips
    } else {
      filteredTrips.value = allTrips.where((trip) {
        final matchesStart = selectedStartStation == null ||
            trip.start?.startLocation == selectedStartStation;
        final matchesEnd = selectedEndStation == null ||
            trip.end?.endLocation == selectedEndStation;

        return matchesStart && matchesEnd;
      }).toList();
    }
  }
}

