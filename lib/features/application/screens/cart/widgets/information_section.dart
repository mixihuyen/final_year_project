import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Required for input formatters
import 'package:get/get.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/Info_controller.dart';
import '../../../../../utils/validators/validation.dart';

class TInformationSection extends StatelessWidget {
  const TInformationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final checkoutInfoController = Get.put(CheckoutInfoController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Personal Information Label
        Text('Personal Information', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: TSizes.spaceBtwItems / 2),

        // Full Name Label and TextField
        Text('Full name', style: Theme.of(context).textTheme.bodySmall),
        const SizedBox(height: TSizes.spaceBtwItems / 4),
        TextField(
          controller: checkoutInfoController.nameController,
          style: Theme.of(context).textTheme.bodyMedium,
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
            ),
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 2),

        // Phone Number Label and TextFormField
        Text('Phone number', style: Theme.of(context).textTheme.bodySmall),
        const SizedBox(height: TSizes.spaceBtwItems / 4),

        TextFormField(
          controller: checkoutInfoController.phoneController,
          validator: (value) {
            return TValidator.validatePhoneNumber(value);
          },
          keyboardType: TextInputType.phone,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly, // Restrict input to numbers only
          ],
          style: Theme.of(context).textTheme.bodyMedium,
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
            ),
            hintText: 'Enter your phone number', // Optional: Placeholder text
          ),
        ),

        const SizedBox(height: TSizes.spaceBtwSections),
      ],
    );
  }
}
