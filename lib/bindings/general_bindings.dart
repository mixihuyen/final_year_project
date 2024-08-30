import 'package:get/get.dart';
import '../features/authentication/controllers/signup/signup_controller.dart';

class GeneralBindings extends Bindings {

  @override
  void dependencies() {
    Get.put(NetworkManager());
  }
}