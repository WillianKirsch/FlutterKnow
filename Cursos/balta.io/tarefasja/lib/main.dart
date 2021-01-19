import 'package:flutter/material.dart';
import 'package:tarefas_ja/inicio_page.dart';

void main() {
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
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: InicioPage(titulo: 'Tarefas Já'),
    );
  }
}
