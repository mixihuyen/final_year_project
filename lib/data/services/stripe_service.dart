import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import '../../consts.dart';  // Đảm bảo rằng bạn đã thêm khóa bí mật của Stripe trong consts.dart

class StripeService {
  StripeService._();

  static final StripeService instance = StripeService._();

  // Hàm chính để thực hiện thanh toán, với số tiền bằng VND
  Future<void> makePayment(double vndAmount) async {
    try {
      // Bước 1: Chuyển đổi VND sang USD
      double usdAmount = await _convertVndToUsd(vndAmount);

      // Bước 2: Tạo Payment Intent trên Stripe
      String? paymentIntentClientSecret = await _createPaymentIntent(usdAmount, 'USD');
      if (paymentIntentClientSecret == null) return;

      // Bước 3: Khởi tạo Payment Sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentClientSecret,
          merchantDisplayName: "Your Merchant Name",
        ),
      );

      // Bước 4: Hiển thị Payment Sheet
      await _processPayment();
    } catch (e) {
      print("Error: $e");
      throw "Payment was canceled";
    }
  }

  // Hàm tạo Payment Intent trên Stripe
  Future<String?> _createPaymentIntent(double amount, String currency) async {
    try {
      final Dio dio = Dio();
      Map<String, dynamic> data = {
        "amount": _calculateAmount(amount),
        "currency": currency,
      };
      var response = await dio.post(
        'https://api.stripe.com/v1/payment_intents',
        data: data,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {
            "Authorization": "Bearer $stripeSecretKey",  // Đảm bảo rằng $stripeSecretKey được khai báo trong consts.dart
            "Content-Type": 'application/x-www-form-urlencoded',
          },
        ),
      );
      if (response.data != null) {
        return response.data["client_secret"];
      }
    } catch (e) {
      print("Error creating payment intent: $e");
    }
    return null;
  }

  Future<void> _processPayment() async {
    try {
      // Hiển thị Payment Sheet để người dùng thực hiện thanh toán
      await Stripe.instance.presentPaymentSheet();


    } catch (e) {
      throw "Error processing payment: $e";
    }
  }




  // Hàm chuyển đổi từ VND sang USD
  Future<double> _convertVndToUsd(double vndAmount) async {
    // Giả sử tỷ giá hiện tại là 1 USD = 24000 VND.
    // Thay bằng việc gọi API lấy tỷ giá thực tế nếu cần.
    const double exchangeRate = 24000.0;
    double usdAmount = vndAmount / exchangeRate;
    return usdAmount;
  }

  // Hàm tính số tiền (USD) thành cent (số tiền nhỏ nhất của Stripe là cent)
  String _calculateAmount(double amount) {
    final calculatedAmount = (amount * 100).toInt();  // Convert USD to cents
    return calculatedAmount.toString();
  }
}
