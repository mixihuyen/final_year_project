import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../common/widgets/tickets/ticket_card/ticket_card.dart';
import '../../../../../utils/constants/sizes.dart';

class PopularTrips extends StatelessWidget {
  const PopularTrips({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          TTicketCard(),
          TTicketCard(),
        ],
      ),
    );
  }
}
