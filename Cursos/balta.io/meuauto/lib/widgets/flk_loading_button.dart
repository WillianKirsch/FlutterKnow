import 'package:flutter/material.dart';

class FlkLoadingButton extends StatelessWidget {
  FlkLoadingButton(
      {@required this.texto,
      @required this.funcao,
      @required this.inverter,
      @required this.carregando});

  final String texto;
  final Function funcao;
  final bool carregando;
  final bool inverter;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      alignment: Alignment.center,
      margin: EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: !carregando
            ? inverter
                ? Theme.of(context).primaryColor
                : Colors.white.withOpacity(0.8)
            : Colors.white.withOpacity(0.0),
        borderRadius: BorderRadius.circular(60),
      ),
      child: !carregando
          ? TextButton(
              child: Text(
                texto,
                style: TextStyle(
                  color: inverter
                      ? Colors.white.withOpacity(0.8)
                      : Theme.of(context).primaryColor,
                  fontSize: 25,
                  fontFamily: "Big Shoulders Display",
                ),
              ),
              onPressed: funcao,
            )
          : CircularProgressIndicator(
              backgroundColor: Colors.white,
            ),
    );
  }
}
