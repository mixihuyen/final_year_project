import 'package:final_year_project/features/personalization/controllers/user_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../data/repositories/user/user_repository.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/helpers/network_manager.dart';
import '../../../utils/popups/fulll_screen_loader.dart';
import '../../../utils/popups/loaders.dart';
import '../../authentication/controllers/signup/signup_controller.dart';
import '../screens/settings/setting.dart';

class UpdatePhoneNumberController extends GetxController{
  static UpdatePhoneNumberController get instance => Get.find();

  final phoneNumber = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updatePhoneNumberFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    initializeNames();
  }
  Future<void> initializeNames() async{
    phoneNumber.text = userController.user.value.phoneNumber;
  }
  Future<void> updatePhoneNumber() async {
    try {
      TFullScreenLoader.openLoadingDialog(
          'We are updating your information...', TImages.animation);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }
      // Form Validation
      if (!updatePhoneNumberFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }
      //Update user's first & last name in the Firebase Firestore
      Map<String,dynamic> name = {'PhoneNumber' : phoneNumber.text.trim()};
      await userRepository.updateSingleField(name);

      userController.user.update((user) {
        user?.phoneNumber = phoneNumber.text.trim();
      });


      //Remove Loader
      TFullScreenLoader.stopLoading();
      Get.back();
      TLoaders.successSnackBar(title: 'Congratulation', message: 'Your Phone Number has been update');


    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}