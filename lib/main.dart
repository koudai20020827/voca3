import 'package:flutter/material.dart';
import 'package:voca3/routes.dart';
import 'package:voca3/screens/word_view/word_view.dart';
import 'package:voca3/theme.dart';
import 'package:voca3/data/word_service.dart';
import 'package:voca3/data/word_model.dart';
import 'package:voca3/common/json_parse.dart';
import 'package:audioplayers/audioplayers.dart';

// void main() async {
//   DatabaseService databaseService = DatabaseService();
//   await databaseService.initDatabase();

//   List<Word> words = databaseService.getWords();

//   if (words.isEmpty) {
//     words = await loadWordsFromJson();
//     await databaseService.addWords(words);
//   }

//   runApp(MyApp(words: words)); // MyAppにwordsを渡す
// }

// class MyApp extends StatelessWidget {
//   final List<Word> words; // MyAppのコンストラクタにwordsを追加

//   const MyApp({Key? key, required this.words}) : super(key: key);

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'The Flutter Way - Template',
//       initialRoute: WordViewScreen.routeName,
//       routes: routes,
//       // WordViewScreenにwordsを渡す
//       onGenerateRoute: (settings) {
//         if (settings.name == WordViewScreen.routeName) {
//           return MaterialPageRoute(
//             builder: (context) => WordViewScreen(words: words),
//           );
//         }
//         return null;
//       },
//     );
//   }
// }

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Audio Player'),
        ),
        body: Center(
          child: AudioPlayerWidget(),
        ),
      ),
    );
  }
}

class AudioPlayerWidget extends StatefulWidget {
  @override
  _AudioPlayerWidgetState createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  Future<void> playSound() async {
    if (!isPlaying) {
      int result = await audioPlayer.play('assets/mp3/1_1.mp3', isLocal: true);
      if (result == 1) {
        setState(() {
          isPlaying = true;
        });
      }
    } else {
      audioPlayer.pause();
      setState(() {
        isPlaying = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
          iconSize: 48.0,
          onPressed: () {
            playSound();
          },
        ),
      ],
    );
  }
}
