import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'core/theme/theme.dart';
import 'core/widgets/widgets.dart';
import 'features/catalog/catalog_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const SpayzApp());
}

class SpayzApp extends StatelessWidget {
  const SpayzApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spayz',
      debugShowCheckedModeBanner: false,
      theme: SpayzTheme.dark,
      darkTheme: SpayzTheme.dark,
      themeMode: ThemeMode.dark,
      home: const CatalogScreen(),
    );
  }
}
