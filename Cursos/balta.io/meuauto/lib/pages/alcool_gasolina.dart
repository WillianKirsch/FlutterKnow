import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:meu_auto/widgets/flk_appbar.dart';
import 'package:meu_auto/widgets/flk_input_label.dart';

class AlcoolGasolina extends StatelessWidget {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _gasController = new MoneyMaskedTextController();
  final _alcoolController = new MoneyMaskedTextController();

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
            height: 60,
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
            height: 20,
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
          Container(
            height: 60,
            margin: EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(60),
            ),
            child: FlatButton(
              child: Text(
                "CALCULAR",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 25,
                  fontFamily: "Big Shoulders Display",
                ),
              ),
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }
}
