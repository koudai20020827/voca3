// import 'package:flutter/material.dart';
// import 'package:voca3/resource/colors.dart';
// import 'package:voca3/resource/styles.dart';

// class HomeViewScreen extends StatefulWidget {
//   static String routeName = "/homeView";

//   const HomeViewScreen({super.key});

//   @override
//   _HomeViewScreenState createState() => _HomeViewScreenState();
// }

// class _HomeViewScreenState extends State<HomeViewScreen> {
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
//         title: Text('Home View'),
//       ),
//       body: Stack(
//         children: [
//           // スライドするページ部分
//           PageView(
//             onPageChanged: (int index) {
//               setState(() {
//                 _currentPageIndex = index;
//               });
//             },
//             children: _pageColors
//                 .map((color) => Stack(
//                       children: [
//                         // カラー背景
//                         Container(
//                           color: color,
//                           width: double.infinity,
//                           height: double.infinity,
//                         ),
//                         Column(
//                           children: [
//                             const GapWidget(gap: 50),
//                             // 画像
//                             Stack(
//                               children: [
//                                 // 影
//                                 // Container(
//                                 //   decoration: BoxDecoration(
//                                 //     boxShadow: [
//                                 //       BoxShadow(
//                                 //         color: Colors.black54,
//                                 //         offset: Offset(50.0, 50.0), // 影の方向と距離
//                                 //         blurRadius: 10.0, // 影のぼかし具合
//                                 //         spreadRadius: 2.0, // 影の広がり具合
//                                 //       ),
//                                 //     ],
//                                 //   ),
//                                 // ),
//                                 // 角丸
//                                 Align(
//                                   alignment: Alignment.center,
//                                   child: ClipRRect(
//                                     borderRadius:
//                                         BorderRadius.circular(20.0), // 角丸の半径を指定
//                                     child: SizedBox(
//                                       width: 360.0,
//                                       height: 200.0,
//                                       child: Image.asset(
//                                         'assets/images/0.jpg',
//                                         fit: BoxFit.cover,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 Align(
//                                   alignment: Alignment.center,
//                                   child: Positioned(
//                                     width: 365.0,
//                                     height: 205.0,
//                                     child: DecoratedBox(
//                                       decoration: BoxDecoration(
//                                         gradient: LinearGradient(
//                                           begin: Alignment.topLeft,
//                                           end: Alignment.bottomRight,
//                                           colors: [
//                                             Colors.black
//                                                 .withOpacity(0.5), // 左上: 半透明の黒
//                                             Colors.transparent, // 右下: 透明
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             const GapWidget(gap: 10),
//                             // 単語
//                             Text('ethos', style: AppTextStyle.wordStyleH1),
//                             Text('[-θɔs]',
//                                 style: AppTextStyle.wordStylePronuciation),
//                             Text('精神、気風', style: AppTextStyle.wordStyleJH1),
//                           ],
//                         ),
//                         // 複数のテキスト
//                         Positioned(
//                           top: 20,
//                           left: 20,
//                           child: Text('Page ${_pageColors.indexOf(color) + 1}'),
//                         ),
//                         Positioned(
//                           top: 20,
//                           right: 20,
//                           child: Text('Additional text'),
//                         ),
//                         Positioned(
//                           bottom: 20,
//                           left: 20,
//                           child: Text('Another text'),
//                         ),

//                         // 四隅が丸い四角
//                         Positioned(
//                           bottom: 20,
//                           right: 20,
//                           child: Container(
//                             width: 100,
//                             height: 100,
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(20),
//                             ),
//                             child: Center(
//                               child: Text('Rounded fer'),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ))
//                 .toList(),
//           ),

//           // 共通ボタン
//           Align(
//             alignment: Alignment.bottomRight,
//             child: CommonButton(
//               isMoon: _isMoon,
//               onPressed: () {
//                 setState(() {
//                   _isMoon = !_isMoon;
//                 });
//               },
//             ),
//           ),
//         ],
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
