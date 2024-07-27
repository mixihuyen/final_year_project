import 'package:flutter/material.dart';

void main() {
  runApp( MaterialApp(
    theme: ThemeData(
      fontFamily: 'Pacifico Regular'
    ),
    home: SafeArea(
      child: Scaffold(
        body: Center(child: MyWidget()),
        // appBar: AppBar(
        //   backgroundColor: Colors.orange,
        //   title: const Text('Coach Booking Ticket')
        // ),
        // body: const Center(
        //    child: Text('Hello World')
        // )
      )
    ),
    debugShowCheckedModeBanner: false,
  ));
}

class MyWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
   return const Text('Welcome to my app\n'
       'Mixi Huyen',
     textDirection: TextDirection.ltr,
     textAlign: TextAlign.center,
     maxLines: 2,
     overflow: TextOverflow.ellipsis,
     style: TextStyle(
       color: Colors.green,
       fontSize: 20,
       fontWeight: FontWeight.w400,
       fontStyle: FontStyle.italic,
       wordSpacing: 10,
       letterSpacing: 4,
       //decoration: TextDecoration.underline
     ),
   );
  }

}
/////////////////////////////////////////////////////////
// class MyWidget2 extends StatefulWidget{
//   final bool loading;
//
//   MyWidget2(this.loading);
//   @override
//   State<StatefulWidget> createState() {
//     return MyWidget2State();
//   }
//
// }
//
// class MyWidget2State extends State<MyWidget2> {
//   late bool _localloading;
//
//   @override
//   void initState() {
//     _localloading = widget.loading;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return _localloading ? const CircularProgressIndicator() : FloatingActionButton(onPressed: onClickButton);
//   }
//   void onClickButton() {
//     setState(() {
//       _localloading = true;
//     });
//   }
// }