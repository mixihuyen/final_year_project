import 'package:get/get.dart';

import '../../features/application/controllers/trip_controller.dart';
import '../../features/application/models/category_model.dart';
import '../../features/application/models/province_model.dart';
import '../../features/application/models/station_model.dart';

class LocationHelper {
  // Hàm lấy tên station từ TripController
  static String getStationName(String? stationId) {
    final tripController = Get.find<TripController>();
    final StationModel? station = tripController.stations.firstWhereOrNull(
          (station) => station.id == stationId,
    );
    return station?.name ?? 'Unknown Station';
  }

  // Hàm lấy tên province từ TripController
  static String getProvinceName(String? provinceId) {
    final tripController = Get.find<TripController>();
    final ProvinceModel? province = tripController.provinces.firstWhereOrNull(
          (province) => province.id == provinceId,
    );
    return province?.name ?? 'Unknown Province';
  }
  static String getCategoryName(String? categoryId) {
    final tripController = Get.find<TripController>();
    final CategoryModel? category = tripController.categories.firstWhereOrNull(
          (category) => category.id == categoryId,
    );
    return category?.name ?? 'Unknown Category';
  }
}
