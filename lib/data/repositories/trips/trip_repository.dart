import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../features/application/models/trip_model.dart';
import '../../../features/application/models/station_model.dart';
import '../../../features/application/models/province_model.dart';
import '../../../features/application/models/category_model.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

class TripRepository extends GetxController {
  static TripRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Thêm chuyến đi mới và cập nhật TripCategory
  Future<void> addTripAndLinkToCategory(TripModel trip) async {
    try {
      // Thêm chuyến đi vào collection 'Trips'
      DocumentReference tripDoc = await _db.collection('Trips').add(trip.toJson());

      // Lấy ID của chuyến đi mới được tạo
      String tripId = tripDoc.id;

      // Tạo liên kết giữa tripId và categoryId trong TripCategory
      await _db.collection('TripCategory').add({
        'tripId': tripId,
        'categoryId': trip.categoryId,
      });

      Get.snackbar('Success', 'Trip and category linked successfully');
    } catch (e) {
      print('Error adding trip and linking category: $e');
      Get.snackbar('Error', 'Failed to add trip');
    }
  }

  // Get all trips
  Future<List<TripModel>> getAllTrips() async {
    try {
      final snapshot = await _db.collection('Trips').get();
      final list = snapshot.docs
          .map((document) => TripModel.fromSnapshot(document))
          .toList();
      return list;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
  Future<List<TripModel>> getTripForCategory({required String categoryId}) async {
    try {
      // Query to get all documents where categoryId matches the provided categoryId
      QuerySnapshot<Map<String, dynamic>> tripCategoryQuery = await _db
          .collection('TripCategory')
          .where('categoryId', isEqualTo: categoryId)
          .get();

      // Extract tripIds from the documents in TripCategory
      List<String> tripIds = tripCategoryQuery.docs.map((doc) => doc['tripId'] as String).toList();

      if (tripIds.isEmpty) {
        print('No tripIds found for categoryId: $categoryId');
        return [];
      }

      print('Trip IDs for categoryId $categoryId: $tripIds');

      // Query to get all trips where the tripId is in the list of tripIds
      QuerySnapshot<Map<String, dynamic>> tripsQuery = await _db
          .collection('Trips')
          .where(FieldPath.documentId, whereIn: tripIds)
          .get();

      print('Fetched trips for categoryId $categoryId: ${tripsQuery.docs.length}');
      tripsQuery.docs.forEach((doc) => print(doc.data()));

      // Extract trip models from the query results and filter by categoryId
      List<TripModel> trips = tripsQuery.docs
          .map((doc) => TripModel.fromSnapshot(doc))
          .where((trip) => trip.categoryId == categoryId)  // Lọc theo đúng categoryId
          .toList();

      return trips;
    } catch (e) {
      print('Error fetching trips for category: $e');
      return [];
    }
  }





  // Get all stations
  Future<List<StationModel>> getAllStations() async {
    try {
      final snapshot = await _db.collection('Station').get();
      final stations = snapshot.docs
          .map((doc) => StationModel.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
      return stations;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // Get all provinces
  Future<List<ProvinceModel>> getAllProvinces() async {
    try {
      final snapshot = await _db.collection('Provinces').get();
      final provinces = snapshot.docs
          .map((doc) => ProvinceModel.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
      return provinces;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // Get all categories
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final snapshot = await _db.collection('Categories').get();
      final categories = snapshot.docs
          .map((doc) => CategoryModel.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
      return categories;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
  Future<String> getStationNameById(String stationId) async {
    try {
      final doc = await _db.collection('Stations').doc(stationId).get();
      if (doc.exists && doc.data() != null) {
        final station = StationModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
        return station.name; // Trả về tên trạm nếu tìm thấy
      } else {
        return 'Unknown Station'; // Trạm không tồn tại
      }
    } catch (e) {
      print('Error fetching station name: $e');
      return 'Unknown Station'; // Xử lý lỗi bằng cách trả về chuỗi mặc định
    }
  }


  // Get province by ID
  Future<String> getProvinceNameById(String provinceId) async {
    try {
      final doc = await _db.collection('Provinces').doc(provinceId).get();
      if (doc.exists) {
        final province = ProvinceModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
        return province.name;
      } else {
        return 'Unknown Province';
      }
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }


  // Get category by ID
  Future<String> getCategoryNameById(String categoryId) async {
    try {
      final doc = await _db.collection('Categories').doc(categoryId).get();
      if (doc.exists) {
        final category = CategoryModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
        return category.name;
      } else {
        return 'Unknown Category';
      }
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
