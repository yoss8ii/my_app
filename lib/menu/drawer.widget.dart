// ignore_for_file: must_be_immutable, use_key_in_widget_constructors

import 'package:my_app/config/global.params.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDrawer extends StatelessWidget{
  late SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
            DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors:[Colors.white, Colors.blue] )),
             child: Center(
                     child: CircleAvatar(
                       backgroundImage: AssetImage("images/photo.png"),
                       radius: 80,
                     ),
             )),
          //Parcourir les # éléments du menu
          ...(GlobalParams.menus as List).map((item) {
            return ListTile(
              title: Text('${item['title']}',style: TextStyle(fontSize: 22),),
              leading: item['icon'],
              trailing: Icon(Icons.arrow_right,color: Colors.blue,),
              onTap: ()async{
                if('${item['title']}'!="Déconnexion"){
                  Navigator.of(context).pop();
                  Navigator.pushNamed(context, "${item['route']}");
                }
                else
                  {
                    prefs=await SharedPreferences.getInstance();
                    prefs.setBool("connecte", false);
                    Navigator.of(context).pushNamedAndRemoveUntil('/authentification', (Route<dynamic>route) => false);
                  }
              },
            );
          })
        ],
      )
    );
  }
}