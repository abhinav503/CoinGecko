import 'package:coingecko/core/constants/string_constants.dart';
import 'package:coingecko/core/ui/atoms/custom_icon_widget.dart';
import 'package:flutter/material.dart';

class CampaignWidget extends StatelessWidget {
  final IconData icon;
  final Color color;
  const CampaignWidget({super.key, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              StringConstants.newUserZone,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
            Text(
              StringConstants.get100USDbonusOnYourFirstDeposit,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: CustomIconWidget(icon: icon, color: color, size: 50.0),
        ),
      ],
    );
  }
}
