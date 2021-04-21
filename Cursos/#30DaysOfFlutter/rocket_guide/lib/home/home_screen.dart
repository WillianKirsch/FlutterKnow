import 'package:flutter/material.dart';
import 'package:rck_guide/backend/backend.dart';
import 'package:provider/provider.dart';
import 'package:rck_guide/home/rocket_list_tile.dart';
import 'package:rck_guide/rocket_details/rocket_details.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rocket Guide'),
      ),
      body: FutureBuilder<List<Rocket>>(
        future: context.watch<Backend>().getRockets(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Oops!'));
          } else if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            final rockets = snapshot.data;
            return ListView(
              children: [
                for (final rocket in rockets)
                  RocketListTile(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              RocketDetailsScreen(rocket: rocket),
                        ),
                      );
                    },
                    rocket: rocket,
                  ),
              ],
            );
          }
        },
      ),
    );
  }
}
