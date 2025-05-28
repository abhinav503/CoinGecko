import 'dart:math';

import 'package:coingecko/core/constants/string_constants.dart';
import 'package:flutter/material.dart';

class JokeItemWidget extends StatelessWidget {
  final String joke;
  final int? index;
  const JokeItemWidget({super.key, required this.joke, this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: ListTile(
          tileColor: getRandomProductBgColor(),
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Theme.of(context).indicatorColor),
          ),
          title: Text(
            "$dadJoke - ${index ?? random}",
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.start,
          ),
          subtitle: Text(
            joke,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.start,
          ),
        ),
      ),
    );
  }

  getRandomProductBgColor() {
    final random = Random();
    List<Color> cardColorList = [
      const Color(0xFFFACCCC),
      const Color(0xFF2C92E9),
      const Color(0xFFFFCD41),
      const Color(0xFFF3EFFA),
      const Color(0xFFD3E5C4),
      const Color(0xFFFFE8F2),
    ];
    return cardColorList[random.nextInt(cardColorList.length)];
  }
}
