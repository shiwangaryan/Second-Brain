import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_sound/flutter_sound.dart' as fsound;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class NewJournalPage extends StatefulWidget {
  const NewJournalPage({super.key});

  @override
  State<NewJournalPage> createState() => _NewJournalPageState();
}

class _NewJournalPageState extends State<NewJournalPage> {
  List<Widget> journalContent = [];
  bool tick = true;
  fsound.FlutterSoundRecorder recorder = fsound.FlutterSoundRecorder();
  fsound.FlutterSoundPlayer player = fsound.FlutterSoundPlayer();
  List<String> filePath = [];
  bool micOn = false;
  bool isPlaying = false;
  bool isCompleted = false;
  bool isImageSelected = false;
  late File? imageFile;
  ValueNotifier<bool> isPlayingNotifier = ValueNotifier<bool>(false);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    journalContent.insert(0, journalContentEntry());
    init();
  }

  Widget journalContentEntry() {
    return Transform.translate(
      offset: const Offset(0, -20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Wrap(children: [
          TextField(
            keyboardType: TextInputType.multiline,
            maxLines: null,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
            decoration: InputDecoration(
                hintText: 'write about it',
                hintStyle: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.white.withOpacity(0.5),
                ),
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                )),
          ),
        ]),
      ),
    );
  }

  Future<void> init() async {
    await Permission.microphone.request();
    await Permission.storage.request();
  }

  Future<String?> startRecording() async {
    final directory = await getApplicationDocumentsDirectory();
    final currentFilePath =
        '${directory.path}/recording_${DateTime.now().millisecondsSinceEpoch}.aac';
    await recorder.openRecorder();
    await recorder.startRecorder(
        toFile: currentFilePath, codec: fsound.Codec.aacMP4);

    setState(() {
      micOn = true;
      filePath.insert(0, currentFilePath);
    });
    return filePath[0];
  }

  Future<void> stopRecording() async {
    await recorder.stopRecorder();

    setState(() {
      micOn = false;
      journalContent.insert(
        0,
        AudioItem(
          filePath: filePath[0],
          playFunction: startPlaying,
          stopFunction: pausePlaying,
          isplayingNotifier: isPlayingNotifier,
        ),
        // VoiceNotePlayer(audioLocation: filePath[0]),
      );
    });
  }

  Future<void> startPlaying() async {
    if (!isPlayingNotifier.value) {
      await player.openPlayer();
      await player.startPlayer(fromURI: filePath[0]);
      isPlayingNotifier.value = true;
    } else {
      await player.resumePlayer();
      isPlayingNotifier.value = true;
      player.onProgress!.listen(
        (event) async {
          if (event.duration == event.position) {
            await player.stopPlayer();
            isPlayingNotifier.value = false;
            await player.closePlayer();
            isCompleted = true;
          }
        },
      );
    }
  }

  Future<void> pausePlaying() async {
    if(!isCompleted)
    {await player.pausePlayer();
    isPlayingNotifier.value = false;}

    // setState(() {
    //   isPlaying = false;
    // });
  }



  @override
  void dispose() {
    recorder.closeRecorder();
    player.closePlayer();
    isPlayingNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF4DCDFF),
            Color(0XFF0080bf),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        //----------------------
        //appbar
        //----------------------
        appBar: CustomAppBar(tick: tick),
        //----------------------
        //bottom app bar
        //----------------------
        bottomNavigationBar: BottomAppBar(
          height: 70,
          color: Colors.white.withOpacity(0.13),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //---mic & stop button
              micOn
                  ? CustomIconButton(
                      size: 30,
                      onPressFunc: () => stopRecording(),
                      icon: Icons.stop_circle_outlined,
                    )
                  : CustomIconButton(
                      onPressFunc: () => startRecording(),
                      icon: Icons.mic_none,
                      size: 30,
                    ),
              //---camera button
              CustomIconButton(
                onPressFunc: () {},
                icon: Icons.photo_camera_outlined,
                size: 30,
              ),
            ],
          ),
        ),
        //----------------------
        //main body
        //----------------------
        body: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 1,
              color: Colors.white.withOpacity(0.7),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: TextField(
                maxLines: null,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  hintText: 'Heading',
                  hintStyle: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: Colors.white.withOpacity(0.5),
                  ),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            Flexible(
              child: ListView.builder(
                itemCount: journalContent.length,
                itemBuilder: ((context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      journalContent[index],
                    ],
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//
//
//all the custom widgets here
//
//

class AudioItem extends StatefulWidget {
  final String filePath;
  final VoidCallback playFunction;
  final VoidCallback stopFunction;
  final ValueNotifier<bool> isplayingNotifier;

  const AudioItem({
    required this.filePath,
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
                playing ? widget.playFunction() : widget.stopFunction();
                // if (widget.isplayingNotifier.value == false) {
                //   playing = false;
                // }
              });
        });
  }
}

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    required this.onPressFunc,
    required this.icon,
    required this.size,
  });

  final void Function() onPressFunc;
  final IconData icon;
  final double size;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressFunc,
      icon: Icon(
        icon,
        color: Colors.white,
        size: size,
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.tick,
  });

  final bool tick;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: Padding(
        padding: const EdgeInsets.only(left: 10.0, top: 20),
        child: IconButton(
          onPressed: () => Get.back(),
          color: Colors.white,
          icon: const Icon(
            Icons.arrow_back,
          ),
          iconSize: 28,
        ),
      ),
      actions: [
        tick
            ? Padding(
                padding: const EdgeInsets.only(right: 10.0, top: 20),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.done,
                    size: 28,
                    color: Colors.white,
                  ),
                ),
              )
            : const SizedBox(),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
