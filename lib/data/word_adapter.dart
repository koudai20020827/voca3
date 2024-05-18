import 'package:hive/hive.dart';

import 'word_model.dart';

class WordAdapter extends TypeAdapter<Word> {
  @override
  final int typeId = 0;

  @override
  Word read(BinaryReader reader) {
    return Word(
      id: reader.readInt(),
      secondId: reader.readString(),
      level: reader.readInt(),
      subLevel: reader.readInt(),
      word: reader.readString(),
      meaning: reader.readString(),
      part: reader.readString(),
      pronunciation: reader.readString(),
      etymology: reader.readString(),
      idiom: reader.readString(),
      collocation: reader.readString(),
      synonyms: reader.readString(),
      isMemorized: reader.readBool(),
      isMemorizedMax: reader.readBool(),
      memorizedAt: reader.readInt(),
      memorizedCount: reader.readInt(),
      updateMemorizedAtCallCount: reader.readInt(),
      isFavorite: reader.readBool(),
      isMeanVisible: reader.readBool(),
    );
  }

  @override
  void write(BinaryWriter writer, Word obj) {
    writer
      ..writeInt(obj.id)
      ..writeString(obj.secondId)
      ..writeInt(obj.level)
      ..writeInt(obj.subLevel)
      ..writeString(obj.word)
      ..writeString(obj.meaning)
      ..writeString(obj.part)
      ..writeString(obj.pronunciation)
      ..writeString(obj.etymology)
      ..writeString(obj.idiom)
      ..writeString(obj.collocation)
      ..writeString(obj.synonyms)
      ..writeBool(obj.isMemorized)
      ..writeBool(obj.isMemorizedMax)
      ..writeInt(obj.memorizedAt)
      ..writeInt(obj.memorizedCount)
      ..writeInt(obj.updateMemorizedAtCallCount)
      ..writeBool(obj.isFavorite)
      ..writeBool(obj.isMeanVisible);
  }
}
