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
  List<String> selectedSeats;

  CartItemModel({
    required this.tripId,
    required this.quantity,
    this.price = 0,
    this.category,
    this.start,
    this.end,
    this.date,
    required this.selectedSeats,
  });

  String getFormattedPrice() {
    return TFormatter.format(price * quantity);
  }

  void setSeat(String seat) {
    selectedSeats.add(seat);
  }

  void removeSeat(String seat) {
    selectedSeats.remove(seat);
  }

  static CartItemModel empty() => CartItemModel(tripId: '', quantity: 0, selectedSeats: []);

  Map<String, dynamic> toJson() {
    return {
      'price': price,
      'category': category,
      'tripId': tripId,
      'start': start?.toJson(),
      'end': end?.toJson(),
      'quantity': quantity,
      'date': date?.toIso8601String(),
      'selectedSeats': selectedSeats,
    };
  }

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      tripId: json['tripId'],
      quantity: json['quantity'],
      price: (json['price'] ?? 0).toDouble(),
      category: json['category'],
      start: json['start'] != null ? StartModel.fromJson(json['start']) : null,
      end: json['end'] != null ? EndModel.fromJson(json['end']) : null,
      date: json['date'] != null ? DateTime.parse(json['date']) : null,
      selectedSeats: List<String>.from(json['selectedSeats'] ?? []),
    );
  }
}
