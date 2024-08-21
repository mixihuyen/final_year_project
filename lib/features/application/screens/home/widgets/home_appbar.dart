import 'package:flutter/material.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/text_strings.dart';


class THomeAppBar extends StatelessWidget {
  const THomeAppBar({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return TAppBar(
      title: Column(
        children: [
          //const Gap(40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 85,
                width: 85,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(dark
                          ? TImages.shortdarkAppLogo
                          : TImages.shortlightAppLogo),
                    )),
              ),
              Text(TTexts.homeAppbarTitle,
                  style: Theme.of(context).textTheme.titleLarge),
            ],
          )
        ],
      ),
    );
  }
}