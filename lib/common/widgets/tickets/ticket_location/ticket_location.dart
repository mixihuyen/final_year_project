import 'package:flutter/material.dart';

class TicketTimeLocation extends StatelessWidget {
  final String time;
  final String location;
  final String province;

  const TicketTimeLocation(
      {super.key,
        required this.time,
        required this.location,
        required this.province});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(time, style: Theme.of(context).textTheme.bodyLarge),
      Text(location, style: Theme.of(context).textTheme.bodyLarge),
      Text(
        province,
        style: TextStyle(
          color: Colors.grey[600],
        ),
      ),
    ]);
  }
}