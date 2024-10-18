import 'dart:ffi';

import 'package:final_year_project/data/repositories/user/user_repository.dart';
import 'package:final_year_project/features/personalization/controllers/user_controller.dart';
import 'package:final_year_project/features/personalization/screens/profile/profile.dart';
import 'package:final_year_project/features/personalization/screens/settings/setting.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../utils/constants/image_strings.dart';
import '../../../utils/helpers/network_manager.dart';
import '../../../utils/popups/fulll_screen_loader.dart';
import '../../../utils/popups/loaders.dart';
import '../../authentication/controllers/signup/signup_controller.dart';

class UpdateNameController extends GetxController{
  static UpdateNameController get instance => Get.find();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    initializeNames();
  }
  Future<void> initializeNames() async{
    firstName.text = userController.user.value.firstName;
    lastName.text = userController.user.value.lastName;
  }
  Future<void> updateUserName() async {
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
      if (!updateUserNameFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }
      //Update user's first & last name in the Firebase Firestore
      Map<String,dynamic> name = {'FirstName': firstName.text.trim(), 'LastName' : lastName.text.trim()};
      await userRepository.updateSingleField(name);

      userController.user.update((user) {
        user?.firstName = firstName.text.trim();
        user?.lastName = lastName.text.trim();
      });

      //Remove Loader
      TFullScreenLoader.stopLoading();

      Get.back();
      TLoaders.successSnackBar(title: 'Congratulation', message: 'Your Name has been update');



    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}