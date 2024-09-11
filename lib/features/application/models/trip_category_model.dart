import 'package:cloud_firestore/cloud_firestore.dart';

class TripCategoryModel {
  final String tripId;
  final String categoryId;

  TripCategoryModel ({
    required this.tripId,
    required this.categoryId,
});
  Map<String, dynamic> toJson() {
    return {
      'tripId' : tripId,
      'categoryId' : categoryId,
    };
  }
  factory TripCategoryModel.fromSnapshot(DocumentSnapshot document) {
      final data = document.data() as Map<String, dynamic>;
      return TripCategoryModel(
        tripId: data['tripId'] as String,
        categoryId: data['categoryId'] as String,
      );
  }
}