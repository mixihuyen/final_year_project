import 'package:final_year_project/features/application/models/category_model.dart';
import 'package:flutter/material.dart';

import '../../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../../common/widgets/tickets/ticket_card/ticket_card.dart';
class TTripTab extends StatelessWidget {
  const TTripTab({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(right: 20),
        child: TGridLayout(
            itemCount: 4, itemBuilder: (_, index) => const TTicketCard())
    );
  }
}
