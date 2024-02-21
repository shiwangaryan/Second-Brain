import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import "package:solution_challenge_app/app.dart";
import 'package:solution_challenge_app/firebase_options.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  await Hive.openBox('user');
  await Hive.openBox('memories');
  await Hive.openBox('medicines');
  runApp(const App());
}

// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_sound/flutter_sound.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Notes App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: NotesScreen(),
//     );
//   }
// }

// class NotesScreen extends StatefulWidget {
//   @override
//   _NotesScreenState createState() => _NotesScreenState();
// }

// class _NotesScreenState extends State<NotesScreen> {
//   FlutterSoundRecorder _recorder = FlutterSoundRecorder();
//   FlutterSoundPlayer _player = FlutterSoundPlayer();
//   String? _filePath;
//   bool _isRecording = false;
//   bool _isPlaying = false;

//   @override
//   void initState() {
//     super.initState();
//     _init();
//   }

//   Future<void> _init() async {
//     await Permission.microphone.request();
//     await Permission.storage.request();
//   }

//   Future<String?> _startRecording() async {
//     final directory = await getApplicationDocumentsDirectory();
//     final filePath =
//         '${directory.path}/recording_${DateTime.now().millisecondsSinceEpoch}.aac';
//     await _recorder.openRecorder();
//     await _recorder.startRecorder(toFile: filePath, codec: Codec.aacMP4);
//     setState(() {
//       _isRecording = true;
//       _filePath = filePath;
//     });
//     return filePath;
//   }

//   Future<void> _stopRecording() async {
//     await _recorder.stopRecorder();
//     setState(() {
//       _isRecording = false;
//     });
//   }

//   Future<void> _playRecording() async {
//     await _player.openPlayer();
//     await _player.startPlayer(fromURI: _filePath!);
//     setState(() {
//       _isPlaying = true;
//     });

//   }

//   Future<void> _stopPlaying() async {
//     await _player.stopPlayer();
//     setState(() {
//       _isPlaying = false;
//     });
//   }

//   @override
//   void dispose() {
//     _recorder.closeRecorder();
//     _player.closePlayer();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Notes'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             _isRecording
//                 ? Text('Recording...', style: TextStyle(fontSize: 20))
//                 : _isPlaying
//                     ? Text('Playing...', style: TextStyle(fontSize: 20))
//                     : Text('Not Recording', style: TextStyle(fontSize: 20)),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: !_isRecording
//                   ? () async {
//                       await _startRecording();
//                     }
//                   : null,
//               child: Text('Start Recording'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _isRecording
//                   ? () async {
//                       await _stopRecording();
//                     }
//                   : null,
//               child: Text('Stop Recording'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: !_isPlaying && _filePath != null
//                   ? () async {
//                       await _playRecording();
//                     }
//                   : null,
//               child: Text('Play Recording'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _isPlaying
//                   ? () async {
//                       await _stopPlaying();
//                     }
//                   : null,
//               child: Text('Stop Playing'),
//             ),
//             SizedBox(height: 20),
//             (_filePath != null) ? Text('File Path: $_filePath'):Text('error'),
//           ],
//         ),
//       ),
//     );
//   }
