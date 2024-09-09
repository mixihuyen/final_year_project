import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project/features/application/models/trip_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

class TripRepository extends GetxController {
  static TripRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  // Get all trips
  Future<List<TripModel>> getAllTrips() async {
    try {
      final snapshot = await _db.collection('Trips').get();
      final list = snapshot.docs.map((document) =>
          TripModel.fromSnapshot(document)).toList();
      return list;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}