import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CarouselSliderWidget extends StatefulWidget {
  final List<Widget> items;
  const CarouselSliderWidget({super.key, required this.items});

  @override
  State<CarouselSliderWidget> createState() => _CarouselSliderWidgetState();
}

class _CarouselSliderWidgetState extends State<CarouselSliderWidget> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 60.h,
            autoPlay: true,
            aspectRatio: 16 / 9,
            viewportFraction: 1,
            initialPage: 0,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
          items: widget.items,
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:
              widget.items.asMap().entries.map((entry) {
                return Container(
                  width: 10.0,
                  height: 4.0,
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(
                      _current == entry.key ? 0.9 : 0.4,
                    ),
                  ),
                );
              }).toList(),
        ),
      ],
    );
  }
}
