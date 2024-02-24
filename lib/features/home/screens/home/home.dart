import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:solution_challenge_app/common/widgets/appbar/appbar.dart';
import 'package:solution_challenge_app/common/widgets/custom_shapes/container/primary_header_container.dart';
import 'package:solution_challenge_app/features/home/screens/home/widgets/image_carousel.dart';
import 'package:solution_challenge_app/firebase/gauth.dart';
import 'package:solution_challenge_app/login.dart';
import 'package:banner_listtile/banner_listtile.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final circleBgColor = const Color.fromARGB(255, 195, 225, 255);

  late String? name = "";
  late String? email = "";
  late String? imageUrl = "";

  @override
  void initState() {
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
                          const Text(
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
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                      actions: [
                        GestureDetector(
                          onTap: () async {
                            Get.dialog(AlertDialog(
                              title: const Text('Logout'),
                              content: const Text(
                                  'Are you sure you want to logout?'),
                              actions: [
                                TextButton(
                                  onPressed: () async {
                                    await GoogleAuth().signOut();
                                    var box = Hive.box('user');
                                    box.clear();
                                    Get.offAll(() => const LoginPage());
                                  },
                                  child: const Text('Logout'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: const Text('Cancel'),
                                ),
                              ],
                            ));
                          },
                          child: Container(
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
                                  ))),
                        )
                      ],
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 32.0),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 30, left: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            const Text(
                              'Memories',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 42,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.arrow_circle_right_outlined,
                                  color: Colors.white,
                                  size: 30,
                                ))
                          ],
                        ),
                      )),
                  const Padding(
                    padding: EdgeInsets.only(top: 25.0, right: 20, left: 20),
                    child: ImageCarousel(),
                  ),
                ],
              ),
            ),
            SfCalendar(),
          ],
        ),
      ),
    );
  }
}



// the banners added by satendra:
// Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: BannerListTile(
//                     backgroundColor: Colors.blue,
//                     borderRadius: BorderRadius.circular(8),
//                     bannerPosition: BannerPosition.topRight,
//                     imageContainer: const Image(
//                         image: NetworkImage(
//                             "https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb1.2.1&auto=format&fit=crop&w=387&q=80"),
//                         fit: BoxFit.cover),
//                     title: const Text(
//                       "Music",
//                       style: TextStyle(fontSize: 24, color: Colors.white),
//                       overflow: TextOverflow.ellipsis,
//                       maxLines: 1,
//                     ),
//                     subtitle: const Text("A model from NY",
//                         style: TextStyle(fontSize: 13, color: Colors.white)),
//                     trailing: IconButton(
//                         onPressed: () {},
//                         icon: const Icon(
//                           Icons.arrow_circle_right_rounded,
//                           color: Colors.red,
//                         )),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: BannerListTile(
//                     backgroundColor: Colors.blue,
//                     borderRadius: BorderRadius.circular(8),
//                     bannerPosition: BannerPosition.topRight,
//                     imageContainer: const Image(
//                         image: NetworkImage(
//                             "https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb1.2.1&auto=format&fit=crop&w=387&q=80"),
//                         fit: BoxFit.cover),
//                     title: const Text(
//                       "Journal",
//                       style: TextStyle(fontSize: 24, color: Colors.white),
//                       overflow: TextOverflow.ellipsis,
//                       maxLines: 1,
//                     ),
//                     subtitle: const Text("A model from NY",
//                         style: TextStyle(fontSize: 13, color: Colors.white)),
//                     trailing: IconButton(
//                         onPressed: () {},
//                         icon: const Icon(
//                           Icons.arrow_circle_right_rounded,
//                           color: Colors.red,
//                         )),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: BannerListTile(
//                     backgroundColor: Colors.blue,
//                     borderRadius: BorderRadius.circular(8),
//                     bannerPosition: BannerPosition.topRight,
//                     imageContainer: const Image(
//                         image: NetworkImage(
//                             "https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb1.2.1&auto=format&fit=crop&w=387&q=80"),
//                         fit: BoxFit.cover),
//                     title: const Text(
//                       "Medicine",
//                       style: TextStyle(fontSize: 24, color: Colors.white),
//                       overflow: TextOverflow.ellipsis,
//                       maxLines: 1,
//                     ),
//                     subtitle: const Text("A model from NY",
//                         style: TextStyle(fontSize: 13, color: Colors.white)),
//                     trailing: IconButton(
//                         onPressed: () {},
//                         icon: const Icon(
//                           Icons.arrow_circle_right_rounded,
//                           color: Colors.red,
//                         )),
//                   ),
//                 ),
//               ],
//             )