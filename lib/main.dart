import 'package:flutter/material.dart';

void main() {
  runApp( MaterialApp(
    home: SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: const Text('Coach Booking Ticket')
        ),
        body: const Center(
           child: Text('Hello World')
        )
      )
    ),
    debugShowCheckedModeBanner: false,
  ));
}


