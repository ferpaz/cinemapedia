import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = 'home-screen';

  final Widget childView;

  const HomeScreen({
    super.key,
    required this.childView,
  });

  @override
  Widget build(BuildContext context) => Scaffold(body: childView);
}
