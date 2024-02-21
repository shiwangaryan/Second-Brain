// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:record/record.dart';
// import 'package:audioplayers/audioplayers.dart';

// class AudioRecorderPlayer extends StatefulWidget {
//   const AudioRecorderPlayer({super.key});

//   @override
//   State<AudioRecorderPlayer> createState() => _AudioRecorderPlayerState();
// }

// class _AudioRecorderPlayerState extends State<AudioRecorderPlayer> {
//   late AudioRecorder audioRecorder;
//   late AudioPlayer audioPlayer;
//   String audioRecordedPath = '';
//   bool isRecording = false;
//   bool isPlaying = false;
//   bool isAudioCompleted = true;

//   @override
//   void initState() {
//     audioRecorder = AudioRecorder();
//     audioPlayer = AudioPlayer();
//     init();
//     super.initState();
//   }

//   Future<void> init() async {
//     await Permission.microphone.request();
//     await Permission.storage.request();
//   }

//   @override
//   void dispose() {
//     audioPlayer.dispose();
//     audioRecorder.dispose();
//     super.dispose();
//   }

//   Future<void> startRecording() async {
//     try {
//       final directory = await getApplicationDocumentsDirectory();
//       final String audioPath =
//           '$directory/${DateTime.now().millisecondsSinceEpoch}.aac';

//       await audioRecorder.start(RecordConfig(), path: audioPath);

//       setState(() {
//         isRecording = true;
//       });
//     } catch (e) {
//       print('error recording: $e');
//     }
//   }

//   Future<void> stopRecording() async {
//     try {
//       final String? path = await audioRecorder.stop();

//       setState(() {
//         isRecording = false;
//         audioRecordedPath = path!;
//       });
//     } catch (e) {
//       print('error occured: $e');
//     }
//   }

//   Future<void> playRecording() async {
//     try {
//       if (isAudioCompleted) {
//         Source urlSource = UrlSource(audioRecordedPath);
//         await audioPlayer.play(urlSource);
//         setState(() {
//           isPlaying = true;
//         });
//       } else {
//         audioPlayer.resume();
//         setState(() {
//           isPlaying = true;
//         });
//       }
//     } catch (e) {
//       print('Error occured: $e');
//     }
//   }

//   Future<void> pausePlaying() async {
//     try {
//       await audioPlayer.pause();
//     } catch (e) {
//       print('Error occured: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(title: Text('audio recorder')),
//         body: Column(
//           children: [
//             isRecording
//                 ? IconButton(
//                     onPressed: () => stopRecording(), icon: Icon(Icons.stop))
//                 : IconButton(
//                     onPressed: () => startRecording(), icon: Icon(Icons.mic)),
//             isPlaying
//                 ? IconButton(
//                     onPressed: () => pausePlaying(), icon: Icon(Icons.pause))
//                 : IconButton(
//                     onPressed: () => playRecording(),
//                     icon: Icon(Icons.play_arrow)),
//           ],
//         ));
//   }
// }
