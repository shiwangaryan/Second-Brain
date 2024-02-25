import 'dart:io';
import 'dart:math';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:solution_challenge_app/features/journal/screens/new_journal.dart';
import 'package:solution_challenge_app/features/journal/screens/widgets/open_journal.dart';
import 'package:solution_challenge_app/navigation_menu.dart';

List<dynamic> imageJounralsInfo() {
  List<dynamic> ImageJournalsInfo = [];

  final box = Hive.box('journal');
  for (final key in box.keys) {
    final object = box.get(key);
    if (object['imagePaths'].length != 0) {
      ImageJournalsInfo.add(object);
    }
  }
  return ImageJournalsInfo;
}

class ImageCarousel extends StatefulWidget {
  const ImageCarousel({super.key});

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  List<int> uniqueIndexList = [];
  bool manyMemories = true;
  final controller = Get.put(NavigatorMenuController());

  @override
  void initState() {
    super.initState();
  }

  void addToHive() {}

  @override
  Widget build(BuildContext context) {
    List<dynamic> carouselImageAssets = imageJounralsInfo();
    manyMemories = carouselImageAssets.length >= 6;
    if (manyMemories) {
      Random rng = Random();
    Set<int> uniqueIndexSet = {};
      while (uniqueIndexSet.length <= 6) {
        uniqueIndexSet.add(rng.nextInt(carouselImageAssets.length));
      }
      uniqueIndexList = uniqueIndexSet.toList();
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        manyMemories
            ? CarouselSlider.builder(
                itemCount: uniqueIndexList.length + 1,
                itemBuilder: (context, index, realIndex) {
                  if (index == uniqueIndexList.length) {
                    return InkWell(
                      onTap: () {
                        Get.to(() => NewJournalPage(addToHiveBox: addToHive));
                      },
                      child: Center(
                        child: Container(
                          width: 380,
                          height: 250,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Center(
                            child: Text(
                              'add more memories',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white54,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                  return BuildImage(
                    imageFile: carouselImageAssets[index]['imagePaths'][0],
                    content: carouselImageAssets[index],
                  );
                },
                options: CarouselOptions(
                  height: 200,
                  autoPlay: false,
                  enlargeCenterPage: true,
                ),
              )
            : CarouselSlider.builder(
                itemCount: carouselImageAssets.length + 1,
                itemBuilder: (context, index, realIndex) {
                  if (index == carouselImageAssets.length) {
                    return InkWell(
                      onTap: () {
                        Get.to(() => NewJournalPage(addToHiveBox: addToHive));
                      },
                      child: Center(
                        child: Container(
                          width: 380,
                          height: 250,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Center(
                            child: Text(
                              'add more memories',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white54,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                  return BuildImage(
                    imageFile: carouselImageAssets[index]['imagePaths'][0],
                    content: carouselImageAssets[index],
                  );
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
    required this.imageFile,
    this.content,
  });

  final String imageFile;
  final dynamic content;

  @override
  Widget build(BuildContext context) {
    final path = File(imageFile);
    final String memoryTitle = content['heading'].length > 15
        ? '${content['heading'].substring(0, 12)}...'
        : content['heading'];
    return InkWell(
      onTap: () {
        Get.to(() => OpenJournal(content: content));
      },
      child: Stack(
        children: [
          Container(
            width: 380,
            height: 250,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: FileImage(path),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          Positioned(
            bottom: 6,
            left: 6,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13),
                color: Colors.black,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
              child: Text(
                memoryTitle,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
