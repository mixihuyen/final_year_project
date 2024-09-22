import 'package:final_year_project/data/repositories/authentication/authentication_repository.dart';
import 'package:final_year_project/data/repositories/user/user_repository.dart';
import 'package:final_year_project/features/application/controllers/cart_controller.dart';
import 'package:final_year_project/features/application/controllers/payment_controller.dart';
import 'package:final_year_project/features/personalization/controllers/user_controller.dart';
import 'package:final_year_project/utils/constants/image_strings.dart';
import 'package:final_year_project/utils/popups/fulll_screen_loader.dart';
import 'package:final_year_project/utils/popups/loaders.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../common/widgets/success_screen/success_screen.dart';
import '../../../data/repositories/order/order_repository.dart';
import '../../../navigation_menu.dart';
import '../../authentication/model/user_model.dart';
import '../models/order_model.dart';

class OrderController extends GetxController {
  static OrderController get instance => Get.find();

  final paymentController = Get.put(PaymentController());
  final userController =  Get.put(UserController());
  final cartController = Get.put(CartController());
  final orderRepository = Get.put(OrderRepository());

  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final userOrders = await orderRepository.fetchUserOrders();
      return userOrders;
    } catch (e) {
      TLoaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  void processOrder(double totalAmount) async {
    try {
      TFullScreenLoader.openLoadingDialog('Processing your order', TImages.animation);

      final userId = AuthenticationRepository.instance.authUser.uid;
      if (userId.isEmpty) return;

      // Lấy thông tin người dùng: họ tên và số điện thoại
      final userInfo = userController.getUserFullNameAndPhoneNumber();
      final fullName = userInfo['fullName'];
      final phoneNumber = userInfo['phoneNumber'];


      // Tạo đơn hàng mới
      final order = OrderModel(
        id: UniqueKey().toString(),
        userId: userId,
        totalAmount: totalAmount,
        orderDate: DateTime.now(),
        paymentMethod: paymentController.selectedPaymentMethod.value.name,
        name: fullName,
        phoneNumber: phoneNumber,
        items: cartController.cartItems.toList(),
      );

      // Lưu đơn hàng vào Firestore
      await orderRepository.saveOrder(order, userId);

      // Chuyển đến màn hình thành công sau khi thanh toán
      Get.off(() => SuccessScreen(
        image: TImages.successfulPayment,
        title: 'Payment Success!',
        subTitle: 'Your ticket is ready!',
        onPressed: () => Get.offAll(() => const NavigationMenu()),
      ));
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }


}