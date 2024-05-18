// import 'package:flutter/material.dart';
// import 'package:voca3/resource/colors.dart';
// import 'package:voca3/resource/styles.dart';
// import 'package:voca3/common/shadow_box.dart';

// class WordInfo extends StatefulWidget {
//   const WordInfo({Key? key}) : super(key: key);

//   @override
//   _WordInfoState createState() => _WordInfoState();
// }

// class _WordInfoState extends State<WordInfo> {
//   final List<Color> _pageColors = [
//     backgroundColor,
//     Colors.green,
//     Colors.blue
//   ]; // ページの色リスト

//   int _currentPageIndex = 0;
//   bool _isMoon = true;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Word View'),
//       ),
//       body: PageView.builder(
//         itemCount: _pageColors.length,
//         onPageChanged: (int index) {
//           setState(() {
//             _currentPageIndex = index;
//           });
//         },
//         itemBuilder: (BuildContext context, int index) {
//           return SingleChildScrollView(
//             child: Container(
//               color: _pageColors[index],
//               padding: EdgeInsets.all(20),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(height: 20),
//                   Text('Page ${index + 1}'),
//                   SizedBox(height: 20),
//                   Text('Additional text'),
//                   SizedBox(height: 20),
//                   Text('Another text'),
//                   SizedBox(height: 20),
//                   Align(
//                     alignment: Alignment.bottomRight,
//                     child: Container(
//                       width: 100,
//                       height: 100,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       child: Center(
//                         child: Text('Rounded fer'),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           setState(() {
//             _isMoon = !_isMoon;
//           });
//         },
//         child: Icon(_isMoon ? Icons.brightness_2 : Icons.wb_sunny),
//       ),
//     );
//   }
// }

// // ボタン
// class CommonButton extends StatelessWidget {
//   final bool isMoon;
//   final VoidCallback onPressed;

//   const CommonButton({Key? key, required this.isMoon, required this.onPressed})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(10.0), // ボタン全体に30のpaddingを設定
//       child: ElevatedButton(
//         onPressed: onPressed,
//         child: Icon(
//           isMoon ? Icons.brightness_2 : Icons.wb_sunny,
//         ),
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.blue, // Set the button color
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(30)), // Set the button shape
//         ),
//       ),
//     );
//   }
// }

// // 間隔
// class GapWidget extends StatelessWidget {
//   final double gap;

//   const GapWidget({Key? key, required this.gap}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(height: gap);
//   }
// }
