
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthentificationPage extends StatefulWidget{
  @override
  State<AuthentificationPage> createState() => _AuthentificationPageState();
}

class _AuthentificationPageState extends State<AuthentificationPage> {

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page Authentification'),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width:300,
                child:TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
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
                  obscureText: true,
                  autofocus: false,
                ),

              ),
              Container(height: 20),
              SizedBox(
                width:300,
                height:50,
                child:ElevatedButton(
                  child: const Text("Connexion"),
                  onPressed: (){
                    _onAuthentifier(context);
                  },
                ),
              ),
              TextButton(onPressed: onPressed, child: Text("Nouvel Utilisateur")),
            ]
        ),

      ),

    );}

  void onPressed() {
    Navigator.pushNamed(context, '/inscription');
  }
  void _onAuthentifier(BuildContext context) async {
    String username=_usernameController.text;
    String password=_passwordController.text;

    // Vérifier si les champs sont vides
    if (username.isEmpty || password.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(' champs vides!!'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return;
    }
    //Récupération
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    String user=sharedPreferences.getString('username')?? '';
    String pass=sharedPreferences.getString('password')?? '';
    //enregistrer l'état de connexion

    //await sharedPreferences.setBool('connecte', true);

    if(username==user && password==pass){
      await sharedPreferences.setBool('connecte', true);
      Navigator.pushNamed(context,'/home');
    }else{
      //print('les champs ne sont pas identiques !!');
      showDialog(context: context, builder: (BuildContext){
        return AlertDialog(title: Text('Error'),
        content: Text('Vérifiez vos données!!Incorrect'),
        actions: [
          TextButton(
            child: Text('OK'),
            onPressed: (){
              Navigator.of(context).pop();
            },
          ),
        ],);
      },);
    }
  }
}
