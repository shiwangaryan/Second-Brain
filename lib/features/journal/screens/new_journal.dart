import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter_sound/flutter_sound.dart';
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
  FlutterSoundRecorder recorder = FlutterSoundRecorder();
  FlutterSoundPlayer player = FlutterSoundPlayer();
  List<String> filePath = [];
  bool micOn = false;
  bool isPlaying = false;

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
    final directory = await getApplicationCacheDirectory();
    final currentFilePath =
        '${directory.path}/recording_${DateTime.now().millisecondsSinceEpoch}.aac';
    await recorder.openRecorder();
    await recorder.startRecorder(toFile: currentFilePath, codec: Codec.aacMP4);

    setState(() {
      micOn = !micOn;
      filePath.insert(0, currentFilePath);
    });
    return filePath[0];
  }

  Future<void> stopRecording() async {
    await recorder.stopRecorder();

    setState(() {
      micOn = false;
    });
  }

  Future<void> playRecording() async {
    await player.openPlayer();
    await player.startPlayer(fromURI: filePath[0]);

    setState(() {
      isPlaying = true;
    });
  }

  Future<void> stopPlaying() async {
    await player.stopPlayer();

    setState(() {
      isPlaying = false;
    });
  }

  @override
  void dispose() {
    recorder.closeRecorder();
    player.closePlayer();
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
        appBar: CustomAppBar(tick: tick),
        bottomNavigationBar: BottomAppBar(
          height: 70,
          color: Colors.white.withOpacity(0.13),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomIconButton(
                onPressFunc: () => startRecording(),
                icon: Icons.mic_none,
                size: 30,
              ),
              micOn
                  ? CustomIconButton(
                      size: 30,
                      onPressFunc: () {
                        setState(() {
                          journalContent.add(
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: CustomIconButton(
                                onPressFunc: () {
                                  setState(() {
                                    isPlaying = !isPlaying;
                                    isPlaying ? playRecording() : stopPlaying();
                                  });
                                },
                                icon: isPlaying
                                    ? Icons.pause_circle_outline
                                    : Icons.play_circle_outline_rounded,
                                size: 46,
                              ),
                            ),
                          );
                        });
                        stopRecording();
                      },
                      icon: Icons.stop_circle_outlined,
                    )
                  : const SizedBox(width: 0, height: 0),
              CustomIconButton(
                onPressFunc: () {},
                icon: Icons.photo_camera_outlined,
                size: 30,
              ),
            ],
          ),
        ),
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
                    )),
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
