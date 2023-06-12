import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InscriptionPage extends StatefulWidget{
  @override
  State<InscriptionPage> createState() => _InscriptionPageState();
}

class _InscriptionPageState extends State<InscriptionPage> {

  //Controleurs pour les zones de texte
  //créer con de saisie de txt
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page Inscription'),
      ),
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width:300,
                    child:TextField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                        labelText: 'Entrez le  Username',
                        hintText: 'Username',
                      ),
                      autofocus: false,
                    ),

                ),
                Container(height: 20),//space between text field
                Container(
                  width:300,
                  child: TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.password),
                      border: OutlineInputBorder(),
                      labelText: 'Entrez le password',
                      hintText: 'password',
                    ),
                    obscureText: true,//affiche ca crypté
                    autofocus: false,
                  ),

                ),
                Container(height: 20),
                SizedBox(
                  width:300,
                  height:50,
                  child:ElevatedButton(
                    child: const Text("Inscription"),
                    onPressed: (){
                      _onInscrire(context);
                    },
                  ),
                ),

                TextButton(onPressed: onPressed, child: Text("J'ai déja un compte")),
              ],
          ),
      ),
    );}

  void onPressed() {
    Navigator.pushNamed(context, '/authentification');
  }

  void _onInscrire(BuildContext context) async{
    String username=_usernameController.text;
    String password=_passwordController.text;
if(username.isEmpty || password.isEmpty){
  showDialog(context: context, builder: (BuildContext context){
    return AlertDialog(
      title: Text('Error'),
      content: Text('champs vide!!!!'),
      actions: [
        TextButton(
          child: Text('OK'),
          onPressed: (){
            //feremer la page actuelle fenetre
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  },);return;
}
  SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
  await sharedPreferences.setString('username', username);
  await sharedPreferences.setString('password', password);
  await sharedPreferences.setBool('connecte', true);
//naviguer vers la pg home ,contexte=actuel
  Navigator.pushNamed(context, '/home');

  }
}
