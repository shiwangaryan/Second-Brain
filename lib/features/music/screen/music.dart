// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:solution_challenge_app/features/music/model/song_model.dart';
import 'package:solution_challenge_app/features/music/screen/widgets/song_cards.dart';
import 'package:solution_challenge_app/firebase/gauth.dart';
import 'package:solution_challenge_app/login.dart';

class MusicPage extends StatefulWidget {
  const MusicPage({super.key});

  @override
  State<MusicPage> createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {
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
    setData();
  }

  @override
  Widget build(BuildContext context) {
    List<Song> songs = Song.songs;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0XFF1A84B8),
            Color.fromARGB(255, 53, 192, 199),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomAppBar(imageUrl: imageUrl),
        body: Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //------ gap -------
                SizedBox(height: 34),
                //------ search bar -------
                SearchBar(),
                //------ song cards -------
                SizedBox(height: 7),
                MusicSections(
                  section_title: 'Golden Oldies',
                  songs: songs,
                ),
                SizedBox(height: 8),
                MusicSections(
                  section_title: 'Calm Melodies',
                  songs: songs,
                ),
                SizedBox(height: 8),
                MusicSections(
                  section_title: 'Toe Tapping Beats',
                  songs: songs,
                ),
                SizedBox(height: 36),
                FinishingRow(),
                SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//-----------------------
// all the widgets below:-
//-----------------------
class FinishingRow extends StatelessWidget {
  const FinishingRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0, top: 2),
          child: Icon(
            Icons.circle,
            color: Colors.white,
            size: 8,
          ),
        ),
        Text(
          'tune that soothes',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 2),
          child: Icon(
            Icons.circle,
            color: Colors.white,
            size: 8,
          ),
        ),
      ],
    );
  }
}

class MusicSections extends StatelessWidget {
  const MusicSections({
    super.key,
    required this.songs,
    required this.section_title,
  });

  final List<Song> songs;
  final String section_title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 35.0, left: 25),
          child: Text(
            section_title,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 26,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 25),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.22,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: songs.length,
                itemBuilder: ((context, index) {
                  return SongCard(song: songs[index]);
                }),
              ),
            )),
      ],
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17.0),
      child: TextFormField(
        decoration: InputDecoration(
            isDense: true,
            filled: true,
            fillColor: Colors.white,
            hintText: 'Search',
            hintStyle: TextStyle(color: Colors.grey[400]),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.grey[400],
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            )),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({
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
              'Music for,',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins',
                fontSize: 32,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'Every Moment',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins',
                fontSize: 32,
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
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(120);
}
