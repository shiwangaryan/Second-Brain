// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// import 'package:audioplayers/audioplayers.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:solution_challenge_app/features/music/screen/widgets/seekbar.dart';
import 'package:rxdart/rxdart.dart' as rxdart;

class VoiceNotePlayer extends StatefulWidget {
  const VoiceNotePlayer({super.key, required this.audioLocation});

  final File audioLocation;

  @override
  State<VoiceNotePlayer> createState() => _VoiceNotePlayerState();
}

class _VoiceNotePlayerState extends State<VoiceNotePlayer> {
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();

    audioPlayer.setAudioSource(
      ConcatenatingAudioSource(
        children: [
          AudioSource.uri(Uri.file(widget.audioLocation.path)),
        ],
      ),
    );

    // audioPlayer.setAudioSource(
    //   ConcatenatingAudioSource(
    //     children: [
    //       AudioSource.uri(
    //         Uri.parse(widget.audioLocation),
    //       ),
    //     ],
    //   ),
    // );
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
    return SongSliderPlayer(
      seekBarDataStream: seekBarDataStream,
      audioPlayer: audioPlayer,
    );
  }
}

//widgets used above-----------
//
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
    return Row(
      children: [
        PlayerButtons(audioPlayer: audioPlayer),
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
      ],
    );
  }
}

class PlayerButtons extends StatefulWidget {
  const PlayerButtons({
    super.key,
    required this.audioPlayer,
  });

  final AudioPlayer audioPlayer;

  @override
  State<PlayerButtons> createState() => _PlayerButtonsState();
}

class _PlayerButtonsState extends State<PlayerButtons> {
  @override
  Widget build(BuildContext context) {
    return
        //-----------------------------
        //play/resume/replay
        //-----------------------------
        StreamBuilder<PlayerState>(
      stream: widget.audioPlayer.playerStateStream,
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          final playerState = snapshot.data;
          final processingState = playerState!.processingState;

          if (processingState == ProcessingState.loading ||
              processingState == ProcessingState.buffering) {
            return Container(
              width: 64,
              height: 64,
              margin: const EdgeInsets.all(10),
              child: const SizedBox(
                height: 40,
                width: 40,
                child: CircularProgressIndicator(),
              ),
            );
          } else if (!widget.audioPlayer.playing) {
            return IconButton(
              iconSize: 63,
              onPressed: widget.audioPlayer.play,
              icon: Icon(
                Icons.play_circle,
                color: Colors.white.withOpacity(0.9),
              ),
            );
          } else if (processingState != ProcessingState.completed) {
            return IconButton(
              iconSize: 63,
              onPressed: widget.audioPlayer.pause,
              icon: Icon(
                Icons.pause_circle,
                color: Colors.white.withOpacity(0.9),
              ),
            );
          } else {
            return IconButton(
              iconSize: 58,
              onPressed: () => widget.audioPlayer.seek(Duration.zero,
                  index: widget.audioPlayer.effectiveIndices!.first),
              icon: Icon(
                Icons.replay_circle_filled_rounded,
                color: Colors.white.withOpacity(0.9),
              ),
            );
          }
        } else {
          return const CircularProgressIndicator();
        }
      }),
    );
    //-----------------------------
  }
}
