import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StartModel {
  String id;
  String startLocation;
  String departureTime;
  String startProvince;


  StartModel({
    required this.id,
    required this.startLocation,
    required this.departureTime,
    required this.startProvince,

  });
  static StartModel empty() => StartModel(startLocation: '', departureTime: '', startProvince: '', id: '');

  // Phương thức chuyển đổi đối tượng thành JSON để lưu trữ
  Map<String, dynamic> toJson() {
    return {
      'StartLocation': startLocation,

      'DepartureTime': departureTime,

      'StartProvince': startProvince,
    };
  }

  factory StartModel.fromJson(Map<String, dynamic> document) {
    final data = document;
    if (data.isEmpty) return StartModel.empty();
    return StartModel(
      id: data['Id'] ?? '',
      startLocation: data['StartLocation'] ?? '',
      departureTime: data['DepartureTime'] ?? '',
      startProvince: data['StartProvince'] ?? '',
    );
  }

  factory StartModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return StartModel(
        id: document.id,
        startLocation: data['StartLocation'] ?? '',
        departureTime: data['DepartureTime'] ?? '',
        startProvince: data['StartProvince'] ?? '',
      );
    } else {
      return StartModel.empty();
    }
  }

}
