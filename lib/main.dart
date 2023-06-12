// ignore_for_file: prefer_const_constructors

import 'package:my_app/pages/meteoDetails.page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/ajout_modif_contact.page.dart';
import 'pages/contact.page.dart';
import 'pages/gallerie.page.dart';
import 'pages/home.page.dart';
import 'pages/inscription.page.dart';
import 'pages/authentification.page.dart';
import 'pages/meteo.page.dart';
import 'pages/parametres.page.dart';
import 'pages/pays.page.dart';
void main() async{
  //pour s'assurer que les widgets de flutter sont initialisés avant l'execution de l'app
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sh=await SharedPreferences.getInstance();
  //si aucune valeur trouvé dans sh connecte=false
  bool connecte=sh.getBool('connecte') ?? false;

  runApp( MyApp(connecte:connecte));
}

class MyApp extends StatelessWidget{
  final bool connecte;
  MyApp({required this.connecte});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      //si con=vrai ->route=home sinon la page qui affiche la 1ere selon l'00etat de connecte
      initialRoute: connecte ? '/home' : '/inscription',
      routes: {
        '/home':(context)=>HomePage(),
        '/inscription':(context)=>InscriptionPage(),
        '/authentification':(context)=>AuthentificationPage(),
        '/meteo':(context)=>MeteoPage(),
        '/meteodetails':(context)=>MeteoDetailsPage(ville: '',),
        '/gallerie':(context)=>Gallerie(),
        '/parametres':(context)=>Parametres(),
        '/pays':(context)=>Pays(),
        '/contact':(context)=>ContactPage(),
        '/addeditcontact':(context)=>AjoutModifContact(),
      },
    );
  }
}
