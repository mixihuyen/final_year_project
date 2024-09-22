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
  Future<List<TripModel>> getTripForCategory ({required String categoryId}) async {
    try {
      //Query to get all documents where tripId matches provided categoryId
      QuerySnapshot tripCategoryQuery = await _db.collection('TripCategory').where('categoryId', isEqualTo: categoryId).get();
      // Extract tripIds from the document
      List<String> tripIds = tripCategoryQuery.docs.map((doc) => doc['tripId'] as String).toList();
      // Query to get all document where the tripId is in the list of tripIds, FieldPath.documentId to query documents in Collection
      final tripsQuery = await _db.collection('Trips').where(FieldPath.documentId, whereIn: tripIds).limit(2).get();
      //Extract trip name or other relevant data from the documents
      List<TripModel> trips = tripsQuery.docs.map((doc) => TripModel.fromSnapshot(doc)).toList();

      return trips;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}