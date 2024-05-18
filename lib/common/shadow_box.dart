import 'package:flutter/material.dart';
import 'dart:math';
import 'package:voca3/common/parse.dart';
import 'package:voca3/resource/styles.dart';
import 'dart:io' show Platform;

class RoundedShadowBox extends StatelessWidget {
  final String text;

  RoundedShadowBox({required this.text});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 3 / 4;
    double height = width * 10 / 24;

    return Container(
      width: width,
      height: height,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 221, 222, 223).withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 10,
              offset: Offset(0, 3),
            ),
          ],
          color: Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            text,
            style: TextStyle(fontSize: 20.0),
          ),
        ),
      ),
    );
  }
}

class RoundedShadowImage extends StatefulWidget {
  final Widget child;
  final bool isFavorite;
  final Function(bool) onFavoriteChanged;

  RoundedShadowImage({
    required this.child,
    required this.isFavorite,
    required this.onFavoriteChanged,
  });

  @override
  _RoundedShadowImageState createState() => _RoundedShadowImageState();
}

class _RoundedShadowImageState extends State<RoundedShadowImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300), // アニメーションの時間
    );

    _colorAnimation = ColorTween(
      begin: widget.isFavorite
          ? const Color.fromARGB(255, 248, 47, 114)
          : Colors.pink,
      end: widget.isFavorite
          ? const Color.fromARGB(255, 248, 47, 114)
          : Colors.pink,
    ).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant RoundedShadowImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isFavorite != widget.isFavorite) {
      _animateColorChange();
    }
  }

  void _animateColorChange() {
    _animationController.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 3 / 4;
    double height = width * 15 / 24;

    return Stack(
      children: [
        Container(
          width: width,
          height: height,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 221, 222, 223).withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: Offset(0, 3),
                ),
              ],
              color: Colors.white,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FittedBox(
                fit: BoxFit.cover,
                child: widget.child,
              ),
            ),
          ),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: GestureDetector(
            onTap: () {
              widget.onFavoriteChanged(!widget.isFavorite);
            },
            child: AnimatedBuilder(
              animation: _colorAnimation,
              builder: (context, child) {
                return Icon(
                  widget.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: _colorAnimation.value,
                  size: 34,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
// 使い方
// body: Center(
//   child: Column(
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: [
//       RoundedShadowBox(
//         child: Image.asset('assets/image.jpg'), // 画像のパスを指定
//       ),
//       SizedBox(height: 20),
//       RoundedShadowBox(
//         child: Image.network('https://example.com/image.jpg'), // 画像のURLを指定
//       ),
//     ],
//   ),
// ),

class RoundedBox extends StatelessWidget {
  final String text;

  RoundedBox({required this.text});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 3 / 4;
    double height = width * 10 / 24;

    return Container(
      width: width,
      height: height,
      child: Container(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            text,
            style: TextStyle(fontSize: 20.0),
          ),
        ),
      ),
    );
  }
}

class RoundedBox0 extends StatelessWidget {
  final String text1;

  RoundedBox0({
    required this.text1,
  });

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width * 3 / 4;

    // テキストのペインターを作成して高さを取得
    TextPainter painter1 = TextPainter(
      text: TextSpan(text: text1, style: AppTextStyle.textStyle1),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: maxWidth - 40.0); // パディングを引く

    double totalHeight = painter1.height + 40.0; // 20.0のPaddingを追加
    double height = min(totalHeight, maxWidth * 10 / 24); // 最大の高さを設定

    return Container(
      width: maxWidth,
      child: IntrinsicHeight(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.transparent,
          ),
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text1,
                  style: AppTextStyle.textStyle5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RoundedBox2 extends StatelessWidget {
  final String text1;
  final String text2;

  RoundedBox2({required this.text1, required this.text2});

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width * 3 / 4;

    // テキストのペインターを作成して高さを取得
    TextPainter painter1 = TextPainter(
      text: TextSpan(text: text1, style: AppTextStyle.textStyle1),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: maxWidth - 40.0); // パディングを引く

    TextPainter painter2 = TextPainter(
      text: TextSpan(text: text2, style: AppTextStyle.textStyle2),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: maxWidth - 40.0); // パディングを引く

    double totalHeight =
        painter1.height + painter2.height + 40.0; // 20.0のPaddingを追加
    double height = min(totalHeight, maxWidth * 10 / 24); // 最大の高さを設定

    return Container(
      width: maxWidth,
      child: IntrinsicHeight(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.grey[200],
          ),
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text1,
                  style: AppTextStyle.textStyle1,
                ),
                SizedBox(height: 10.0),
                Text(
                  text2,
                  style: AppTextStyle.textStyle2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// 音声付きV!
// class RoundedBox2 extends StatefulWidget {
//   final String text1;
//   final String text2;

//   RoundedBox2({required this.text1, required this.text2});

//   @override
//   _RoundedBox2State createState() => _RoundedBox2State();
// }

// class _RoundedBox2State extends State<RoundedBox2> {
//   late AudioPlayer audioPlayer;

//   @override
//   void initState() {
//     super.initState();
//     audioPlayer = AudioPlayer();
//     AudioContext.instance = WebAudioContext();
//   }

//   void playAudio() async {
//     await audioPlayer.setAsset("assets/mp3/1_1.mp3");
//     audioPlayer.play();
//   }

//   @override
//   Widget build(BuildContext context) {
//     double maxWidth = MediaQuery.of(context).size.width * 3 / 4;

//     return Container(
//       width: maxWidth,
//       child: GestureDetector(
//         onTap: () {
//           playAudio();
//         },
//         child: Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10.0),
//             color: Colors.grey[200],
//           ),
//           child: Padding(
//             padding: EdgeInsets.all(20.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   widget.text1,
//                   style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(height: 10.0),
//                 Text(
//                   widget.text2,
//                   style: TextStyle(fontSize: 14.0),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// collocation
class RoundedBox2BoxShadow extends StatelessWidget {
  final String text1;
  final String text2;

  RoundedBox2BoxShadow({required this.text1, required this.text2});

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width * 3 / 4;

    // Calculate total height
    TextPainter painter1 = TextPainter(
      text: TextSpan(text: text1, style: AppTextStyle.textStyle1),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: maxWidth - 40.0); // Subtract padding

    TextPainter painter2 = TextPainter(
      text: TextSpan(text: text2, style: AppTextStyle.textStyle3),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: maxWidth - 40.0); // Subtract padding

    double totalHeight =
        painter1.height + painter2.height + 40.0; // Add padding
    double height = min(totalHeight, maxWidth * 10 / 24); // Set max height

    return Container(
      width: maxWidth,
      child: IntrinsicHeight(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 221, 222, 223).withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 10,
                offset: Offset(0, 3),
              ),
            ],
            color: Colors.white,
          ),
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text1,
                  style: AppTextStyle.textStyle1,
                ),
                SizedBox(height: 10.0),
                BilingualText(
                  text: text2,
                  englishStyle: AppTextStyle.textStyle1,
                  japaneseStyle: AppTextStyle.textStyle3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// 語源:
class RoundedBox3BoxShadow extends StatelessWidget {
  final String text1;
  final String text2;

  RoundedBox3BoxShadow({required this.text1, required this.text2});

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width * 3 / 4;

    // Calculate total height
    TextPainter painter1 = TextPainter(
      text: TextSpan(text: text1, style: AppTextStyle.textStyle1),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: maxWidth - 40.0); // Subtract padding

    TextPainter painter2 = TextPainter(
      text: TextSpan(text: text2, style: AppTextStyle.textStyle3),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: maxWidth - 40.0); // Subtract padding

    double totalHeight =
        painter1.height + painter2.height + 40.0; // Add padding
    double height = min(totalHeight, maxWidth * 10 / 24); // Set max height

    return Container(
      width: maxWidth,
      child: IntrinsicHeight(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 221, 222, 223).withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 10,
                offset: Offset(0, 3),
              ),
            ],
            color: Colors.white,
          ),
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text1,
                  style: AppTextStyle.textStyle1JP,
                ),
                SizedBox(height: 10.0),
                Text(
                  text2,
                  style: AppTextStyle.textStyle4,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// synonyms
class FixedColumnDataTable extends StatelessWidget {
  final String text1;
  final String text2;

  FixedColumnDataTable({required this.text1, required this.text2});

  @override
  Widget build(BuildContext context) {
    final List<String> data = text2.split("|");
    final int rowCount = (data.length / 2).ceil();
    final double availableWidth = MediaQuery.of(context).size.width;
    final double maxWidth =
        MediaQuery.of(context).size.width * 3 / 4; // maxWidthを画面幅の3/4に固定
    final double cellWidth1 = (maxWidth - 40) * 0.3; // 3:7の比率で左側のセルの幅を計算する
    final double cellWidth2 = (maxWidth - 40) * 0.7; // 3:7の比率で右側のセルの幅を計算する

    // Calculate total height
    TextPainter painter1 = TextPainter(
      text: TextSpan(text: text1, style: AppTextStyle.textStyle1),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: maxWidth - 40.0); // Subtract padding

    double totalHeight = painter1.height + 40.0; // Add padding

    // Calculate total height for data in text2
    double dataHeight = 0;
    for (int i = 0; i < rowCount; i++) {
      final start = i * 2;
      final end = min(start + 2, data.length);
      TextPainter dataPainter = TextPainter(
        text: TextSpan(
            text: data.sublist(start, end).join('\n'),
            style: AppTextStyle.textStyle3),
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: maxWidth - 40.0); // Subtract padding
      dataHeight += dataPainter.height;
    }

    totalHeight += dataHeight;

    // Set max height
    double height = totalHeight + 130;

    return Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 221, 222, 223).withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
        color: Colors.white,
      ),
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text(text1, style: AppTextStyle.textStyle1),
          ),
          SizedBox(
            height: 10,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(rowCount, (index) {
                final start = index * 2;
                final end = min(start + 1, data.length);
                return Row(
                  children: [
                    Container(
                      width: cellWidth1,
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      child: Text(data[start], style: AppTextStyle.textStyle5),
                    ),
                    if (end < data.length) // もう一方の列が欠ける場合には空のコンテナを挿入する
                      Container(
                        width: cellWidth2,
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        child: Text(data[end], style: AppTextStyle.textStyle4),
                      ),
                  ],
                );
              }).expand((widget) => [widget, SizedBox(width: 1)]).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
