import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class BookingForm extends StatefulWidget {
  const BookingForm({super.key});

  @override
  _BookingFormState createState() => _BookingFormState();
}

class _BookingFormState extends State<BookingForm> {
  String? pickupLocation;
  String? destinationLocation;
  DateTime? selectedDate;

  Future<void> _selectPickupLocation() async {
    // Hiển thị danh sách địa điểm, đây là ví dụ tạm thời
    final location = await showModalBottomSheet<String>(
      context: context,
      builder: (context) {
        return ListView(
          children: ['Hà Nội', 'TP HCM', 'Đà Nẵng'].map((location) {
            return ListTile(
              title: Text(location),
              onTap: () => Navigator.pop(context, location),
            );
          }).toList(),
        );
      },
    );

    if (location != null) {
      setState(() {
        pickupLocation = location;
      });
    }
  }

  Future<void> _selectDestinationLocation() async {
    // Hiển thị danh sách địa điểm, đây là ví dụ tạm thời
    final location = await showModalBottomSheet<String>(
      context: context,
      builder: (context) {
        return ListView(
          children: ['Hà Nội', 'TP HCM', 'Đà Nẵng'].map((location) {
            return ListTile(
              title: Text(location),
              onTap: () => Navigator.pop(context, location),
            );
          }).toList(),
        );
      },
    );

    if (location != null) {
      setState(() {
        destinationLocation = location;
      });
    }
  }

  Future<void> _selectDate() async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );

    if (date != null) {
      setState(() {
        selectedDate = date;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: dark ? TColors.textPrimary : TColors.white,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: TSizes.spaceBtwItems),
            Row(
              children: [
                Text(TTexts.titleSearch,
                    style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Iconsax.location),
              title: Text(TTexts.pickUpPoint,
                  style: Theme.of(context).textTheme.labelMedium),
              subtitle: Text( pickupLocation ?? TTexts.selectPickUpPoint,
                  style: Theme.of(context).textTheme.bodyLarge),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: _selectPickupLocation,
            ),
            const Divider(),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Iconsax.send_1),
              title: Text(TTexts.destination,
                  style: Theme.of(context).textTheme.labelMedium),
              subtitle: Text( destinationLocation ?? TTexts.selectDestination,
                  style: Theme.of(context).textTheme.bodyLarge),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: _selectDestinationLocation,
            ),
            const Divider(),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Iconsax.calendar),
              title: Text(TTexts.date,
                  style: Theme.of(context).textTheme.labelMedium),
              subtitle: Text( selectedDate != null
                  ? '${selectedDate!.day}/${selectedDate!
                  .month}/${selectedDate!.year}'
                  : TTexts.selectDate,
                  style: Theme.of(context).textTheme.bodyLarge),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: _selectDate,
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: TColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                onPressed: () {
                },
                child: Text(TTexts.search,
                    style: Theme.of(context).textTheme.bodyLarge),
              ),
            ),
          ],
        ),
      ),
    );
  }
}