import 'package:flutter/material.dart';
import 'package:solution_challenge_app/features/journal/screens/widgets/image_widget.dart';
import 'package:solution_challenge_app/features/journal/screens/widgets/journal_audio.dart';
import 'package:solution_challenge_app/features/journal/screens/widgets/journal_image_carousel.dart';
import 'package:solution_challenge_app/features/journal/screens/widgets/new_journal_appbar.dart';
import 'package:flutter_sound/flutter_sound.dart' as fsound;

class OpenJournal extends StatelessWidget {
  OpenJournal({super.key, required this.content});

  final dynamic content;

  @override
  Widget build(BuildContext context) {
    bool isCompleted = false;
    ValueNotifier<bool> isPlayingNotifier = ValueNotifier<bool>(false);
    fsound.FlutterSoundPlayer player = fsound.FlutterSoundPlayer();

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
      } else {
        isPlayingNotifier.value = false;
      }
    }

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
        appBar: CustomAppBar(
          tick: false,
          content: content,
        ),
        //----------------------
        //main body
        //----------------------
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 12,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///-----------------------------
              ///--------heading--------------
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                  vertical: 12,
                ),
                child: Center(
                  child: Text(
                    content['heading'],
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              ///--------thumbnail image & carousel--------------
              const SizedBox(height: 12),
              Center(
                child: content['imagePaths'].length > 0
                    ? content['imagePaths'].length == 1
                        ? BuildImage(imageFile: content['imagePaths'][0])
                        : JournalImageCarousel(
                            imageFiles: content['imagePaths'])
                    : const SizedBox(),
              ),

              ///--------description--------------
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  content['content'],
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 15),

              ///--------audios--------------

              content['audioPaths'].length > 0
                  ? Container(
                      child: Flexible(
                        child: ListView.builder(
                          itemCount: content['audioPaths'].length,
                          itemBuilder: ((context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Transform.translate(
                                  offset: const Offset(-16, 0),
                                  child: AudioItem(
                                      audioPath: content['audioPaths'][index],
                                      playFunction: startPlaying,
                                      stopFunction: pausePlaying,
                                      isplayingNotifier: isPlayingNotifier),
                                ),
                              ],
                            );
                          }),
                        ),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
