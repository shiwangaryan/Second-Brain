// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:solution_challenge_app/features/music/model/song_model.dart';
import 'package:solution_challenge_app/features/music/screen/widgets/playbuttons.dart';
import 'package:solution_challenge_app/features/music/screen/widgets/seekbar.dart';
import 'package:rxdart/rxdart.dart' as rxdart;
import 'package:get/get.dart';

class SongScreen extends StatefulWidget {
  const SongScreen({super.key});

  @override
  State<SongScreen> createState() => _SongScreenState();
}

class _SongScreenState extends State<SongScreen> {
  Song song = Song.songs[0];
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();

    audioPlayer.setAudioSource(
      ConcatenatingAudioSource(
        children: [
          AudioSource.uri(
            Uri.parse('asset:///${Song.songs[0].url}'),
          ),
          AudioSource.uri(
            Uri.parse('asset:///${Song.songs[1].url}'),
          ),
          AudioSource.uri(
            Uri.parse('asset:///${Song.songs[2].url}'),
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
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 140.0),
          child: Column(
            children: [
              SongCover(
                screen_width: screenWidth,
                song: song,
              ),
              SongSliderPlayer(
                  seekBarDataStream: seekBarDataStream,
                  audioPlayer: audioPlayer),
            ],
          ),
        ),
      ),
    );
  }
}

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
          height: screen_width * 0.85,
          width: screen_width * 0.84,
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
