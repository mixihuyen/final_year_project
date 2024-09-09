import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class TTicketPriceText extends StatelessWidget {
  const TTicketPriceText({
    super.key,
    required this.price,
  });
  final String  price;

  @override
  Widget build(BuildContext context) {
    return Text(
      price ,
      style: const TextStyle(
        color: Colors.red,
        fontWeight: FontWeight.bold,
      ),
    );
  }

}