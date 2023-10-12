import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:cinemafan/config/di/get_it.dart';
import 'package:cinemafan/config/router/app_router.dart';
import 'package:cinemafan/presentation/providers/providers.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future<void> main() async {
  Intl.defaultLocale = 'es_US';

  // Load .env file
  await dotenv.load(fileName: ".env");

  // Dependency Injection registers
  registerDependencies();

  // Cuando la aplicacion corre por primera vez, inicializa el darkmode de acuerdo a la configuracion del sistema
  final prefs = await SharedPreferences.getInstance();
  if (!prefs.containsKey('darkMode')) {
    prefs.setBool('darkMode', PlatformDispatcher.instance.platformBrightness == Brightness.dark);
  }

  runApp(ProviderScope(child: MainApp()));
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
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: ThemeData.dark().colorScheme.copyWith(
          primary: Colors.purpleAccent,
          secondary: Colors.deepPurpleAccent,
        ),
      ),
      themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,
      routerConfig: appRouter,
    );
  }
}
