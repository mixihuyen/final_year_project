import 'package:final_year_project/features/application/models/start_model.dart';

import '../../../utils/formatters/forrmatter.dart';
import 'end_model.dart';

class CartItemModel {
  String tripId;
  double price;
  String? category;
  StartModel? start;
  EndModel? end;
  int quantity;
  DateTime? date;

  CartItemModel({
    required this.tripId,
    required this.quantity,
    this.price = 0,
    this.category,
    this.start,
    this.end,
    this.date
});
  String getFormattedPrice() {
    return TFormatter.format(price * quantity);
  }

  static CartItemModel empty() => CartItemModel(tripId: '', quantity: 0);

  Map<String, dynamic> toJson() {
    return {
      'price': price,
      'category': category,
      'tripId': tripId,
      'start' : start!.toJson(),
      'end' : end!.toJson(),
      'quantity' : quantity,
      'date' : date?.toIso8601String(),
    };
  }

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      tripId: json['tripId'],
      quantity: json['quantity'],
      price: (json['price'] ?? 0).toDouble(),
      category: json['category'],
      start: json['start'] != null ? StartModel.fromJson(json['start']) : null,  // Chuyển từ JSON sang StartModel
      end: json['end'] != null ? EndModel.fromJson(json['end']) : null,          // Chuyển từ JSON sang EndModel
      date: json['date'] != null ? DateTime.parse(json['date']) : null,          // Kiểm tra null trước khi parse
    );
  }
}
