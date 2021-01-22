import 'package:flutter/material.dart';

class FlkInputLabel extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  FlkInputLabel(this.label, {this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 100,
          alignment: Alignment.centerRight,
          child: Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Big Shoulders Display",
              fontSize: 35,
            ),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: 30),
            child: TextFormField(
              controller: controller,
              keyboardType: TextInputType.number,
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Big Shoulders Display",
                fontSize: 45,
              ),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).primaryColor),
                ),
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                  color: Theme.of(context).accentColor,
                )),
                prefixIcon: Icon(
                  Icons.monetization_on,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
