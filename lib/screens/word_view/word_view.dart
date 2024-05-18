import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:voca3/resource/colors.dart';
import 'package:voca3/resource/styles.dart';
import 'package:voca3/common/shadow_box.dart';
import 'package:voca3/common/green_bar.dart';
import 'package:voca3/common/panel.dart';
import 'package:voca3/screens/word_view/components/word_info.dart';
import 'package:voca3/data/word_model.dart';
import 'package:voca3/data/word_service.dart';
import 'package:voca3/data/word_logic_service.dart';
import 'package:hive/hive.dart';

class WordViewScreen extends StatefulWidget {
  static String routeName = "/wordView";
  final List<Word> words;

  const WordViewScreen({Key? key, required this.words}) : super(key: key);

  @override
  _WordViewScreenState createState() => _WordViewScreenState();
}

class _WordViewScreenState extends State<WordViewScreen> {
  late WordCardLogic _logic;

  @override
  void initState() {
    super.initState();
    _logic = WordCardLogic(Hive.box<Word>('words'));

    // データベースの変更を監視
    Hive.box<Word>('words').watch().listen((BoxEvent event) {
      setState(() {});
    });
  }

  final List<Color> _pageColors = [
    backgroundColor,
    Colors.green,
    Colors.blue
  ]; // ページの色リスト

  int _currentPageIndex = 0;
  bool _isMoon = true;

  void _updateFavorite(int index) {
    _logic.updateFavorite(index);
    setState(() {}); // 更新後にUIを更新
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Word View'),
      ),
      body: Stack(
        children: [
          PageView.builder(
            itemCount: widget.words.length,
            onPageChanged: (index) {
              setState(() {
                _currentPageIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return _buildPageView(index);
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton(
                    onPressed: () {
                      _logic.toggleMemorizedOnly(_currentPageIndex);
                    },
                    child: Icon(Icons.add),
                  ),
                  SizedBox(width: 16.0),
                  FloatingActionButton(
                    onPressed: () {
                      setState(() {
                        _isMoon = !_isMoon;
                      });
                    },
                    child: Icon(_isMoon ? Icons.brightness_2 : Icons.wb_sunny),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageView(int index) {
    return SingleChildScrollView(
      child: Container(
        color: _pageColors[index],
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GapWidget(gap: 20),
            RoundedShadowImage(
              child: Image.asset(
                'assets/images/' + (index + 1).toString() + '.jpg',
              ),
              isFavorite: widget.words[index].isFavorite,
              onFavoriteChanged: (bool isFavorite) {
                _updateFavorite(index); // 新しいメソッドを呼び出す
              },
            ), // RoundedShadowImageを追加
            GapWidget(gap: 20),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
              child: Text(
                widget.words[index].word,
                style: AppTextStyle.wordStyleH1,
              ), // 最初の単語の語彙を表示
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.1, 0.0, 0.1),
              child: Text(
                widget.words[index].pronunciation,
                style: AppTextStyle.wordStylePronuciation,
              ), // 最初の単語の発音を表示
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
              child: Text(
                widget.words[index].meaning,
                style: AppTextStyle.wordStyleJH1,
              ), // 最初の単語の意味を表示
            ),
            GapWidget(gap: 20),
            ColorChangingProgressBar(
              value: widget.words[index].memorizedAt.toDouble(),
            ),
            GapWidget(gap: 20),
            Panel(
                part: "動",
                lv: "Basic\n[2000]",
                frequency: "sometimes",
                tpo: "formal"),
            GapWidget(gap: 20),
            LineWidget(),
            GapWidget(gap: 20),
            RoundedBox0(
              text1: "abandonは…",
            ),
            RoundedBox2(
              text1:
                  "We're going to abandon the picnic plans because of the rain.",
              text2: "やっぱピクニックだめ！雨だしね",
            ),
            GapWidget(gap: 20),
            RoundedBox2BoxShadow(
              text1: 'Collocaton',
              text2:
                  "|■ abandon a plan |(計画を中止する)\n|■ abandon caution |(注意を怠る)",
            ),
            GapWidget(gap: 20),
            RoundedBox2BoxShadow(
              text1: 'idiom',
              text2: "|■ Abandon oneself to (sth) |(没頭する)",
            ), // RoundedShadowBoxを追加
            GapWidget(gap: 20),
            RoundedBox3BoxShadow(
              text1: '語源',
              text2:
                  "abandon は、フランス語の abandonner に由来します。接頭辞の a- は「離れて」という意味で、bandon は「支配、権威、管理」という意味です。",
            ),
            GapWidget(gap: 20),
            FixedColumnDataTable(
              text1: "Synonyms",
              text2:
                  "■ desert|消極的なニュアンス。「助けを求めている人」や「弱い立場の人」を「abandon」するような場合は、「desert」の方が適切です。|■ discard|不要なものとして「捨てる」という意味合いが強い。「ゴミ」や「古い服」を「discard」するような場合は、「abandon」よりも「discard」の方が適切です。",
            ),
            GapWidget(gap: 20),
            LineWidget(),
            GapWidget(gap: 20),
            Text('Page ${index}'),
            GapWidget(gap: 20),
          ],
        ),
      ),
    );
  }
}
