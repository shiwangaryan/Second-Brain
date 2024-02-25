// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:solution_challenge_app/features/music/model/song_model.dart';
import 'package:solution_challenge_app/features/music/screen/widgets/song_cards.dart';
import 'package:solution_challenge_app/firebase/gauth.dart';
import 'package:solution_challenge_app/common/widgets/appbar/appbar.dart'
    as Appbar;
import '../../../login.dart';
import 'package:http/http.dart' as http;

class MusicPage extends StatefulWidget {
  const MusicPage({super.key});

  @override
  _MusicPageState createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {
  List<String> languages = [
    'Hindi',
    'English',
    'Telugu',
    'Tamil',
    'Kannada',
    'Malayalam',
    'Punjabi',
    'Bengali',
    'Gujarati',
    'Marathi',
    'Odia',
    'Urdu',
  ];
  late String selectedLanguage = 'Hindi';
  List<Song> songs = Song.songs;
  late String? name = "";
  late String? email = "";
  late String? imageUrl = "";
  Future<void> setData() async {
    final user = await GoogleAuth().getUser();
    setState(() {
      name = user?.displayName;
      email = user?.email;
      imageUrl = user?.photoURL;
    });
  }

  @override
  initState() {
    super.initState();
    setData();
    // songs = Song.songs;
  }

  @override
  Widget build(BuildContext context) {
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
        appBar: Appbar.CustomAppBar(
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
                    image: CachedNetworkImageProvider(
                      imageUrl ??
                          'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 34),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 17.0),
                  child: DropdownButton<String>(
                    value: selectedLanguage,
                    items: languages.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setData();
                      setState(() {
                        selectedLanguage = newValue!;
                      });
                    },
                  ),
                ),
                SizedBox(height: 7),
                MusicSections(
                  section_title: '${selectedLanguage} Oldies',
                  songs: [],
                ),
                SizedBox(height: 8),
                MusicSections(
                  section_title: '${selectedLanguage} Melodies',
                  songs: [],
                ),
                SizedBox(height: 8),
                MusicSections(
                  section_title: '${selectedLanguage} Beats',
                  songs: [],
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

class MusicSections extends StatefulWidget {
  final List<Song> songs;
  final String section_title;

  const MusicSections({
    Key? key,
    required this.songs,
    required this.section_title,
  }) : super(key: key);

  @override
  _MusicSectionsState createState() => _MusicSectionsState();
}

class _MusicSectionsState extends State<MusicSections> {
  late bool _isloading = true;
  late List<Song> songs = [];
  @override
  void initState() {
    loadSongs();
    super.initState();
  }

  Future<void> loadSongs() async {
    setState(() {
      _isloading = true;
      songs = [];
    });
    var url = "https://saavn.dev/search/all?query=${widget.section_title}";
    var response = await http.get(Uri.parse(url));
    dynamic data = (jsonDecode(response.body)['data']['songs']['results']);
    List<Song> temp = [];
    for (var song in data) {
      List<dynamic> images = song['image'];
      temp.add(
        Song(
          title: song['title'],
          url: song['url'],
          coverUrl: song['image'][images.length - 1]['link'],
        ),
      );
    }
    log(temp.length.toString());
    setState(() {
      songs = temp;
      _isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    void runSetstate() {
      setState(() {});
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _isloading
          ? [
              const Padding(
                padding: EdgeInsets.only(top: 35.0, left: 25),
                child: CircularProgressIndicator(),
              ),
            ]
          : [
              Padding(
                padding: const EdgeInsets.only(top: 35.0, left: 25),
                child: Text(
                  widget.section_title,
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
                      key: UniqueKey(), // Add a key here
                      scrollDirection: Axis.horizontal,
                      itemCount: songs.length,
                      itemBuilder: ((context, index) {
                        if (index == songs.length) {
                          runSetstate();
                        }
                        return SongCard(key: UniqueKey(), song: songs[index]);
                      }),
                    ),
                  )),
            ],
    );
  }
}
