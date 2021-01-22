import 'package:flutter/material.dart';
import 'package:meu_auto/pages/alcool_gasolina.dart';
import 'package:meu_auto/pages/veiculos_page.dart';

class FlkAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String titulo;
  final List<Widget> actions;
  final GlobalKey<ScaffoldState> scaffoldKey;
  FlkAppBar(this.titulo, {@required this.scaffoldKey, this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(titulo),
      leading: IconButton(
        icon: Icon(Icons.menu),
        tooltip: 'Menu',
        onPressed: () => scaffoldKey.currentState.openDrawer(),
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class FlkDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: <Widget>[
        DrawerHeader(
          child: Center(child: Text('Meu Auto')),
          decoration: BoxDecoration(
            color: Theme.of(context).accentColor,
          ),
        ),
        ListTile(
          leading: Icon(Icons.car_rental),
          title: Text("Meus autos"),
          subtitle: Text("Todos os seus veículos"),
          trailing: Icon(Icons.arrow_forward),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => VeiculosPage()));
          },
        ),
        ListTile(
          leading: Image.asset(
            "assets/images/aog-white.png",
            color: Theme.of(context).iconTheme.color,
            height: 30,
          ),
          title: Text("Álcool ou Gasolina?"),
          subtitle: Text("Qual está compensando hoje?"),
          trailing: Icon(Icons.arrow_forward),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => AlcoolGasolina()));
          },
        )
      ],
    ));
  }
}
