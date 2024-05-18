import 'package:flutter/widgets.dart';
import 'package:voca3/screens/word_view/word_view.dart';

import 'screens/word_detail/word_details.dart';
import 'screens/word_view/word_view.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  WordDetailsScreen.routeName: (context) => const WordDetailsScreen(),
  // WordViewScreen.routeName: (context) => WordViewScreen(words: words),
};
