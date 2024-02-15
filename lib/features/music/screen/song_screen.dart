// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:solution_challenge_app/features/music/model/song_model.dart';
import 'package:solution_challenge_app/features/music/screen/widgets/playbuttons.dart';
import 'package:solution_challenge_app/features/music/screen/widgets/seekbar.dart';
import 'package:rxdart/rxdart.dart' as rxdart;

class SongScreen extends StatefulWidget {
  const SongScreen({super.key, required this.song});

  final Song song;

  @override
  State<SongScreen> createState() => _SongScreenState();
}

class _SongScreenState extends State<SongScreen> {
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();

    audioPlayer.setAudioSource(
      ConcatenatingAudioSource(
        children: [
          AudioSource.uri(
            Uri.parse('asset:///${widget.song.url}'),
          ),
        ],
      ),
    );
  }

  //to dispose i.e. close the player when we close the song
  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  //creating the seekbar i.e. controller for our audio track
  Stream<SeekBarData> get seekBarDataStream =>
      rxdart.Rx.combineLatest2<Duration, Duration?, SeekBarData>(
        audioPlayer.positionStream,
        audioPlayer.durationStream,
        (Duration position, Duration? duration) {
          return SeekBarData(
            position,
            duration ?? Duration.zero,
          );
        },
      );

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

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
        extendBodyBehindAppBar: true,
        //--- app bar
        appBar: CustomAppBar(),
        //--- body
        body: Padding(
          padding: const EdgeInsets.only(top: 140.0),
          child: Column(
            children: [
              SongCover(
                screen_width: screenWidth,
                song: widget.song,
              ),
              SizedBox(height: 46),
              Text(
                widget.song.title,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Text(
                widget.song.singer,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 3),
              SongSliderPlayer(
                seekBarDataStream: seekBarDataStream,
                audioPlayer: audioPlayer,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//widgets used above-----------

//custom app bar
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      toolbarHeight: 60,
      automaticallyImplyLeading: false,
      leading: Padding(
        padding: const EdgeInsets.only(top: 27.0, left: 18),
        child: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          iconSize: 26,
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.only(top: 35.0),
        child: Text(
          'Now Playing',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Poppins',
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(60);
}

// slider for song ---------------
class SongSliderPlayer extends StatelessWidget {
  const SongSliderPlayer({
    super.key,
    required this.seekBarDataStream,
    required this.audioPlayer,
  });

  final Stream<SeekBarData> seekBarDataStream;
  final AudioPlayer audioPlayer;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamBuilder<SeekBarData>(
          stream: seekBarDataStream,
          builder: ((context, snapshot) {
            final postionData = snapshot.data;

            return SeekBar(
              position: postionData?.position ?? Duration.zero,
              duration: postionData?.duration ?? Duration.zero,
              onChangeEnd: audioPlayer.seek,
            );
          }),
        ),
        PlayerButtons(audioPlayer: audioPlayer)
      ],
    );
  }
}

// song cover -----------
class SongCover extends StatelessWidget {
  const SongCover({
    super.key,
    required this.screen_width,
    required this.song,
  });

  final double screen_width;
  final Song song;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: screen_width * 0.88,
          width: screen_width * 0.86,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
              image: NetworkImage(song.coverUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}
