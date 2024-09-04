import 'package:cached_network_image/cached_network_image.dart';
import 'package:final_year_project/common/styles/shimmer.dart';
import 'package:final_year_project/utils/constants/colors.dart';
import 'package:final_year_project/utils/constants/sizes.dart';
import 'package:final_year_project/utils/helpers/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TCircularImage extends StatelessWidget {
  const TCircularImage(
      {super.key,
      this.width = 100,
      this.height = 100,
      this.padding = 0,
      required this.image,
      this.backgroundColor,
      this.fit = BoxFit.cover,
      this.isNetworkImage = false,
      this.overlayColor});

  final double width, height, padding;
  final String image;
  final Color? backgroundColor;
  final BoxFit fit;
  final bool isNetworkImage;
  final Color? overlayColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: backgroundColor ??
            (THelperFunctions.isDarkMode(context)
                ? TColors.black
                : TColors.white),
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: Stack(fit: StackFit.expand, children: [
          isNetworkImage
              ? CachedNetworkImage(
                  imageUrl: image,
                  fit: fit,
                  color: overlayColor,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      const TShimmerEffect(width: 100, height: 100),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                )
              : Image(
                  fit: fit,
                  image: AssetImage(image),
                  color: overlayColor,
                ),
        ]),
      ),
    );
  }
}
