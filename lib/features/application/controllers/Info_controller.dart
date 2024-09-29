import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutInfoController extends GetxController {
  // Controllers cho TextField
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  // Hàm khởi tạo để đặt giá trị mặc định cho các input
  void initializeUserInfo({required String fullName, required String phoneNumber}) {
    nameController.text = fullName;
    phoneController.text = phoneNumber;
  }

  // Hàm validate các field (đảm bảo người dùng đã điền đầy đủ thông tin)
  bool validateFields() {
    if (nameController.text.isEmpty || phoneController.text.isEmpty) {
      return false;
    }
    return true;
  }

  @override
  void onClose() {
    // Giải phóng tài nguyên khi không cần sử dụng nữa
    nameController.dispose();
    phoneController.dispose();
    super.onClose();
  }
}
