import 'package:final_year_project/features/application/screens/home/widgets/ticket_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/constants/sizes.dart';

class PopularTrips extends StatelessWidget {
  const PopularTrips({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          BusTicketWidget(),
          BusTicketWidget(),
        ],
      ),
    );
  }
}
