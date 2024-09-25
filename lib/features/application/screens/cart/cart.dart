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
    final payment = Get.put(PaymentController());

    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
          title: Text('Book Tickets',
              style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: SingleChildScrollView(
        child: Padding(
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
                    Divider(),
                    TPaymentSection(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Obx(
              () {
            // Chỉ lắng nghe thay đổi từ totalCartPrice
            final totalAmount = cartController.totalCartPrice.value;
            final total = TFormatter.format(totalAmount);

            return ElevatedButton(
              onPressed: () async {
                if (_checkCartItemsDates(cartController.cartItems)) {
                  if (totalAmount > 0) {
                    // Xử lý thanh toán trước
                    bool paymentSuccess = await _processPayment(payment.selectedPaymentMethod.value, totalAmount);

                    if (paymentSuccess) {
                      // Chỉ xử lý đơn hàng và điều hướng nếu thanh toán thành công
                      orderController.processOrder(totalAmount);
                    } else {
                      TLoaders.customToast(
                        message: 'Payment was canceled or failed',
                      );
                    }

                  } else {
                    TLoaders.customToast(
                      message: 'Total amount must be greater than 0',
                    );
                  }
                } else {
                  TLoaders.customToast(
                    message: 'Please select a date for all items before checking out',
                  );
                }
              },


              child: Text('Check out $total'),
            );
              },
        ),
      ),
    );
  }
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
    await StripeService.instance.makePayment(totalAmount);  // Thực hiện thanh toán với Stripe
    return true; // Thanh toán thành công
  } catch (e) {
    // Nếu có lỗi hoặc bị hủy, in lỗi ra và trả về false
    print('Stripe payment failed or canceled: $e');
    return false; // Thanh toán thất bại hoặc bị hủy
  }
}


bool _checkCartItemsDates(List<CartItemModel> cartItems) {
  for (var item in cartItems) {
    if (item.date == null) {
      // Nếu có bất kỳ mục nào chưa chọn ngày, trả về false
      return false;
    }
  }
  // Nếu tất cả các mục đều đã chọn ngày, trả về true
  return true;

}




