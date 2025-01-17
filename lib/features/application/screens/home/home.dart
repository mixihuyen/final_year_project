
import 'package:final_year_project/features/application/screens/home/widgets/search_trip.dart';
import 'package:final_year_project/features/application/screens/home/widgets/home_appbar.dart';
import 'package:final_year_project/features/application/screens/home/widgets/popular_trips.dart';
import 'package:final_year_project/features/application/screens/home/widgets/promo_slider.dart';
import 'package:final_year_project/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import '../../../../common/widgets/custom_shapes/containers/primary_header_container.dart';
import '../../../../common/widgets/section_heading.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/helpers/helper_functions.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      backgroundColor: dark ? TColors.dark : TColors.light,
      body: SingleChildScrollView(
        child: Column(
          children: [
            TPrimaryHeaderContainer(
              child: Column(
                children: [
                  /// -- App Bar
                  THomeAppBar(dark: dark),
                  const SizedBox(height: TSizes.spaceBtwSections),
                ],
              ),

            ),

            /// -- Search Bar
             const SearchTrip(),

            /// -- Banner
            const TPromoSlider(),
            const PopularTrips(),
          ],
        ),
      ),
    );
  }
}


