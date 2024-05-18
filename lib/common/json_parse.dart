import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:voca3/data/word_model.dart';

Future<List<Word>> loadWordsFromJson() async {
  // JSONファイルの読み込み
  String data = await rootBundle.loadString('assets/json/words.json');
  // JSONデータのパース
  List<dynamic> jsonList = jsonDecode(data)['words'];

  // Wordオブジェクトに変換
  List<Word> words = jsonList.map((json) {
    return Word(
      id: json['id'],
      secondId: json['secondId'],
      level: json['level'],
      subLevel: json['subLevel'],
      word: json['word'],
      meaning: json['meaning'],
      part: json['part'],
      pronunciation: json['pronunciation'],
      etymology: json['etymology'],
      idiom: json['idiom'],
      collocation: json['collocation'],
      synonyms: json['synonyms'],
      isMemorized: json['isMemorized'],
      isMemorizedMax: json['isMemorizedMax'],
      memorizedAt: json['memorizedAt'],
      memorizedCount: json['memorizedCount'],
      updateMemorizedAtCallCount: 0,
      isFavorite: json['isFavorite'],
      isMeanVisible: false,
    );
  }).toList();

  return words;
}
