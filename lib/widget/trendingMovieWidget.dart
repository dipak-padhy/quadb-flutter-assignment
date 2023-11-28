import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class trendingMovieWidget extends StatelessWidget {
  const trendingMovieWidget({super.key, required this.snapshot});

  final AsyncSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    log("image = ${snapshot.data}");
    return SizedBox(
      width: double.infinity,
      child: CarouselSlider.builder(
          itemCount: 5,
          itemBuilder: (context, itemIndex, pageViewIndex) {
            return Stack(children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Image.network(
                  snapshot.data[itemIndex]['image']['original'],
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.cover,
                ),
              ),
            ]);
          },
          options: CarouselOptions(
              height: 320,
              autoPlay: true,
              viewportFraction: 0.62,
              enlargeCenterPage: true,
              enlargeStrategy: CenterPageEnlargeStrategy.scale)),
    );
  }
}
