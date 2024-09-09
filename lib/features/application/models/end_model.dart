import 'package:cloud_firestore/cloud_firestore.dart';

class EndModel {
  String id;
  String endLocation;
  String arrivalTime;
  String endProvince;

  EndModel({
    required this.id,
    required this.endLocation,
    required this.arrivalTime,
    required this.endProvince,
  });
  static EndModel empty() => EndModel(endProvince: '', endLocation: '', arrivalTime: '', id: '');
  Map<String, dynamic> toJson() {
    return {
      'EndLocation': endLocation,
      'ArrivalTime': arrivalTime,
      'EndProvince': endProvince,
    };
  }

  factory EndModel.fromJson(Map<String, dynamic> document) {
      final data = document;
      if (data.isEmpty) return EndModel.empty();
      return EndModel(
        id: data['Id'] ?? '',
        endLocation: data['EndLocation'] ?? '',
        arrivalTime: data['ArrivalTime'] ?? '',
        endProvince: data['EndProvince'] ?? '',
      );
  }

  factory EndModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return EndModel(
        id: document.id,
        endLocation: data['EndLocation'] ?? '',
        arrivalTime: data['ArrivalTime'] ?? '',
        endProvince: data['EndProvince'] ?? '',
      );
    } else {
      return EndModel.empty();
    }
  }
}