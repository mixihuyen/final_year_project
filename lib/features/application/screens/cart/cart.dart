import 'package:final_year_project/common/widgets/appbar/appbar.dart';
import 'package:final_year_project/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:final_year_project/features/application/controllers/cart_controller.dart';
import 'package:final_year_project/features/application/controllers/payment_controller.dart';
import 'package:final_year_project/features/application/screens/cart/widgets/information_section.dart';
import 'package:final_year_project/features/application/screens/cart/widgets/payment_section.dart';
import 'package:final_year_project/features/application/screens/cart/widgets/cart_items.dart';
import 'package:final_year_project/features/application/screens/cart/widgets/total_section.dart';
import 'package:final_year_project/utils/formatters/forrmatter.dart';
import 'package:final_year_project/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../../common/widgets/success_screen/success_screen.dart';
import '../../../../data/services/stripe_service.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../../utils/validators/validation.dart';
import '../../../personalization/controllers/user_controller.dart';
import '../../controllers/Info_controller.dart';
import '../../controllers/order_controller.dart';
import '../../models/cart_item_model.dart';
import '../../models/payment_method_model.dart';
import '../../models/trip_model.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key, this.trip, this.cart});
  final TripModel? trip;
  final CartItemModel? cart;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final cartController = Get.put(CartController());
    final orderController = Get.put(OrderController());
    final paymentController = Get.put(PaymentController());
    final checkoutInfoController = Get.put(CheckoutInfoController());
    final userController = Get.put(UserController());

    return FutureBuilder(
      future: userController.fetchUserRecord(),  // Đảm bảo fetch lại dữ liệu trước khi hiển thị
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error loading user data'));
        } else {
          // Sau khi có dữ liệu người dùng, khởi tạo thông tin tạm thời
          checkoutInfoController.initializeUserInfo(
            fullName: userController.user.value.fullName,
            phoneNumber: userController.user.value.phoneNumber,
          );

          return Scaffold(
            appBar: AppBar(
              title: const Text('Book Tickets'),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Get.back(),
              ),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  const TCartItems(),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  TRoundedContainer(
                    showBorder: true,
                    padding: const EdgeInsets.all(TSizes.md),
                    backgroundColor: dark ? TColors.black : TColors.white,
                    child: const Column(
                      children: [
                        TTotalSection(),
                        Divider(),
                        TInformationSection(),
                        TPaymentSection(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Obx(() {
                final totalAmount = cartController.totalCartPrice.value;
                final total = TFormatter.format(totalAmount);

                return ElevatedButton(
                  onPressed: () async {
                    if (_checkCartItemsDates(cartController.cartItems)) {
                      if (totalAmount > 0) {
                        if (checkoutInfoController.validateFields()) {
                          final name = checkoutInfoController.nameController.text;
                          final phone = checkoutInfoController.phoneController.text;
                          // Kiểm tra số điện thoại
                          final phoneError = TValidator.validatePhoneNumber(phone);
                          if (phoneError != null) {
                            // Nếu số điện thoại không hợp lệ, hiển thị lỗi và dừng tiến trình
                            TLoaders.customToast(message: phoneError); // Hiển thị thông báo lỗi
                            return;
                          }

                          print('Proceeding to checkout with Name: $name, Phone: $phone');

                          bool paymentSuccess = await _processPayment(
                            paymentController.selectedPaymentMethod.value,
                            totalAmount,
                          );

                          if (paymentSuccess) {
                            orderController.processOrder(totalAmount, name: name, phone: phone);
                          } else {
                            TLoaders.customToast(message: 'Payment was canceled or failed');
                          }
                        } else {
                          TLoaders.customToast(message: 'Please enter your name and phone number.');
                        }
                      } else {
                        TLoaders.customToast(message: 'Please choose your seat before checking out.');
                      }
                    } else {
                      TLoaders.customToast(message: 'Please select a date for all items before checking out');
                    }
                  },
                  child: Text('Check out $total'),
                );
              }),
            ),
          );
        }
      },
    );
  }

  Future<bool> _processPayment(PaymentMethodModel paymentMethod, double totalAmount) async {
    if (paymentMethod.name == 'Stripe') {
      return await _processStripePayment(totalAmount);
    } else {
      TLoaders.customToast(message: 'Please select a valid payment method');
      return false;
    }
  }

  Future<bool> _processStripePayment(double totalAmount) async {
    try {
      print('Processing Stripe payment with amount: $totalAmount');
      await StripeService.instance.makePayment(totalAmount);
      return true;
    } catch (e) {
      print('Stripe payment failed or canceled: $e');
      return false;
    }
  }

  bool _checkCartItemsDates(List<CartItemModel> cartItems) {
    for (var item in cartItems) {
      if (item.date == null) {
        return false;
      }
    }
    return true;
  }
}





