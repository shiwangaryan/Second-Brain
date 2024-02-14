import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ImageCarousel extends StatefulWidget {
  const ImageCarousel({super.key});

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  final carouselImageAssets = [
    'https://plus.unsplash.com/premium_photo-1707413391465-82ac03dd5555',
    'https://images.unsplash.com/photo-1707432777342-3cf708f95065',
    'https://plus.unsplash.com/premium_photo-1707413391465-82ac03dd5555',
    'https://images.unsplash.com/photo-1707432777342-3cf708f95065',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CarouselSlider.builder(
          itemCount: carouselImageAssets.length,
          itemBuilder: (context, index, realIndex) {
            final urlImage = carouselImageAssets[index];
            return BuildImage(urlImage: urlImage);
          },
          options: CarouselOptions(
            height: 200,
            autoPlay: false,
            enlargeCenterPage: true,
          ),
        ),
      ],
    );
  }
}

class BuildImage extends StatelessWidget {
  const BuildImage({
    super.key,
    required this.urlImage,
  });

  final String urlImage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 300,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: urlImage,
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(), // Loading indicator
            ),
            errorWidget: (context, url, error) =>
                const Icon(Icons.error), // Error widget if image fails to load
          )),
    );
  }
}
