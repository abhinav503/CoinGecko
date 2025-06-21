import 'package:cached_network_image/cached_network_image.dart';
import 'package:coingecko/core/ui/atoms/custom_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class CustomNetworkImage extends StatelessWidget {
  final String imageUrl;
  const CustomNetworkImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: 30.0,
      height: 30.0,
      errorWidget: (context, error, stackTrace) {
        return const CustomIconWidget(
          icon: HugeIcons.strokeRoundedCoins02,
          color: Colors.grey,
          size: 30.0,
        );
      },
      placeholder: (context, url) {
        return const CustomIconWidget(
          icon: HugeIcons.strokeRoundedCoins02,
          color: Colors.grey,
          size: 30.0,
        );
      },
    );
  }
}
