import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:solution_challenge_app/common/widgets/appbar/appbar.dart';
import 'package:solution_challenge_app/common/widgets/custom_shapes/container/primary_header_container.dart';
import 'package:solution_challenge_app/features/home/screens/home/widgets/image_carousel.dart';
import 'package:solution_challenge_app/firebase/gauth.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final circleBgColor = Color.fromARGB(255, 195, 225, 255);

  late String? name = "";
  late String? email = "";
  late String? imageUrl = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setData();
  }

  Future<void> setData() async {
    final user = await GoogleAuth().getUser();
    setState(() {
      name = user?.displayName;
      email = user?.email;
      imageUrl = user?.photoURL;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            PrimaryHeaderContainer(
              circleBgColor: circleBgColor,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 32.0),
                    child: CustomAppBar(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome back,',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            name ?? 'User',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                      actions: [
                        Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                    imageUrl ??
                                        'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png',
                                  ),
                                  fit: BoxFit.cover,
                                )))
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 32.0),
                    child: Text(
                      'Memories',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 42,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 25.0, right: 20, left: 20),
                    child: ImageCarousel(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
