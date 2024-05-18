import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voca3/resource/colors.dart';
import 'package:voca3/resource/styles.dart';
import 'package:voca3/screens/word_detail/components/word_card.dart';

class WordDetailsScreen extends StatelessWidget {
  static String routeName = "/wordDetails";

  const WordDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WordCard(),
        ],
      ),
    );
  }
}
