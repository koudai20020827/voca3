import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:voca3/data/word_model.dart';
import 'package:path/path.dart';
import 'package:voca3/data/word_adapter.dart';

class DatabaseService {
  late Box<Word> _wordsBox;

  Future<void> initDatabase() async {
    await Hive.initFlutter();
    Hive.registerAdapter(WordAdapter());
    _wordsBox = await Hive.openBox<Word>('words');
  }

  Future<void> addWords(List<Word> words) async {
    words.forEach((word) {
      _wordsBox.add(word);
    });
  }

  List<Word> getWords() {
    return _wordsBox.values.toList();
  }

  Word? getWordById(int id) {
    final word = _wordsBox.values.firstWhere((word) => word.id == id);
    return word;
  }

  List<Word> getWordsBySubLevel(int subLevel) {
    return _wordsBox.values.where((word) => word.subLevel == subLevel).toList();
  }
}
