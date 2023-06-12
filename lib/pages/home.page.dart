
// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import '../config/global.params.dart';
import '../menu/drawer.widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class HomePage extends StatelessWidget{
  late SharedPreferences prefs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page Home')),
      drawer: MyDrawer(),
      body: Center(
        child: Wrap(
          children: [
            ...(GlobalParams.accueil as List).map((item) {
              return InkWell(
                child: Ink.image(
                  height: 180,
                  width: 180,
                  image: item['image'],
                ),
                onTap: (){
                  if('${item['image']}'!=AssetImage('images/deconnexion.png',))
                    Navigator.pushNamed(context, "${item['route']}");
                  else
                    _deconnexion(context);
            },
      );
  }),//.toList(),
          ],
        ),
      ),
);
}
  Future<void> _deconnexion(BuildContext context)async {
    prefs=await SharedPreferences.getInstance();
    prefs.setBool("connecte", false);
    Navigator.of(context).pushNamedAndRemoveUntil('/authentification', (Route<dynamic> route) => false ,);
  }
}
