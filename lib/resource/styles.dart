// text_styles.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voca3/resource/colors.dart';

// デフォルトのパディング
const defaultPadding = 16.0;

class AppTextStyle {
  // 数字のスタイル
  static final TextStyle numStyle = GoogleFonts.copse(
    color: Colors.white,
    fontSize: 13,
    fontWeight: FontWeight.bold,
  );

  // 単語のスタイル
  static final TextStyle wordStyle = GoogleFonts.manrope(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

// リストページ
  static final TextStyle listColumnStyle = GoogleFonts.urbanist(
    color: whiteTextColor,
    fontSize: 18,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.italic,
  );
  static final TextStyle listStyle = GoogleFonts.urbanist(
    color: whiteTextColor,
    fontSize: 18,
  );
  static final TextStyle numListStyle = GoogleFonts.urbanist(
    fontSize: 14,
    color: whiteTextColor,
    fontWeight: FontWeight.bold,
  );

// 詳細ページ
  // 単語見出し１
  static final TextStyle wordStyleH1 = GoogleFonts.urbanist(
    fontSize: 44,
  );

  // 例文見出し１
  static final TextStyle wordStyleH2 = GoogleFonts.notoSans(
    fontSize: 20,
  );

  // 発音記号
  static final TextStyle wordStylePronuciation = GoogleFonts.notoSans(
    fontSize: 18,
    // fontWeight: FontWeight.bold,
  );

  // 日本語見出し１
  static final TextStyle wordStyleJH1 = GoogleFonts.notoSans(
    fontSize: 23,
  );

  // 基本情報関連
  static final TextStyle partStyle1 = GoogleFonts.notoSans(
    fontSize: 14,
  ).copyWith(
    color: Colors.grey, // 任意の色を設定してください
  );
  static final TextStyle partStyle2 = GoogleFonts.notoSans(
    fontSize: 30,
  );
  static final TextStyle infoStyle1 = GoogleFonts.urbanist(
    fontSize: 16,
  );

  // 英語スタイル
  static final TextStyle textStyle1 = TextStyle(fontSize: 20.0);
  static final TextStyle textStyle1JP = GoogleFonts.notoSans(fontSize: 20.0);
  static final TextStyle textStyle2 =
      TextStyle(fontSize: 18.0, fontStyle: FontStyle.italic);
  static final TextStyle textStyle3 = TextStyle(fontSize: 16.0);
  static final TextStyle textStyle4 = TextStyle(fontSize: 14.0);
  static final TextStyle textStyle5 = TextStyle(fontSize: 17.0);
}
