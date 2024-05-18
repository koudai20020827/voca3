// V2
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:voca3/data/word_service.dart';
import 'package:voca3/data/word_logic_service.dart';
import 'package:voca3/data/word_model.dart';
import 'package:voca3/enum/sort_enum.dart';
import 'package:voca3/resource/colors.dart';
import 'package:voca3/resource/styles.dart';
import 'dart:async';
import 'dart:math';

class WordCard extends StatefulWidget {
  const WordCard({Key? key}) : super(key: key);

  @override
  _WordCardState createState() => _WordCardState();
}

class _WordCardState extends State<WordCard> {
  late Box<Word> _wordsBox;
  late Timer _timer;

  List<Word> _words = [];
  List<Word> _randomWords = []; // Random mode用の順番を保持するリスト
  WordSortType _currentSortType = WordSortType.allWords;
  WordSortOrder _currentSortOrder = WordSortOrder.lowToHigh;

  @override
  void initState() {
    super.initState();
    _wordsBox = Hive.box<Word>('words');
    _startTimer();
    _updateWords();
  }

  void _toggleMeaningVisibility(int index) {
    Word word = _words[index];
    word.isMeanVisible = !word.isMeanVisible; // Toggle meanVisible field
    setState(() {
      _words[index] = word;
    });
  }

  void _toggleMemorized(int index) {
    Word word = _words[index];
    setState(() {
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
      _updateWords();
    });
  }

  void _updateMemorizedAt() {
    setState(() {
      for (int i = 0; i < _words.length; i++) {
        Word word = _words[i];
        if (!word.isMemorizedMax && word.isMemorized) {
          word.updateMemorizedAtCallCount++;
          double T = 3; // Half-life of 10 days
          double elapsedDays = word.updateMemorizedAtCallCount.toDouble();
          double memorizedCountFactor = 1 +
              (word.memorizedCount.toDouble() /
                  10); // Adjust factor based on memorized count
          double R = exp(-0.693 * elapsedDays / (T * memorizedCountFactor));
          double decreased = (1 - R) * word.memorizedAt.toDouble();
          word.memorizedAt = max((word.memorizedAt - decreased).toInt(), 1);
          _words[i] = word;
        }
      }
      _sortWords();
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(days: 1), (timer) {
      _updateMemorizedAt();
    });
  }

  // test
  void _advanceDate() {
    _updateMemorizedAt();
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
        // Random modeの場合は最初の順番を保持
        if (_randomWords.isEmpty) {
          _randomWords = List.from(_words);
          _randomWords.shuffle();
        }
        sortedWords = List.from(_randomWords);
        break;
    }

    setState(() {
      _words = sortedWords;
    });
  }

  void _updateWords() {
    _words = _filterWords(_wordsBox.values.toList());
    _sortWords();
  }

  DataRow recentFileDataRow(Word word, int index) {
    return DataRow(
      cells: [
        DataCell(
          Row(
            children: [
              Flexible(
                flex: 1,
                child: AspectRatio(
                  aspectRatio: 1.0,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    child: Stack(
                      children: [
                        if (word.isMemorizedMax)
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.9,
                            decoration: BoxDecoration(
                              color: (!word.isMemorized || !word.isMemorizedMax)
                                  ? Colors.grey.withOpacity(0.5)
                                  : null,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(5),
                                bottomRight: Radius.circular(5),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            height: MediaQuery.of(context).size.height *
                                1.1 *
                                (word.memorizedAt / 2000),
                            decoration: BoxDecoration(
                              color: (!word.isMemorized || word.isMemorizedMax)
                                  ? null
                                  : Colors.green,
                              borderRadius:
                                  (!word.isMemorized || word.isMemorizedMax)
                                      ? null
                                      : BorderRadius.only(
                                          topLeft: Radius.circular(5),
                                          topRight: Radius.circular(5),
                                        ),
                            ),
                          ),
                        ),
                        Positioned.fill(
                          child: ElevatedButton(
                            onPressed: () {
                              _toggleMemorized(index);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              padding: EdgeInsets.zero,
                              alignment: Alignment.center,
                            ),
                            child: Center(
                              child: Text(
                                '${word.memorizedCount.toString().padLeft(2, '0')}',
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(word.word, style: AppTextStyle.listStyle),
              ),
            ],
          ),
        ),
        DataCell(
          SizedBox(
            width: 150,
            child: GestureDetector(
              onTap: () {
                _toggleMeaningVisibility(index);
              },
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                switchInCurve: Curves.easeIn,
                switchOutCurve: Curves.easeOut,
                transitionBuilder: (child, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
                child:
                    word.isMeanVisible // Use meanVisible field to decide visibility
                        ? Visibility(
                            key: ValueKey<int>(index),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: Text(
                                    word.meaning,
                                    style: AppTextStyle.listStyle,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : SizedBox(width: 150, child: Text('')),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(defaultPadding),
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: ValueListenableBuilder<Box<Word>>(
          valueListenable: _wordsBox.listenable(),
          builder: (context, box, _) {
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: DataTable(
                      columnSpacing: 16.0,
                      columns: [
                        DataColumn(
                          label: Text(
                            "Word Name",
                            style: AppTextStyle.listColumnStyle,
                          ),
                        ),
                        DataColumn(
                          label: SizedBox(
                            width: 150,
                            child: Text(
                              "Meaning",
                              style: AppTextStyle.listColumnStyle,
                            ),
                          ),
                        ),
                      ],
                      rows: _words.isNotEmpty
                          ? List.generate(
                              _words.length,
                              (index) =>
                                  recentFileDataRow(_words[index], index),
                            )
                          : [
                              DataRow(
                                cells: [
                                  DataCell(
                                    Text('No Words'),
                                  ),
                                  DataCell(
                                    SizedBox.shrink(),
                                  ),
                                ],
                              ),
                            ],
                    ),
                  ),
                  SizedBox(
                      height: 16), // Add some space between table and button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DropdownButton<WordSortType>(
                        value: _currentSortType,
                        onChanged: (value) {
                          setState(() {
                            _currentSortType = value!;
                            _updateWords();
                          });
                        },
                        items: [
                          DropdownMenuItem(
                            value: WordSortType.allWords,
                            child: Text('All Words'),
                          ),
                          DropdownMenuItem(
                            value: WordSortType.nonMemorizedWords,
                            child: Text('Non-Memorized Words'),
                          ),
                          DropdownMenuItem(
                            value: WordSortType.memorizedWordsNot100,
                            child: Text('Memorized Words Not 100'),
                          ),
                        ],
                      ),
                      DropdownButton<WordSortOrder>(
                        value: _currentSortOrder,
                        onChanged: (value) {
                          setState(() {
                            _currentSortOrder = value!;
                            _updateWords();
                          });
                        },
                        items: [
                          DropdownMenuItem(
                            value: WordSortOrder.lowToHigh,
                            child: Text('Low to High'),
                          ),
                          DropdownMenuItem(
                            value: WordSortOrder.highToLow,
                            child: Text('High to Low'),
                          ),
                          DropdownMenuItem(
                            value: WordSortOrder.aToZ,
                            child: Text('A to Z'),
                          ),
                          DropdownMenuItem(
                            value: WordSortOrder.zToA,
                            child: Text('Z to A'),
                          ),
                          DropdownMenuItem(
                            value: WordSortOrder.random,
                            child: Text('Random'),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                      height: 16), // Add some space between table and button
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: _advanceDate,
                      child: Text('1日進める' +
                          (_words.isNotEmpty
                              ? '${_words[0].memorizedAt},${_words.length > 1 ? _words[1].memorizedAt : ""}'
                              : '')),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
