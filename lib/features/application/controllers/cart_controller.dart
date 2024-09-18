import 'package:final_year_project/common/widgets/select_date/select_date.dart';
import 'package:final_year_project/features/application/models/trip_model.dart';
import 'package:final_year_project/utils/popups/loaders.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/cart_item_model.dart';
import '../screens/cart/cart.dart';

class CartController extends GetxController {
  static CartController get instance => Get.find();

  RxDouble totalCartPrice = 0.0.obs;
  RxInt quantityTicket = 0.obs;
  RxList<CartItemModel> cartItems = <CartItemModel>[].obs;

  // CartController() {
  //
  // }

  CartItemModel convertToCartItem(TripModel trip, int quantity) {
    return CartItemModel(
      tripId: trip.id,
      price: trip.price,
      quantity: 1,
      category: trip.categoryId, // Gán trực tiếp categoryId
      start: trip.start,         // Sử dụng start là đối tượng StartModel từ trip
      end: trip.end,             // Sử dụng end là đối tượng EndModel từ trip
      date: null
    );
  }


  void addItemToCart(TripModel trip) {
     final selectedCartItem = convertToCartItem(trip, quantityTicket.value);
     cartItems.add(selectedCartItem);
     updateCart();
     Get.to(() => CartScreen(trip: trip));
  }

  // Hàm cập nhật tổng giá trị của giỏ hàng
  void _updateTotalCartPrice() {
    totalCartPrice.value = 0.0;
    for (var item in cartItems) {
      totalCartPrice.value += item.price * item.quantity;
    }
  }

  // Xóa một mục khỏi giỏ hàng
  void removeItemFromCart(String tripId) {
    cartItems.removeWhere((item) => item.tripId == tripId);
    _updateTotalCartPrice();
  }

  // Xóa tất cả các mục trong giỏ hàng
  void clearCart() {
    cartItems.clear();
    totalCartPrice.value = 0.0;
  }
  void updateQuantity(CartItemModel cartItem, int change) {
    int newQuantity = cartItem.quantity + change;
    if (newQuantity <= 0) {
      cartItems.remove(cartItem);
      Get.back();// Xoá mục khỏi giỏ nếu số lượng <= 0
    } else {
      cartItem.quantity = newQuantity;
      cartItems.refresh(); // Cập nhật lại giỏ hàng
    }
  }

  void  updateCart() {
    _updateTotalCartPrice();
    cartItems.refresh();
  }
  void datePick(BuildContext context, CartItemModel cartItem) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      // Cập nhật ngày đã chọn vào CartItemModel
      cartItem.date = selectedDate;
      cartItems.refresh(); // Cập nhật lại giỏ hàng
    }
  }



}