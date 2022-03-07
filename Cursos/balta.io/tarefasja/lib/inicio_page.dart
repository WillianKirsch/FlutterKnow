import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tarefas_ja/models/tarefa.dart';

var tarefas = [];
enum Availability { loading, available, unavailable }

class InicioPage extends StatefulWidget {
  InicioPage({Key? key, required this.titulo}) : super(key: key) {
    tarefas = [];
  }

  final String titulo;

  @override
  _InicioPageState createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
  final InAppReview _inAppReview = InAppReview.instance;
  Availability _availability = Availability.loading;

  Future<void> _requestReview() => _inAppReview.requestReview();

  Future<void> _openStoreListing() => _inAppReview.openStoreListing(
        appStoreId: '',
        microsoftStoreId: '',
      );

  @override
  void initState() {
    super.initState();
    _carregarTarefas();

    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      try {
        final isAvailable = await _inAppReview.isAvailable();

        setState(() {
          // This plugin cannot be tested on Android by installing your app
          // locally. See https://github.com/britannio/in_app_review#testing for
          // more information.
          _availability = isAvailable && !Platform.isAndroid
              ? Availability.available
              : Availability.unavailable;
        });
      } catch (_) {
        setState(() => _availability = Availability.unavailable);
      }
    });
  }

  @override
  Widget build(BuildContext inicioContext) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.titulo),
        //leading: Icon(Icons.menu),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.store),
            tooltip: 'Abrir loja',
            onPressed: _openStoreListing,
          ),
          IconButton(
            icon: Icon(Icons.star),
            tooltip: 'Avaliar',
            onPressed: _requestReview,
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            tooltip: 'Ordenar por Descrição',
            onPressed: () {
              setState(() {
                tarefas.sort((tarefaA, tarefaB) =>
                    tarefaA.descricao.compareTo(tarefaB.descricao));
              });
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Visibility(
            visible: tarefas.isEmpty,
            child: Center(
              child: Container(
                child: Text("Insira as suas tarefas aqui. :D"),
              ),
            ),
          ),
          ListView.builder(
            itemCount: tarefas.length,
            itemBuilder: (BuildContext itemContext, int index) {
              final tarefa = tarefas[index];
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
                                "Tem certeza de que deseja remover \"${tarefas[index].descricao}\"?"),
                            actions: <Widget>[
                              TextButton(
                                child: Text(
                                  "Cancelar",
                                  style: TextStyle(color: Colors.black),
                                ),
                                onPressed: () {
                                  Navigator.pop(builderContext);
                                },
                              ),
                              TextButton(
                                child: Text(
                                  "Remover",
                                  style: TextStyle(color: Colors.red),
                                ),
                                onPressed: () {
                                  Navigator.pop(builderContext);
                                  setState(() {
                                    _removerTarefa(itemContext, index);
                                  });
                                },
                              ),
                            ],
                          );
                        });
                    return res;
                  } else {
                    _detalhesTarefa(tarefas[index]);
                    return false;
                  }
                },
                child: Card(
                  elevation: 6,
                  child: CheckboxListTile(
                    title: Text(tarefa.descricao ?? ""),
                    subtitle: Text(tarefa.anotacao ?? ""),
                    value: tarefa.feito,
                    onChanged: (valor) {
                      setState(() {
                        tarefa.feito = valor;
                        _salvarTarefas();
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
        onPressed: () => _detalhesTarefa(null),
        tooltip: 'Adicionar tarefa',
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

  Future _carregarTarefas() async {
    var _sharedPreferences = await SharedPreferences.getInstance();
    var _tarefasString = _sharedPreferences.getString('tarefas');

    if (_tarefasString != null) {
      Iterable decoded = jsonDecode(_tarefasString);
      List<Tarefa> _tarefas =
          decoded.map((tarefa) => Tarefa.fromJson(tarefa)).toList();

      setState(() {
        tarefas = _tarefas;
      });
    }
  }

  Future _salvarTarefas() async {
    var _sharedPreferences = await SharedPreferences.getInstance();
    await _sharedPreferences.setString('tarefas', jsonEncode(tarefas));
  }

  Future<void> _detalhesTarefa(Tarefa? _tarefa) async {
    final _formKey = GlobalKey<FormState>();

    int _quantidadeMaxCaracteresDescricao = 100;
    int _quantidadeMaxCaracteresAnotacao = 500;

    var _descricaoController = TextEditingController();
    var _anotacaoController = TextEditingController();

    bool _adicionando = false;
    if (_tarefa == null) {
      _adicionando = true;
      _tarefa = new Tarefa();
    } else {
      _descricaoController.text = _tarefa.descricao ?? '';
      _anotacaoController.text = _tarefa.anotacao ?? '';
      _tarefa.feito = _tarefa.feito;
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
                      controller: _descricaoController,
                      autocorrect: true,
                      autofocus: true,
                      enableSuggestions: true,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Descrição",
                        helperText:
                            "Até $_quantidadeMaxCaracteresDescricao caracteres",
                        border: OutlineInputBorder(),
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'A descrição é obrigatória';
                        }
                        return null;
                      },
                      maxLength: _quantidadeMaxCaracteresDescricao,
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
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState != null &&
                          !_formKey.currentState!.validate()) {
                        return;
                      }
                      _tarefa!.descricao = _descricaoController.text;
                      _tarefa.anotacao = _anotacaoController.text;
                      _salvarTarefas();
                      setState(() {
                        if (_adicionando) {
                          tarefas.add(_tarefa);
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

  _removerTarefa(_context, int index) {
    setState(() {
      tarefas.removeAt(index);
    });
    _salvarTarefas();
    Scaffold.of(_context).showSnackBar(SnackBar(
      content: Text("Tarefa removida!"),
      backgroundColor: Colors.green,
    ));
  }
}
