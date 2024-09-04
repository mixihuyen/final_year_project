
import 'package:final_year_project/data/repositories/authentication/authentication_repository.dart';
import 'package:final_year_project/data/repositories/user/user_repository.dart';
import 'package:final_year_project/features/application/screens/trips/allTrips.dart';
import 'package:final_year_project/features/authentication/screens/login/login.dart';
import 'package:final_year_project/utils/popups/loaders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/popups/fulll_screen_loader.dart';
import '../../authentication/controllers/signup/signup_controller.dart';
import '../../authentication/model/user_model.dart';
import '../screens/profile/widgets/re_authenricate_user_login_form.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  Rx<UserModel> user = UserModel.empty().obs;

  final imageLoading = false.obs;
  final hidePassword = false.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    try {
      // First Update Rx User and check if user data is already store. if not store new data
      await fetchUserRecord();

      //If not record already stored.
      if(user.value.id.isEmpty) {
        if (userCredentials != null) {
          // Convert Name to First and Last Name
          final nameParts = UserModel.nameParts(
              userCredentials.user!.displayName ?? '');
          final username = UserModel.generateUsername(
              userCredentials.user!.displayName ?? '');

          //Map data
          final user = UserModel(id: userCredentials.user!.uid,
            firstName: nameParts[0],
            lastName: nameParts.length > 1? nameParts.sublist(1).join(' ') : '',
            username: username,
            phoneNumber: userCredentials.user!.phoneNumber ?? '',
            email: userCredentials.user!.email ?? '',
            profilePicture: userCredentials.user!.photoURL ?? '',
          );
          // Save user data
          await userRepository.saveUserRecord(user);
        }
      }
    } catch (e) {
      TLoaders.warningSnackBar(title: 'Data not saved',
          message: 'Something went wrong while saving your information. You can re-save your data in your Profile');
    }
  }

  Future<void> fetchUserRecord() async {
    try {
      final user = await userRepository.fetchUserDetails();
      this.user(user);
    } catch (e) {
      user(UserModel.empty());
    }
  }

  void deleteAccountWarningPopup() {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(TSizes.md),
      title: 'Delete Account',
      middleText: 'Are you sure you want to delete your account permanently? This acction is not reversible and all of you data will be remove permanently.',
      confirm: ElevatedButton(onPressed: () => deleteUserAccount(), style: ElevatedButton.styleFrom(backgroundColor: Colors.red, side: const BorderSide(color: Colors.red)),
      child: const Padding(padding: EdgeInsets.symmetric(horizontal: TSizes.lg), child: Text('Delete')),
      ),
      cancel: OutlinedButton(onPressed: () => Navigator.of(Get.overlayContext!).pop(), child: const Text('Cancel'))
    );
  }
  void deleteUserAccount() async {
    try {
      TFullScreenLoader.openLoadingDialog('Processing...', TImages.animation);
      // First re-authenticate user
      final auth = AuthenticationRepository.instance;
      final provider = auth.authUser!.providerData.map((e) => e.providerId).first;
      if (provider.isNotEmpty) {
        // Re Verify Auth Email
        if (provider == 'google.com') {
          await auth.signInWithGoogle();
          await auth.deleteAccount();
          TFullScreenLoader.stopLoading();
          Get.offAll(() => const LoginScreen());
        } else if (provider == 'password') {
          TFullScreenLoader.stopLoading();
          Get.to(() => const ReAuthLoginForm());
        }
      }

    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
  Future<void> reAuthenticateEmailAndPasswordUser() async {
    try {
      TFullScreenLoader.openLoadingDialog('Processing...', TImages.animation);
      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }
      // Form Validation
      if (!reAuthFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }
      await AuthenticationRepository.instance.reAuthenticateEmailAndPassword(verifyEmail.text.trim(), verifyPassword.text.trim());
      await AuthenticationRepository.instance.deleteAccount();

      //Remove Loader
      TFullScreenLoader.stopLoading();

      Get.offAll(() => const LoginScreen());

    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  uploadUserProfilePicture() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 70, maxHeight: 512, maxWidth: 512);
      if (image != null) {
        imageLoading.value = true;
        // Upload Image
        final imageUrl = await userRepository.uploadImage(
            'Users/Images/Profile/', image);

        // Update User Image Record
        Map<String, dynamic> json = {'ProfilePicture': imageUrl};
        await userRepository.updateSingleField(json);

        user.value.profilePicture = imageUrl;
        user.refresh();

        TLoaders.successSnackBar(title: 'Congratulation', message: 'Your Profile Picture has been updated!');
      }
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap', message: 'Something went wrong: $e');
    } finally {
      imageLoading.value = false;
    }
  }
}