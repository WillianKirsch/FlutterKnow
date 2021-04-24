import 'dart:async';

import 'package:dev_quiz/core/app_gradients.dart';
import 'package:dev_quiz/core/app_images.dart';
import 'package:dev_quiz/home/home_page.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Timer(
        Duration(seconds: 2),
        () => {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => HomePage()))
            });

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppGradients.linear,
        ),
        child: Center(
          child: Image.asset(
            AppImages.logo,
          ),
        ),
      ),
    );
  }
}
