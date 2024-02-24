import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
// import 'package:solution_challenge_app/features/home/screens/home/widgets/addMemory.dart';

class ImageCarousel extends StatefulWidget {
  const ImageCarousel({super.key});

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  late List<dynamic> carouselImageAssets = [];
  Future<void> getMemories() async {
    final box = await Hive.openBox('memories');
    final List<dynamic> memories = box.get('memories', defaultValue: [
      {
        'id': 'lol',
        'image':
            'https://plus.unsplash.com/premium_photo-1707413391465-82ac03dd5555',
        'heading': "My second memory",
        'content': "This is my second ever memory",
        'audios': [],
        'images': [],
      },
      {
        'id': 'lol2',
        'image': 'https://images.unsplash.com/photo-1707432777342-3cf708f95065',
        'heading': "My first memory",
        'content': "This is my first ever memory"
      },
    ]);
    setState(() {
      carouselImageAssets = memories;
    });
  }

  @override
  void initState() {
    super.initState();
    getMemories();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CarouselSlider.builder(
          itemCount: carouselImageAssets.length + 1,
          itemBuilder: (context, index, realIndex) {
            if (index == carouselImageAssets.length) {
              return SizedBox(
                  width: 300,
                  height: 300,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ListTile(
                          onTap: () {
                            print('Add Memory');
                            // Get.to(() => AddMemoryScreen());
                          },
                          title: Text('Add Memory'),
                          trailing: Icon(Icons.add),
                          visualDensity: VisualDensity.comfortable,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          tileColor: Colors.grey[200],
                        ),
                        const ListTile(
                          title: Text('View All memories'),
                          trailing: Icon(Icons.arrow_forward_ios),
                        ),
                      ],
                    ),
                  ));
            }
            final urlImage = carouselImageAssets[index]['image'];
            return BuildImage(urlImage: urlImage ?? '');
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
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: urlImage,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                gradient: LinearGradient(
                  colors: [Colors.black, Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: const Text(
                'Memory',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
