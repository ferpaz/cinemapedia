import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:cinemafan/config/di/get_it.dart';
import 'package:cinemafan/config/router/app_router.dart';
import 'package:cinemafan/presentation/providers/providers.dart';


Future<void> main() async {
  Intl.defaultLocale = 'es_US';

  // Load .env file
  await dotenv.load(fileName: ".env");

  // Dependency Injection registers
  registerDependencies();

  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final darkMode = ref.watch(darkModeProvider);

    //final isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Cinema Fan',
      theme: ThemeData(
        useMaterial3: true,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData.dark(),
      themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,
      routerConfig: appRouter,
    );
  }
}
