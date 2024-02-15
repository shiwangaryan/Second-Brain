import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

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
    bool hasPreviousSong = widget.audioPlayer.hasPrevious;
    bool hasNextSong = widget.audioPlayer.hasNext;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //-----------------------------
        //prev button
        //-----------------------------
        StreamBuilder<SequenceState?>(
          stream: widget.audioPlayer.sequenceStateStream,
          builder: ((context, snapshot) {
            return IconButton(
              iconSize: 45,
              onPressed: () {
                hasPreviousSong
                    ? {
                        widget.audioPlayer.seekToPrevious(),
                        setState(() {
                          hasPreviousSong = widget.audioPlayer.hasPrevious;
                        })
                      }
                    : {};
              },
              icon: Icon(
                Icons.skip_previous,
                color: hasPreviousSong ? Colors.white : Colors.white60,
              ),
            );
          }),
        ),
        //-----------------------------
        //play/resume/replay
        //-----------------------------
        StreamBuilder<PlayerState>(
          stream: widget.audioPlayer.playerStateStream,
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              final playerState = snapshot.data;
              final processingState = playerState!.processingState;
              hasPreviousSong = widget.audioPlayer.hasPrevious;
              hasNextSong = widget.audioPlayer.hasNext;

              if (processingState == ProcessingState.loading ||
                  processingState == ProcessingState.buffering) {
                return Container(
                  width: 64,
                  height: 64,
                  margin: EdgeInsets.all(10),
                  child: Container(
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
        ),
        //-----------------------------
        //next button
        //-----------------------------
        StreamBuilder<SequenceState?>(
          stream: widget.audioPlayer.sequenceStateStream,
          builder: ((context, snapshot) {
            return IconButton(
              iconSize: 45,
              onPressed: () {
                hasNextSong
                    ? {
                        widget.audioPlayer.seekToNext(),
                        setState(() {
                          hasNextSong = widget.audioPlayer.hasNext;
                        })
                      }
                    : {};
              },
              icon: Icon(
                Icons.skip_next,
                color: hasNextSong ? Colors.white : Colors.white60,
              ),
            );
          }),
        ),
      ],
    );
  }
}
