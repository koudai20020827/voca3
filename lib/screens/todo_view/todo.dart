// pages/home_page.dart
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:voca3/data/word_model.dart';
import 'package:voca3/data/word_service.dart';
import 'package:voca3/common/json_parse.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Box<Word> _wordsBox;

  @override
  void initState() {
    super.initState();
    _wordsBox = Hive.box<Word>('words');
  }

  void _addWord(String wordName) {
    final newWord = Word(
        id: _wordsBox.values.length + 1,
        secondId: '',
        level: 1,
        subLevel: 1,
        word: wordName,
        meaning: '',
        part: '',
        pronunciation: '',
        etymology: '',
        idiom: '',
        collocation: '',
        synonyms: '',
        isMemorized: false,
        isMemorizedMax: false,
        memorizedAt: 0,
        memorizedCount: 0,
        updateMemorizedAtCallCount: 100,
        isFavorite: false,
        isMeanVisible: false);
    _wordsBox.add(newWord);
  }

  void _toggleMemorized(int index) {
    final word = _wordsBox.getAt(index);
    word!.isMemorized = !word.isMemorized;
    _wordsBox.putAt(index, word);
  }

  void _deleteWord(int index) {
    _wordsBox.deleteAt(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hive SQL Demo'),
      ),
      body: ValueListenableBuilder(
        valueListenable: _wordsBox.listenable(),
        builder: (context, Box<Word> wordsBox, _) {
          final words = wordsBox.values.toList();
          return ListView.builder(
            itemCount: words.length,
            itemBuilder: (context, index) {
              final word = words[index];
              return ListTile(
                title: Text(word.word),
                leading: Checkbox(
                  value: word.isMemorized,
                  onChanged: (_) => _toggleMemorized(index),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _deleteWord(index),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Add Word'),
                content: TextField(
                  autofocus: true,
                  onSubmitted: (value) {
                    _addWord(value);
                    Navigator.pop(context);
                  },
                ),
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
