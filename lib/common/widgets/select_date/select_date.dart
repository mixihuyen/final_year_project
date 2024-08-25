import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/constants/sizes.dart';
import '../../../utils/constants/text_strings.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({super.key});

  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  // Biến lưu trữ ngày đã chọn
  DateTime? selectedDate;

  // Hàm này được gọi khi người dùng chọn ngày
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Row(children: [
        Text('Date: ', style: Theme.of(context).textTheme.labelMedium),
        TextButton(
          onPressed: () => _selectDate(context),
          child: Text(
            selectedDate == null
                ? 'Please select a date'
                : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      ]),
    ]);
  }
}
