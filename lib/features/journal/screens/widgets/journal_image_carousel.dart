import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:solution_challenge_app/features/journal/screens/widgets/image_widget.dart';

class JournalImageCarousel extends StatefulWidget {
  const JournalImageCarousel({super.key, required this.imageFiles});

  final List<String> imageFiles;

  @override
  State<JournalImageCarousel> createState() => _JournalImageCarouselState();
}

class _JournalImageCarouselState extends State<JournalImageCarousel> {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: widget.imageFiles.length,
      itemBuilder: (BuildContext context, index, realIndex) {
        return BuildImage(
          imageFile: widget.imageFiles[index],
        );
      },
      options: CarouselOptions(
        height: 250,
        autoPlay: true,
        enlargeCenterPage: true,
      ),
    );
  }
}
