import 'package:final_year_project/consts.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import '../features/authentication/controllers/signup/signup_controller.dart';
import '../utils/helpers/network_manager.dart';

class GeneralBindings extends Bindings {

  @override
  void dependencies() {
    Get.put(NetworkManager());
    Stripe.publishableKey = stripePublishableKey;
  }
}