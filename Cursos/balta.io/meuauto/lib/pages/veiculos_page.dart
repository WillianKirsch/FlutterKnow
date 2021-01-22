import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meu_auto/models/veiculo.model.dart';
import 'package:meu_auto/widgets/flk_appbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

var veiculos = new List<Veiculo>();

class VeiculosPage extends StatefulWidget {
  VeiculosPage({Key key}) : super(key: key) {
    veiculos = [];
  }

  final String titulo = 'Meus autos';

  @override
  _VeiculosPageState createState() => _VeiculosPageState();
}

class _VeiculosPageState extends State<VeiculosPage> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _carregarVeiculos();
  }

  @override
  Widget build(BuildContext inicioContext) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).backgroundColor,
      drawer: FlkDrawer(),
      appBar: FlkAppBar(
        widget.titulo,
        scaffoldKey: _scaffoldKey,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.filter_list),
            tooltip: 'Ordenar por Placa',
            onPressed: () {
              setState(() {
                veiculos.sort((veiculoA, veiculoB) =>
                    veiculoA.placa.compareTo(veiculoB.placa));
              });
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Visibility(
            visible: veiculos.isEmpty,
            child: Center(
              child: Container(
                child: Text("Insira as seus veículos aqui. :D"),
              ),
            ),
          ),
          ListView.builder(
            itemCount: veiculos.length,
            itemBuilder: (BuildContext itemContext, int index) {
              final veiculo = veiculos[index];
              return Dismissible(
                key: Key(index.toString()),
                background: _slideRightBackground(),
                secondaryBackground: _slideLeftBackground(),
                confirmDismiss: (DismissDirection direction) async {
                  if (direction == DismissDirection.endToStart) {
                    final bool res = await showDialog(
                        context: itemContext,
                        builder: (BuildContext builderContext) {
                          return AlertDialog(
                            content: Text(
                                "Tem certeza de que deseja remover \"${veiculos[index].placa}\"?"),
                            actions: <Widget>[
                              FlatButton(
                                child: Text(
                                  "Cancelar",
                                  style: TextStyle(color: Colors.black),
                                ),
                                onPressed: () {
                                  Navigator.pop(builderContext);
                                },
                              ),
                              FlatButton(
                                child: Text(
                                  "Remover",
                                  style: TextStyle(color: Colors.red),
                                ),
                                onPressed: () {
                                  Navigator.pop(builderContext);
                                  setState(() {
                                    _removerVeiculo(itemContext, index);
                                  });
                                },
                              ),
                            ],
                          );
                        });
                    return res;
                  } else {
                    _detalhesVeiculo(veiculos[index]);
                    return false;
                  }
                },
                child: Card(
                  elevation: 6,
                  child: CheckboxListTile(
                    title: Text(veiculo.placa ?? ""),
                    subtitle: Text(veiculo.anotacao ?? ""),
                    value: veiculo.feito,
                    onChanged: (valor) {
                      setState(() {
                        veiculo.feito = valor;
                        _salvarVeiculos();
                      });
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _detalhesVeiculo(null),
        tooltip: 'Adicionar veículo',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _slideRightBackground() {
    return Container(
      color: Colors.green,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 20,
            ),
            Icon(
              Icons.edit,
              color: Colors.white,
            ),
            Text(
              "Editar",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
        alignment: Alignment.centerLeft,
      ),
    );
  }

  Widget _slideLeftBackground() {
    return Container(
      color: Colors.red,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(
              Icons.delete,
              color: Colors.white,
            ),
            Text(
              "Deletar",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        alignment: Alignment.centerRight,
      ),
    );
  }

  Future _carregarVeiculos() async {
    var _sharedPreferences = await SharedPreferences.getInstance();
    var _veiculosString = _sharedPreferences.getString('veiculos');

    if (_veiculosString != null) {
      Iterable decoded = jsonDecode(_veiculosString);
      List<Veiculo> _veiculos =
          decoded.map((veiculo) => Veiculo.fromJson(veiculo)).toList();

      setState(() {
        veiculos = _veiculos;
      });
    }
  }

  Future _salvarVeiculos() async {
    var _sharedPreferences = await SharedPreferences.getInstance();
    await _sharedPreferences.setString('veiculos', jsonEncode(veiculos));
  }

  Future<void> _detalhesVeiculo(Veiculo _veiculo) async {
    final _formKey = GlobalKey<FormState>();

    int _quantidadeMaxCaracteresPlaca = 100;
    int _quantidadeMaxCaracteresAnotacao = 500;

    var _placaController = TextEditingController();
    var _anotacaoController = TextEditingController();

    bool _adicionando = false;
    if (_veiculo == null) {
      _adicionando = true;
      _veiculo = new Veiculo();
    } else {
      _placaController.text = _veiculo.placa;
      _anotacaoController.text = _veiculo.anotacao;
      _veiculo.feito = _veiculo.feito;
    }

    await showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return SimpleDialog(
            title: Text(_adicionando ? 'Nova tarefa' : 'Editando tarefa'),
            contentPadding: EdgeInsets.only(left: 24, right: 24, top: 12),
            children: <Widget>[
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _placaController,
                      autocorrect: true,
                      autofocus: true,
                      enableSuggestions: true,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Placa",
                        helperText:
                            "Até $_quantidadeMaxCaracteresPlaca caracteres",
                        border: OutlineInputBorder(),
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'A placa é obrigatória';
                        }
                        return null;
                      },
                      maxLength: _quantidadeMaxCaracteresPlaca,
                    ),
                    TextFormField(
                      controller: _anotacaoController,
                      autocorrect: true,
                      autofocus: true,
                      enableSuggestions: true,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        labelText: "Anotação",
                        helperText: "Descreva um pouco mais sobre a tarefa.",
                        border: OutlineInputBorder(),
                      ),
                      maxLength: _quantidadeMaxCaracteresAnotacao,
                    ),
                  ],
                ),
              ),
              ButtonBar(
                children: [
                  RaisedButton(
                    onPressed: () {
                      if (!_formKey.currentState.validate()) {
                        return;
                      }
                      _veiculo.placa = _placaController.text;
                      _veiculo.anotacao = _anotacaoController.text;
                      _salvarVeiculos();
                      setState(() {
                        if (_adicionando) {
                          veiculos.add(_veiculo);
                        }
                      });
                      Navigator.pop(dialogContext);
                    },
                    child: Text("Salvar"),
                  )
                ],
              )
            ],
          );
        });
  }

  _removerVeiculo(_context, int index) {
    setState(() {
      veiculos.removeAt(index);
    });
    _salvarVeiculos();
    Scaffold.of(_context).showSnackBar(SnackBar(
      content: Text("Tarefa removida!"),
      backgroundColor: Colors.green,
    ));
  }
}
