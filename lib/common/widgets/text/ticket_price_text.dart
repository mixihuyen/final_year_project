import 'package:flutter/material.dart';


class TTicketPriceText extends StatelessWidget {
  const TTicketPriceText({
    super.key,
    this.currencySign = 'VND',
    required this.price,
  });
  final String currencySign, price;

  @override
  Widget build(BuildContext context) {
    return Text(
      price + currencySign,
      style: const TextStyle(
        color: Colors.red,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}