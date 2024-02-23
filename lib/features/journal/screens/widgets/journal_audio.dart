import 'package:flutter/material.dart';

class AudioItem extends StatefulWidget {
  final String audioPath;
  final Function(String) playFunction;
  final VoidCallback stopFunction;
  final ValueNotifier<bool> isplayingNotifier;

  const AudioItem({
    required this.audioPath,
    required this.playFunction,
    required this.stopFunction,
    required this.isplayingNotifier,
    Key? key,
  }) : super(key: key);

  @override
  State<AudioItem> createState() => _AudioItemState();
}

class _AudioItemState extends State<AudioItem> {
  bool playing = false;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: widget.isplayingNotifier,
        builder: (context, isPlaying, child) {
          return ListTile(
              leading: playing
                  ? const Icon(
                      Icons.pause_circle_outline_rounded,
                      color: Colors.white,
                      size: 40,
                    )
                  : const Icon(
                      Icons.play_circle_outline_rounded,
                      color: Colors.white,
                      size: 40,
                    ),
              title: Text(
                playing ? 'Stop Playing' : 'Start Playing',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              onTap: () {
                setState(() {
                  playing = !playing;
                });
                playing
                    ? widget.playFunction(widget.audioPath)
                    : widget.stopFunction();
                // if (widget.isplayingNotifier.value == false) {
                //   playing = false;
                // }
              });
        });
  }
}
