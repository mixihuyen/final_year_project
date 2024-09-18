import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project/features/application/models/start_model.dart';
import 'package:intl/intl.dart';

import '../../../common/widgets/tickets/ticket_location/ticket_location.dart';
import '../../../utils/formatters/forrmatter.dart';
import 'end_model.dart';

class TripModel {
  String id;
  double price;
  String? categoryId;
  int seatsAvailable;
  StartModel? start;
  EndModel? end;


  TripModel({
    required this.id,
    required this.price,
    this.categoryId,
    required this.seatsAvailable,
    this.start,
    this.end
  });
  String getFormattedPrice() {
    return TFormatter.format(price);
  }

  /// Phương thức để tạo một đối tượng TripModel rỗng
  static TripModel empty() => TripModel(
    id: '',
    price: 0,
    categoryId: '',
    seatsAvailable: 0,

  );

  /// Chuyển đổi TripModel sang JSON để lưu trữ trong Firestore
  Map<String, dynamic> toJson() {
    return {
      'Price': price,
      'CategoryId': categoryId,
      'SeatsAvailable': seatsAvailable,
      'Start' : start!.toJson(),
      'End' : end!.toJson()
    };
  }

  /// Chuyển từ dữ liệu Firestore snapshot thành một đối tượng TripModel
  factory TripModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() == null) return TripModel.empty();
    final data = document.data()!;
    return TripModel(
      id: document.id,
      price: double.parse((data['Price'] ?? 0).toString()),
      categoryId: data['CategoryId'] ?? '',
      seatsAvailable: data['SeatsAvailable'] ?? 0,
      start: StartModel.fromJson(data['Start']),
      end: EndModel.fromJson(data['End'])
    );
  }
}
