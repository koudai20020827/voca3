import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class Word extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String secondId;

  @HiveField(2)
  final int level;

  @HiveField(3)
  final int subLevel;

  @HiveField(4)
  final String word;

  @HiveField(5)
  final String meaning;

  @HiveField(6)
  final String part;

  @HiveField(7)
  final String pronunciation;

  @HiveField(8)
  final String etymology;

  @HiveField(9)
  final String idiom;

  @HiveField(10)
  final String collocation;

  @HiveField(11)
  final String synonyms;

  @HiveField(12)
  bool isMemorized;

  @HiveField(13)
  bool isMemorizedMax;

  @HiveField(14)
  int memorizedAt;

  @HiveField(15)
  int memorizedCount;

  @HiveField(16)
  int updateMemorizedAtCallCount;

  @HiveField(17)
  bool isFavorite;

  @HiveField(18)
  bool isMeanVisible; // New field for meaning visibility

  Word({
    required this.id,
    required this.secondId,
    required this.level,
    required this.subLevel,
    required this.word,
    required this.meaning,
    required this.part,
    required this.pronunciation,
    required this.etymology,
    required this.idiom,
    required this.collocation,
    required this.synonyms,
    required this.isMemorized,
    required this.isMemorizedMax,
    required this.memorizedAt,
    required this.memorizedCount,
    required this.updateMemorizedAtCallCount,
    required this.isFavorite,
    required this.isMeanVisible,
  });
}
