import 'package:flutter/material.dart';

class HtmlToTextSpan {
  static List<TextSpan> convert(String htmlData) {
    final spans = <TextSpan>[];
    final pattern = RegExp(
        r'<(/?)([a-z]+)([^>]*?)>(?:\r?\n|\r)?(.*?)</?(?:\r?\n|\r)?\1>\s*');
    final matches = pattern.allMatches(htmlData);

    for (final match in matches) {
      final tagType = match.group(1);
      final tagName = match.group(2);
      final attributes = match.group(3) ?? '';
      final text = match.group(4);

      if (tagType == '/') {
        continue;
      }

      final style = _getStyleFromAttributes(attributes);
      spans.add(TextSpan(text: text, style: style));
    }

    return spans;
  }

  static TextStyle _getStyleFromAttributes(String attributes) {
    TextStyle style = TextStyle();

    for (final attribute in attributes.split(' ')) {
      final keyValue = attribute.split('=');
      if (keyValue.length == 2) {
        final key = keyValue[0].trim();
        final value =
            keyValue[1].trim().replaceAll('"', '').replaceAll('\'', '');

        switch (key) {
          case 'b':
            style = style.copyWith(fontWeight: FontWeight.bold);
            break;
          case 'i':
            style = style.copyWith(fontStyle: FontStyle.italic);
            break;
          // ここに他のスタイルを追加
        }
      }
    }

    return style;
  }
}

// 日英フォント変更
class BilingualText extends StatelessWidget {
  final String text;
  final TextStyle englishStyle;
  final TextStyle japaneseStyle;

  BilingualText({
    required this.text,
    required this.englishStyle,
    required this.japaneseStyle,
  });

  @override
  Widget build(BuildContext context) {
    // 日本語と英語のセグメントに分割
    List<String> segments = text.split('|');

    List<InlineSpan> textSpans = [];

    for (int i = 0; i < segments.length; i++) {
      String segment = segments[i];
      // セグメント内の空白を削除しつつ、改行を保持
      List<String> lines = segment.split('\n');

      for (int j = 0; j < lines.length; j++) {
        String line = lines[j].trim(); // セグメント内の空白を削除
        textSpans.add(
          TextSpan(
            text: line,
            style: i.isEven ? japaneseStyle : englishStyle,
          ),
        );

        // 改行文字を追加（最後の行以外）
        if (j < lines.length - 1) {
          textSpans.add(
            TextSpan(
              text: '\n',
              style: TextStyle(color: Colors.transparent), // 透明な色を設定して非表示にする
            ),
          );
        }
      }

      // 最後のセグメント以外に `|` を追加
      if (i < segments.length - 1) {
        textSpans.add(
          TextSpan(
            text: '|',
            style: TextStyle(color: Colors.transparent), // 透明な色を設定して非表示にする
          ),
        );
      }
    }

    return RichText(
      text: TextSpan(children: textSpans),
    );
  }
}
