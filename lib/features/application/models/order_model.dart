import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project/features/authentication/model/user_model.dart';
import 'package:final_year_project/utils/helpers/helper_functions.dart';

import 'cart_item_model.dart';

class OrderModel {
  final String id;
  final String userId;
  final double totalAmount;
  final DateTime orderDate;
  final String paymentMethod;
  final String name;
  final String phoneNumber;
  final List<CartItemModel> items;
  OrderModel ({
    required this.id,
    required this.userId,
    required this.totalAmount,
    required this.items,
    required this.orderDate,
    this.paymentMethod = 'Paypal',
    required this.name,
    required this.phoneNumber,
});
  String get formattedOrderDate => THelperFunctions.getFormattedDate(orderDate);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'totalAmount': totalAmount,
      'orderDate': orderDate,
      'paymentMethod': paymentMethod,
      'name': name,
      'phoneNumber': phoneNumber,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }

  factory OrderModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return OrderModel(
      id: data['id'] as String,
      userId: data['userId'] as String,
      totalAmount: data['totalAmount'] as double,
      orderDate: (data['orderDate'] as Timestamp).toDate(),  // Chuyển Timestamp sang DateTime
      paymentMethod: data['paymentMethod'] as String,
      name: data['name'] as String,
      phoneNumber: data['phoneNumber'] as String,
      items: (data['items'] as List<dynamic>)
          .map((item) => CartItemModel.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}