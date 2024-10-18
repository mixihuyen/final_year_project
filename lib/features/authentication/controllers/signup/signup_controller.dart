import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:final_year_project/data/repositories/authentication/authentication_repository.dart';
import 'package:final_year_project/data/repositories/user/user_repository.dart';
import 'package:final_year_project/features/authentication/screens/signup/ver%C3%ACfy_email.dart';
import 'package:final_year_project/utils/constants/image_strings.dart';
import 'package:final_year_project/utils/popups/fulll_screen_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/loaders.dart';
import '../../model/user_model.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  final hidePassword = true.obs;
  final privacyPolicy = true.obs;
  final email = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
  final phoneNumber = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();


  void signup() async {
    try {
      // Start Loading
      TFullScreenLoader.openLoadingDialog(
          'We are processing your information', TImages.animation);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }


      // Form Validation
      if (!signupFormKey.currentState!.validate())
      {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Privacy Policy Check
      if (!privacyPolicy.value) {
        TLoaders.warningSnackBar(
            title: 'Accept Privacy Policy',
            message: 'You must have read and accept the Privacy Policy & Terms of Use.');
        TFullScreenLoader.stopLoading();
        return;
      }

      // Register user in the Firebase Authentication & Save user data in the Firebase
      final userCredential = await AuthenticationRepository.instance.registerWithEmailAndPassword(email.text.trim(), password.text.trim());

      // Save Authenticated user data in the Firebase Firestore
      final newUser = UserModel(
          id: userCredential.user!.uid,
          firstName: firstName.text.trim(),
          lastName: lastName.text.trim(),
          username: username.text.trim(),
          phoneNumber: phoneNumber.text.trim(),
          email: email.text.trim(),
          profilePicture: '');

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      TFullScreenLoader.stopLoading();

      // // Show Success Message
      // TLoaders.successSnackBar(title: 'Congratulation', message: 'Your account has been created! Verify email to continue.');

      // Move to Verify Email Screen
      Get.to(() =>  VerifyEmailScreen(email: email.text.trim()));

    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}

