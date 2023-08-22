import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final Widget childView;

  const HomeScreen({
    super.key,
    required this.childView,
  });

  @override
  Widget build(BuildContext context) => Scaffold(body: childView);
}
