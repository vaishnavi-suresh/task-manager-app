import 'package:flutter/material.dart';
import 'package:learn_flutter/features/screens/onboarding_screen.dart';
import 'package:learn_flutter/widget_tree.dart';

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: WidgetTree()
    );
  }
}
