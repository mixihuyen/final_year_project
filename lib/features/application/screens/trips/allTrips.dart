import 'package:final_year_project/common/widgets/appbar/appbar.dart';
import 'package:final_year_project/common/widgets/tickets/ticket_card/ticket_card.dart';
import 'package:final_year_project/utils/constants/colors.dart';
import 'package:final_year_project/utils/constants/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../utils/constants/text_strings.dart';

class AllTrips extends StatelessWidget {
  const AllTrips({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
          title: Text(TTexts.allTrips,
              style: Theme.of(context).textTheme.headlineSmall)),
      body: ListView(children: [
        Container(
          padding: const EdgeInsets.only(right: 20),
          child: TGridLayout(
              itemCount: 4, itemBuilder: (_, index) => const TTicketCard()),
        ),
      ]),
    );
  }
}
