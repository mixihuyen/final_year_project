import 'package:final_year_project/consts.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import '../features/authentication/controllers/signup/signup_controller.dart';

class GeneralBindings extends Bindings {

  @override
  void dependencies() {
    Get.put(NetworkManager());
    Stripe.publishableKey = stripePublishableKey;
  }
}