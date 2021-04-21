import 'package:flutter/material.dart';
import 'package:rck_guide/backend/backend.dart';
import 'app/app.dart';

void main() {
  final backend = Backend('https://api.spacexdata.com/v4');

  runApp(
    RocketGuideApp(
      backend: backend,
    ),
  );
}
