import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project/features/application/models/start_model.dart';
import 'package:intl/intl.dart';

import '../../../common/widgets/tickets/ticket_location/ticket_location.dart';
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
  String getFormattedPrice() {
    final numberFormat = NumberFormat.currency(
      locale: 'vi_VN', // Đặt ngôn ngữ là tiếng Việt
      symbol: 'VND', // Đơn vị tiền tệ là VND
      decimalDigits: 0, // Số chữ số thập phân
    );
    return numberFormat.format(price);
  }
}
