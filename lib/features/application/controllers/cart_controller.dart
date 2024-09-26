import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/cart_item_model.dart';
import '../models/order_model.dart';
import '../models/trip_model.dart';
import '../screens/cart/cart.dart';

class CartController extends GetxController {
  static CartController get instance => Get.find();

  final Query<Map<String, dynamic>> ordersRef = FirebaseFirestore.instance.collectionGroup('Orders');

  RxDouble totalCartPrice = 0.0.obs;
  RxInt quantityTicket = 0.obs;
  RxList<CartItemModel> cartItems = <CartItemModel>[].obs;
  RxMap<DateTime, List<String>> unavailableSeatsByDate = <DateTime, List<String>>{}.obs;

  // Chuyển đổi Trip thành CartItem
  CartItemModel convertToCartItem(TripModel trip, int quantity) {
    return CartItemModel(
      tripId: trip.id,
      price: trip.price,
      quantity: quantity,
      category: trip.categoryId,
      start: trip.start,
      end: trip.end,
      date: null,
      selectedSeats: [],
    );
  }

  // Thêm mục vào giỏ hàng
  void addItemToCart(TripModel trip) {
    final selectedCartItem = convertToCartItem(trip, quantityTicket.value);
    cartItems.add(selectedCartItem);
    _updateTotalCartPrice();
    cartItems.refresh();
    Get.to(() => CartScreen(trip: trip));
  }

  // Cập nhật tổng giá của giỏ hàng
  void _updateTotalCartPrice() {
    totalCartPrice.value = 0.0;
    for (var item in cartItems) {
      totalCartPrice.value += item.price * item.quantity;
    }
  }

  // Xóa mục khỏi giỏ hàng
  void removeItemFromCart(String tripId) {
    cartItems.removeWhere((item) => item.tripId == tripId);
    _updateTotalCartPrice();
  }

  // Xóa toàn bộ giỏ hàng
  void clearCart() {
    cartItems.clear();
    totalCartPrice.value = 0.0;
  }

  // Cập nhật số lượng vé
  void updateQuantityBasedOnSeats(CartItemModel cartItem) {
    cartItem.quantity = cartItem.selectedSeats.length;
    _updateTotalCartPrice();
    cartItems.refresh(); // Làm mới giao diện
  }

  // Lấy danh sách ghế đã mua từ tất cả người dùng cho một chuyến đi và ngày cụ thể
  Future<List<String>> getPurchasedSeats(String tripId, DateTime date) async {
    List<String> purchasedSeats = [];

    // Truy vấn tất cả các đơn hàng từ collectionGroup 'Orders'
    QuerySnapshot<Map<String, dynamic>> ordersSnapshot = await ordersRef.get();

    print("Number of orders found: ${ordersSnapshot.docs.length}");

    // Duyệt qua tất cả các đơn hàng
    for (QueryDocumentSnapshot<Map<String, dynamic>> doc in ordersSnapshot.docs) {
      OrderModel order = OrderModel.fromSnapshot(doc);

      // Duyệt qua các items trong mỗi đơn hàng
      for (CartItemModel item in order.items) {
        // Kiểm tra xem tripId và ngày có khớp không
        if (item.tripId == tripId && item.date != null && item.date!.isAtSameMomentAs(date)) {
          print("Found purchased seats: ${item.selectedSeats}");
          purchasedSeats.addAll(item.selectedSeats); // Lấy các ghế đã mua
        }
      }
    }

    print("Purchased seats: $purchasedSeats");
    return purchasedSeats.toSet().toList(); // Đảm bảo không có ghế trùng lặp
  }

  // Lấy danh sách các ghế không khả dụng cho ngày được chọn
  Future<List<String>> getUnavailableSeats(String tripId, DateTime? date) async {
    if (date == null) return [];

    // Lấy các ghế đã mua từ Firestore
    List<String> purchasedSeats = await getPurchasedSeats(tripId, date);

    return purchasedSeats.toSet().toList(); // Đảm bảo không có ghế trùng lặp
  }

  // Định nghĩa phương thức `selectSeat` để chọn ghế
  void selectSeat(CartItemModel cartItem, String seat, bool isSelected) {
    // Kiểm tra nếu ngày đã được chọn
    if (cartItem.date == null) {
      Get.snackbar('Select a date first', 'Please select a date before choosing seats.');
      return;
    }

    // Thêm hoặc xóa ghế đã chọn
    if (isSelected) {
      cartItem.selectedSeats.add(seat); // Thêm ghế vào danh sách nếu được chọn
    } else {
      cartItem.selectedSeats.remove(seat); // Loại bỏ ghế nếu bỏ chọn
    }
    updateQuantityBasedOnSeats(cartItem);
    cartItems.refresh(); // Làm mới giao diện sau khi chọn ghế
  }

  // Mở DatePicker để chọn ngày
  Future<void> datePick(BuildContext context, CartItemModel cartItem) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)), // Bắt đầu từ ngày mai
      firstDate: DateTime.now().add(const Duration(days: 1)),  // Không cho phép chọn ngày hôm nay
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      cartItem.date = selectedDate;
      cartItems.refresh();
    }
  }

}
