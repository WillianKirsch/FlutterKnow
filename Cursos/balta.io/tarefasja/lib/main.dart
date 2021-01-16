import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'models/item.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tarefas já',
      debugShowCheckedModeBanner:
          true, // Flag para mostrar ou não que está em ambiente de debug
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: InicioPage(titulo: 'Início'),
    );
  }
}

class InicioPage extends StatefulWidget {
  InicioPage({Key key, this.titulo}) : super(key: key) {
    itens = [];
    itens.add(Item(anotacao: "Banana", feito: false));
    itens.add(Item(anotacao: "Maça", feito: true));
  }

  final String titulo;

  var itens = new List<Item>();

  @override
  _InicioPageState createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.titulo),
        leading: Icon(Icons.menu),
        actions: <Widget>[
          Icon(
            Icons.mark_email_read,
          ),
          Icon(
            Icons.mail,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: widget.itens.length,
        itemBuilder: (BuildContext context, int index) {
          final item = widget.itens[index];
          return Card(
            elevation: 6,
            child: CheckboxListTile(
              key: Key(index.toString()),
              title: Text(item.anotacao),
              value: item.feito,
              onChanged: (valor) {
                setState(() {
                  item.feito = valor;
                });
              },
            ),
          );
        },
      ),
      // Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //       Text(
      //         'Ebaa:',
      //       ),
      //       Text(
      //         'Aqui seria o número',
      //         style: Theme.of(context).textTheme.headline4,
      //       ),
      //     ],
      //   ),
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: _novoItem,
        tooltip: 'Adicionar item',
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _novoItem() async {
    int _quantidadeMaxCaracteresTitulo = 100;
    Item _item = Item();
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text('Novo item'),
            contentPadding: EdgeInsets.only(left: 24, right: 24, top: 12),
            children: <Widget>[
              TextFormField(
                autocorrect: true,
                autofocus: true,
                enableSuggestions: true,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Descrição",
                  helperText: "Até $_quantidadeMaxCaracteresTitulo caracteres",
                  border: OutlineInputBorder(),
                ),
                maxLength: _quantidadeMaxCaracteresTitulo,
              ),
              TextFormField(
                autocorrect: true,
                autofocus: true,
                enableSuggestions: true,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  labelText: "Anotação",
                  helperText: "Descreva um pouco mais sobre a tarefa.",
                  border: OutlineInputBorder(),
                ),
                maxLength: _quantidadeMaxCaracteresTitulo,
              ),
              ButtonBar(
                children: [
                  RaisedButton(
                    onPressed: () {
                      //TODO: Salvar o item
                      Navigator.pop(context);
                    },
                    child: Text("Adicionar"),
                  )
                ],
              )
            ],
          );
        });
  }
}
