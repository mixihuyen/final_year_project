import 'package:flutter/material.dart';

class TShadowStyle {
  static final ticketShadow = BoxShadow(
    color: Colors.grey.withOpacity(0.3),
    spreadRadius: 2,
    blurRadius: 5,
    offset: const Offset(0, 3),
  );
}