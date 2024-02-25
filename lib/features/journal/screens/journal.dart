// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:solution_challenge_app/features/journal/screens/new_journal.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:solution_challenge_app/features/journal/screens/widgets/journal_widget.dart';
import 'package:solution_challenge_app/firebase/gauth.dart';
import 'package:solution_challenge_app/login.dart';

class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  List<dynamic> journalCards = [];
  late String? imageUrl = "";

  Future<void> setData() async {
    final user = await GoogleAuth().getUser();
    setState(() {
      imageUrl = user?.photoURL;
    });
  }

  @override
  void initState() {
    super.initState();
    openBox();
    setData();
  }

  void openBox() async {
    var box = Hive.box('journal');
    setState(() {
      journalCards = box.values.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0XFF1A84B8),
            Color.fromARGB(255, 53, 192, 199),
          ],
        ),
      ),
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: CustomAppBar(
              imageUrl: imageUrl,
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 35.0,
                      right: 18,
                      left: 18,
                      bottom: 10,
                    ),
                    child: SizedBox(
                      width: 385,
                      child: MasonryGridView.builder(
                        dragStartBehavior: DragStartBehavior.start,
                        reverse: false,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        gridDelegate:
                            const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemCount: journalCards.length,
                        itemBuilder: ((context, index) {
                          var content =
                              journalCards[journalCards.length - index - 1];
                          return JournalWidget(content: content);
                        }),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 90,
            right: 26,
            child: Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(60),
              ),
              child: IconButton(
                onPressed: () {
                  Get.to(() => NewJournalPage(addToHiveBox: () => openBox()));
                },
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 38,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.imageUrl,
  });

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0, left: 5, right: 15),
      child: AppBar(
        toolbarHeight: 90,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'add. create. delete.',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins',
                fontSize: 17,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              'Journal',
              style: TextStyle(
                letterSpacing: 0.6,
                color: Colors.white,
                fontFamily: 'Poppins',
                fontSize: 40,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        actions: [
          GestureDetector(
            onTap: () async {
              Get.dialog(AlertDialog(
                title: const Text('Logout'),
                content: const Text('Are you sure you want to logout?'),
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
                  image: NetworkImage(
                    imageUrl ??
                        'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(120);
}
