import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:meu_auto/widgets/flk_appbar.dart';
import 'package:meu_auto/widgets/flk_input_label.dart';
import 'package:meu_auto/widgets/flk_loading_button.dart';

class AlcoolGasolina extends StatelessWidget {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _gasController = new MoneyMaskedTextController();
  final _alcoolController = new MoneyMaskedTextController();
  bool calcularNovamente = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).backgroundColor,
      drawer: FlkDrawer(),
      appBar: FlkAppBar(
        "Álcool ou Gasolina?",
        scaffoldKey: _scaffoldKey,
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          Image.asset(
            "assets/images/aog-white.png",
            height: 80,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Qual será que está compensando hoje?",
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Big Shoulders Display",
              fontSize: 25,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            margin: EdgeInsets.only(bottom: 30, left: 30, right: 30),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Compensa utilizar álcool",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 40,
                    fontFamily: "Big Shoulders Display",
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
          FlkInputLabel(
            "Gasolina",
            controller: _gasController,
          ),
          SizedBox(
            height: 10,
          ),
          FlkInputLabel(
            "Álcool",
            controller: _alcoolController,
          ),
          FlkLoadingButton(
            texto: "CALCULAR",
            funcao: () {},
            carregando: true,
            inverter: true,
          )
        ],
      ),
    );
  }
}
