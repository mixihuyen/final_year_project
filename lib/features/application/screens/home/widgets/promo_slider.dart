import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../../../common/widgets/images/t_rounded_image.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';

class TPromoSlider extends StatelessWidget {
  const TPromoSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                viewportFraction: 0.8,
                height: 87,
              ),
              items: const [
                TRoundedImage(imageUrl: TImages.banner1),
                TRoundedImage(imageUrl: TImages.banner2),
                TRoundedImage(imageUrl: TImages.banner3),
              ],
            ),
          ],
        ));
  }
}