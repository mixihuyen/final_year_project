import 'package:final_year_project/common/widgets/appbar/appbar.dart';
import 'package:final_year_project/common/widgets/appbar/tabbar.dart';
import 'package:final_year_project/common/widgets/tickets/ticket_card/ticket_card.dart';
import 'package:final_year_project/features/application/controllers/category_controller.dart';
import 'package:final_year_project/features/application/screens/trips/widgets/trip_tab.dart';
import 'package:final_year_project/utils/constants/colors.dart';
import 'package:final_year_project/utils/constants/sizes.dart';
import 'package:final_year_project/utils/helpers/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../utils/constants/text_strings.dart';

class AllTrips extends StatelessWidget {
  const AllTrips({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(CategoryController());
    return Scaffold(
        backgroundColor: dark ? TColors.dark : TColors.light,
        appBar: TAppBar(
          title: Text(TTexts.allTrips,
              style: Theme.of(context).textTheme.headlineSmall),
        ),
        body: Obx(() {
          final categories = controller.allCategories;
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          if (categories.isEmpty) {
            return const Center(child: Text("There are no categories."));
          }
          return DefaultTabController(
            length: categories.length,
            child: NestedScrollView(
                headerSliverBuilder: (_, innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      pinned: true,
                      floating: true,
                      expandedHeight: 0,
                      bottom: TTabbar(
                          tabs: categories
                              .map(
                                  (category) => Tab(child: Text(category.name)))
                              .toList()),
                    ),
                  ];
                },
                body: TabBarView(
                  children: categories
                      .map((category) => TTripTab(category: category))
                      .toList(),
                ),
              ),
            );
        }));
  }
}
