// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solution_challenge_app/features/music/model/song_model.dart';
import 'package:solution_challenge_app/features/music/screen/song_screen.dart';

class SongCard extends StatelessWidget {
  const SongCard({
    super.key,
    required this.song,
  });

  final Song song;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(
        SongScreen(song: song),
        duration: Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      ),
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: NetworkImage(song.coverUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 1,
                  sigmaY: 1,
                ),
                child: Container(
                  height: 50,
                  margin: const EdgeInsets.only(bottom: 12),
                  width: MediaQuery.of(context).size.width * 0.43,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white.withOpacity(0.8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              song.title,
                              style: TextStyle(
                                color: Color.fromARGB(255, 0, 104, 156),
                                fontFamily: 'Poppins',
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Text(
                              song.singer,
                              style: TextStyle(
                                color: Colors.black87,
                                fontFamily: 'Poppins',
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.play_circle,
                          color: Colors.black87,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
