import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rck_guide/app/theme.dart';
import 'package:rck_guide/backend/backend.dart';
import 'package:rck_guide/home/home_screen.dart';

class RocketGuideApp extends StatelessWidget {
  final Backend backend;

  const RocketGuideApp({
    Key key,
    @required this.backend,
  })  : assert(backend != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      home: Provider.value(
        value: backend,
        child: HomeScreen(),
      ),
    );
  }
}
