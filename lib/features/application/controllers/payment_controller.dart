import 'package:final_year_project/common/widgets/payment/payment_tile.dart';
import 'package:final_year_project/common/widgets/section_heading.dart';
import 'package:final_year_project/features/application/screens/cart/widgets/payment_section.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../models/payment_method_model.dart';

class PaymentController extends GetxController {
  static PaymentController get instance => Get.find();

  final Rx<PaymentMethodModel> selectedPaymentMethod = PaymentMethodModel.empty().obs;
  @override
  void onInit() {
    selectedPaymentMethod.value = PaymentMethodModel(name: 'Stripe', image: TImages.stripe);
    super.onInit();
  }

  Future<dynamic> selectPaymentMethod(BuildContext context) {
    return showModalBottomSheet(
        context: context, 
        builder: (_) => SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(TSizes.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TSectionHeading(title: 'Select Payment Method', showActionButton: false),
                const SizedBox(height: TSizes.spaceBtwSections),
                TPaymentTile(paymentMethod: PaymentMethodModel(name: 'Stripe', image: TImages.stripe)),
                const SizedBox(height: TSizes.spaceBtwItems/2),
              ],
            ),
          ),
        )
    );
  }

}