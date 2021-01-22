import 'package:flutter/material.dart';
import 'package:meu_auto/pages/veiculos_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meus autos',
      debugShowCheckedModeBanner:
          false, // Flag para mostrar ou não que está em ambiente de debug
      theme: ThemeData(
          primarySwatch: Colors.deepOrange,
          backgroundColor: Colors.deepOrange[200],
          accentColor: Colors.orangeAccent,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          iconTheme: IconThemeData(
            color: Colors.grey,
          )),
      home: VeiculosPage(),
    );
  }
}
