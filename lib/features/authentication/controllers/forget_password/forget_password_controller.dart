import 'package:final_year_project/data/repositories/authentication/authentication_repository.dart';
import 'package:final_year_project/features/authentication/screens/password_configuration/reset_password.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/fulll_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';
import '../signup/signup_controller.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  sendEmailResetPassword() async {
    try {
      // Start Loading
      TFullScreenLoader.openLoadingDialog(
          'Processing your request...', TImages.animation);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!forgetPasswordFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }
      // Send Email to reset password
      await AuthenticationRepository.instance.sendPasswordResetEmail(email.text.trim());

      TFullScreenLoader.stopLoading();

      // Show Success Message
      TLoaders.successSnackBar(
          title: 'Email Sent',
          message: 'Email Link Sent to Reset your Password'.tr);

      //Redirect
      Get.to(() => ResetPassword(email: email.text.trim()));
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  resendEmailResetPassword(String email) async {
    try {
      // Start Loading
      TFullScreenLoader.openLoadingDialog(
          'Processing your request...', TImages.animation);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Send Email to reset password
      await AuthenticationRepository.instance.sendPasswordResetEmail(email);

      TFullScreenLoader.stopLoading();

      // Show Success Message
      TLoaders.successSnackBar(
          title: 'Email Sent',
          message: 'Email Link Sent to Reset your Password'.tr);

    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
