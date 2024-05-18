import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:voca3/data/word_service.dart';
import 'package:voca3/data/word_model.dart';
import 'package:voca3/enum/sort_enum.dart';
import 'package:voca3/resource/colors.dart';
import 'package:voca3/resource/styles.dart';
import 'dart:async';
import 'dart:math';

class WordCardLogic {
  final Box<Word> wordsBox;
  late List<Word> _words;
  late List<Word> _randomWords;
  late Timer _timer;
  late WordSortType _currentSortType;
  late WordSortOrder _currentSortOrder;

  WordCardLogic(this.wordsBox) {
    _words = [];
    _randomWords = [];
    _currentSortType = WordSortType.allWords;
    _currentSortOrder = WordSortOrder.lowToHigh;
    _startTimer();
    _updateWords();
  }

  List<Word> get words => _words;
  WordSortType get currentSortType => _currentSortType;
  WordSortOrder get currentSortOrder => _currentSortOrder;

  void toggleMeaningVisibility(int index) {
    Word word = _words[index];
    word.isMeanVisible = !word.isMeanVisible; // Toggle meanVisible field
    _words[index] = word;
  }

  void toggleMemorized(int index) {
    Word word = _words[index];
    if (word.isMemorizedMax) {
      word.memorizedAt = 0;
      word.memorizedCount -= 1;
      word.isMemorized = false;
      word.isMemorizedMax = false;
    } else if (word.isMemorized && word.memorizedAt < 100) {
      word.memorizedAt = 100;
      word.memorizedCount += 1;
      word.updateMemorizedAtCallCount = 0;
    } else if (word.isMemorized && word.memorizedAt == 100) {
      word.isMemorizedMax = true;
    } else {
      word.memorizedAt = 100;
      word.memorizedCount += 1;
      word.isMemorized = true;
      word.updateMemorizedAtCallCount = 0;
    }
    _words[index] = word;
    wordsBox.put(index, word);
    _updateWords();
  }

  void toggleMemorizedOnly(int index) {
    Word word = _words[index];
    if (word.isMemorizedMax) {
      word.memorizedAt = 0;
      word.memorizedCount -= 1;
      word.isMemorized = false;
      word.isMemorizedMax = false;
    } else if (word.isMemorized && word.memorizedAt < 100) {
      word.memorizedAt = 100;
      word.memorizedCount += 1;
      word.updateMemorizedAtCallCount = 0;
    } else if (word.isMemorized && word.memorizedAt == 100) {
      word.isMemorizedMax = true;
    } else {
      word.memorizedAt = 100;
      word.memorizedCount += 1;
      word.isMemorized = true;
      word.updateMemorizedAtCallCount = 0;
    }
    _words[index] = word;
    wordsBox.put(index, word);
  }

  void updateMemorizedAt() {
    for (int i = 0; i < _words.length; i++) {
      Word word = _words[i];
      if (!word.isMemorizedMax && word.isMemorized) {
        word.updateMemorizedAtCallCount++;
        double T = 3; // Half-life of 10 days
        double elapsedDays = word.updateMemorizedAtCallCount.toDouble();
        double memorizedCountFactor = 1 + (word.memorizedCount.toDouble() / 10);
        double R = exp(-0.693 * elapsedDays / (T * memorizedCountFactor));
        double decreased = (1 - R) * word.memorizedAt.toDouble();
        word.memorizedAt = max((word.memorizedAt - decreased).toInt(), 1);
        _words[i] = word;
      }
    }
    _sortWords();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(days: 1), (timer) {
      updateMemorizedAt();
    });
  }

  void _advanceDate() {
    updateMemorizedAt();
  }

  void updateFavorite(int index) {
    Word word = _words[index];
    word.isFavorite = !word.isFavorite;
    _words[index] = word;
    wordsBox.put(index, word); // データベースの更新
  }

  List<Word> _filterWords(List<Word> words) {
    switch (_currentSortType) {
      case WordSortType.allWords:
        return words;
      case WordSortType.nonMemorizedWords:
        return words.where((word) => !word.isMemorizedMax).toList();
      case WordSortType.memorizedWordsNot100:
        return words.where((word) => word.memorizedAt != 100).toList();
    }
  }

  void _sortWords() {
    List<Word> sortedWords = List.from(_words);

    switch (_currentSortOrder) {
      case WordSortOrder.lowToHigh:
        sortedWords.sort((a, b) => a.memorizedAt.compareTo(b.memorizedAt));
        break;
      case WordSortOrder.highToLow:
        sortedWords.sort((a, b) {
          if (a.isMemorizedMax && !b.isMemorizedMax) {
            return -1; // 'a' comes before 'b'
          } else if (!a.isMemorizedMax && b.isMemorizedMax) {
            return 1; // 'b' comes before 'a'
          } else {
            return b.memorizedAt.compareTo(a.memorizedAt);
          }
        });
        break;
      case WordSortOrder.aToZ:
        sortedWords.sort((a, b) => a.word.compareTo(b.word));
        break;
      case WordSortOrder.zToA:
        sortedWords.sort((a, b) => b.word.compareTo(a.word));
        break;
      case WordSortOrder.random:
        if (_randomWords.isEmpty) {
          _randomWords = List.from(_words);
          _randomWords.shuffle();
        }
        sortedWords = List.from(_randomWords);
        break;
    }

    _words = sortedWords;
  }

  void _updateWords() {
    _words = _filterWords(wordsBox.values.toList());
    _sortWords();
  }
}
