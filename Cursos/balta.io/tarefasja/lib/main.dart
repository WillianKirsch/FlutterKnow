import 'package:flutter/material.dart';
import 'package:tarefas_ja/inicio_page.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'color_schemes.g.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tarefas já',
      debugShowCheckedModeBanner:
          false, // Flag para mostrar ou não que está em ambiente de debug
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: darkColorScheme,
      ),
      home: InicioPage(titulo: 'Tarefas Já'),
    );
  }
}
