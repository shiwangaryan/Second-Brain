import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart' as fsound;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pair/pair.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:solution_challenge_app/features/journal/screens/widgets/custom_icons.dart';
import 'package:solution_challenge_app/features/journal/screens/widgets/image_widget.dart';
import 'package:solution_challenge_app/features/journal/screens/widgets/journal_audio.dart';
import 'package:solution_challenge_app/features/journal/screens/widgets/journal_content_entry.dart';
import 'package:solution_challenge_app/features/journal/screens/widgets/journal_image_carousel.dart';
import 'package:solution_challenge_app/features/journal/screens/widgets/new_journal_appbar.dart';

class NewJournalPage extends StatefulWidget {
  const NewJournalPage({super.key, required this.addToHiveBox});

  final void Function() addToHiveBox;

  @override
  State<NewJournalPage> createState() => _NewJournalPageState();
}

class _NewJournalPageState extends State<NewJournalPage> {
  List<Widget> journalContent = [];
  List<String> imageFiles = [];
  List<String> audioPaths = [];
  bool tick = true;
  bool micOn = false;
  bool isPlaying = false;
  bool isCompleted = false;
  bool isImageSelected = false;
  int numberOfImage = 0;
  final contentController = TextEditingController();
  final headingController = TextEditingController();
  fsound.FlutterSoundRecorder recorder = fsound.FlutterSoundRecorder();
  fsound.FlutterSoundPlayer player = fsound.FlutterSoundPlayer();
  ValueNotifier<bool> isPlayingNotifier = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    init();
    journalContent.add(
      journalContentEntry(contentController),
    );
    createJournalImageAudioDir();
  }

  Future<void> createJournalImageAudioDir() async {
    final directory = await getApplicationDocumentsDirectory();
    final journalDirectory = Directory('${directory.path}/journal');
    if(!await journalDirectory.exists()){
      await journalDirectory.create(recursive: true);
    }
    final imageDirectory = Directory('${journalDirectory.path}/images');
    if (!await imageDirectory.exists()) {
      await imageDirectory.create();
    }
    final audioDirectory = Directory('${journalDirectory.path}/audios');
    if (!await audioDirectory.exists()) {
      await audioDirectory.create();
    }
  }

  Future<void> init() async {
    await Permission.microphone.request();
    await Permission.storage.request();
  }

  //----- submit content

  Future<Pair<bool, int>> submitContent() async {
    if (headingController.text.isEmpty || contentController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('heading & content both are empty'),
            actions: <Widget>[
              Container(
                decoration: BoxDecoration(
                    color: Colors.black87.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'OK',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          );
        },
      );
      return const Pair<bool, int>(false, -1);
    } else {
      var journalContent = {
        'heading': headingController.text,
        'imagePaths': imageFiles,
        'content': contentController.text,
        'audioPaths': audioPaths,
      };

      var box = Hive.box('journal');
      var contentKey = await box.add(journalContent);
      widget.addToHiveBox();

      contentController.clear();
      headingController.clear();
      recorder.closeRecorder();
      player.closePlayer();
      return Pair<bool, int>(true, contentKey);
    }
  }

  //----- recording + playing functions:

  Future<void> startRecording() async {
    final directory = await getApplicationDocumentsDirectory();
    final currentFilePath =
        '${directory.path}/journal/audios/recording_${DateTime.now().millisecondsSinceEpoch}.aac';
    await recorder.openRecorder();
    await recorder.startRecorder(
        toFile: currentFilePath, codec: fsound.Codec.aacMP4);

    setState(() {
      micOn = true;
      audioPaths.add(currentFilePath);
    });
  }

  Future<void> stopRecording() async {
    final audioPath = await recorder.stopRecorder();

    setState(() {
      micOn = false;
      journalContent.add(
        AudioItem(
          audioPath: audioPath!,
          playFunction: (audioPath) async {
            await startPlaying(audioPath);
          },
          stopFunction: pausePlaying,
          isplayingNotifier: isPlayingNotifier,
        ),
      );
    });
  }

  Future<void> startPlaying(String audioPath) async {
    if (!isPlayingNotifier.value) {
      await player.openPlayer();
      await player.startPlayer(fromURI: audioPath);
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
    if (!isCompleted) {
      await player.pausePlayer();
      isPlayingNotifier.value = false;
    } else if (isCompleted) {
      isPlayingNotifier.value = false;
    }
  }

  //----- image picker from gallery func

  pickImagefromGallery() async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        final directory = await getApplicationDocumentsDirectory();
        final imagePath = File(
            '${directory.path}/journal/images/${DateTime.now().millisecondsSinceEpoch}.jpg');
        final imageBytes = await pickedImage.readAsBytes();
        await imagePath.writeAsBytes(imageBytes);

        setState(() {
          imageFiles.insert(numberOfImage, imagePath.path);
          numberOfImage += 1;
          isImageSelected = true;
        });
      } else {
        print('no image selected');
      }
    } catch (e) {
      print('error occured: $e');
    }
  }

  @override
  void dispose() {
    recorder.closeRecorder();
    player.closePlayer();
    isPlayingNotifier.dispose();
    super.dispose();
  }

  //----- main build function

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
        appBar: CustomAppBar(submitFunc: () => submitContent(), tick: true),
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
                onPressFunc: () => pickImagefromGallery(),
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
            ///--------heading--------------
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 12,
              ),
              child: TextField(
                controller: headingController,
                maxLines: null,
                maxLength: 52,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  counterText: "",
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

            ///--------thumbnail image--------------

            isImageSelected
                ? imageFiles.length == 1
                    ? BuildImage(imageFile: imageFiles[0])
                    : JournalImageCarousel(
                        imageFiles: imageFiles,
                      )
                : InkWell(
                    onTap: () => pickImagefromGallery(),
                    child: Center(
                      child: Container(
                        width: 380,
                        height: 250,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Center(
                          child: Text(
                            'select a thumbnail image',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black26,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

            ///--------rest of the content--------------

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
