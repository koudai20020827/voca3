import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:voca3/resource/styles.dart';

class Panel extends StatelessWidget {
  final String part;
  final String lv;
  final String frequency;
  final String tpo;

  Panel({
    required this.part,
    required this.lv,
    required this.frequency,
    required this.tpo,
  });

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width * 3 / 4;
    IconData iconDataFreq;
    IconData iconDataTpo;
    switch (frequency.toLowerCase()) {
      case 'rarely':
        iconDataFreq = FontAwesomeIcons.dragon; // Replace with the desired icon
        break;
      case 'sometimes':
        iconDataFreq =
            FontAwesomeIcons.stickerMule; // Replace with the desired icon
        break;
      case 'often':
        iconDataFreq =
            FontAwesomeIcons.kiwiBird; // Replace with the desired icon
        break;
      case 'always':
        iconDataFreq = FontAwesomeIcons.fish; // Replace with the desired icon
        break;
      default:
        iconDataFreq = FontAwesomeIcons.poo; // Replace with the default icon
    }
    switch (tpo.toLowerCase()) {
      case '~formal':
      case 'formal':
      case 'formal~':
        iconDataTpo =
            FontAwesomeIcons.userSecret; // Replace with the desired icon
        break;
      case '~business':
      case 'business':
      case 'business~':
        iconDataTpo =
            FontAwesomeIcons.suitcase; // Replace with the desired icon
        break;
      case '~casual':
      case 'casual':
      case 'casual~':
        iconDataTpo = FontAwesomeIcons.tshirt; // Replace with the desired icon
      case '~slung':
      case 'slung':
      case 'slung~':
        iconDataTpo =
            FontAwesomeIcons.theaterMasks; // Replace with the desired icon
        break;
      default:
        iconDataTpo = FontAwesomeIcons.poo; // Replace with the default icon
    }
    return SizedBox(
      height: 80, // Fixed height
      child: EightPanel(
        first: Container(
          child: Center(
              child: Text(
            '品詞',
            style: AppTextStyle.partStyle1,
          )),
        ),
        second: Container(
          child: Center(
            child: Text(
              part,
              style: AppTextStyle.partStyle2,
            ),
          ),
        ),
        third: Container(
          child: Center(
              child: Text(
            'LV',
            style: AppTextStyle.partStyle1,
          )),
        ),
        fourth: Container(
          child: Center(child: Text(lv)),
        ),
        fifth: Container(
          child: Center(child: Icon(iconDataFreq, size: 30)),
        ),
        sixth: Container(
          child: Center(child: Text('Rare', style: AppTextStyle.infoStyle1)),
        ),
        seventh: Container(
          child: Center(child: Icon(iconDataTpo, size: 30)),
        ),
        eighth: Container(
          child: Center(child: Text('~Formal', style: AppTextStyle.infoStyle1)),
        ),
      ),
    );
  }
}

class EightPanel extends StatelessWidget {
  final Widget first;
  final Widget second;
  final Widget third;
  final Widget fourth;
  final Widget fifth;
  final Widget sixth;
  final Widget seventh;
  final Widget eighth;

  EightPanel({
    required this.first,
    required this.second,
    required this.third,
    required this.fourth,
    required this.fifth,
    required this.sixth,
    required this.seventh,
    required this.eighth,
  });

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width * 3 / 4;
    return Row(
      children: [
        _buildExpandedColumn1(first, second, maxWidth),
        Divider(),
        _buildExpandedColumn1(third, fourth, maxWidth),
        Divider(),
        _buildExpandedColumn2(fifth, sixth, maxWidth),
        Divider(),
        _buildExpandedColumn2(seventh, eighth, maxWidth),
      ],
    );
  }

  Widget _buildExpandedColumn1(Widget top, Widget bottom, double maxWidth) {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              constraints: BoxConstraints(maxWidth: maxWidth),
              child: top,
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              constraints: BoxConstraints(maxWidth: maxWidth),
              child: bottom,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpandedColumn2(Widget top, Widget bottom, double maxWidth) {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              constraints: BoxConstraints(maxWidth: maxWidth),
              child: top,
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              constraints: BoxConstraints(maxWidth: maxWidth),
              child: bottom,
            ),
          ),
        ],
      ),
    );
  }
}

// 間隔
class GapWidget extends StatelessWidget {
  final double gap;

  const GapWidget({Key? key, required this.gap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: gap);
  }
}

class LineWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 4.0, // 線の高さ
      padding: EdgeInsets.symmetric(horizontal: 16.0), // 左右のパディングを追加
      child: Stack(
        children: [
          Container(
            height: 4.0, // 線の高さ
            color: Colors.grey[300], // 線の背景色
          ),
        ], // 線を追加
      ),
    );
  }
}
