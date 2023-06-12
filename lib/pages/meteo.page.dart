import '../pages/meteoDetails.page.dart';
import 'package:flutter/material.dart';
class MeteoPage extends StatelessWidget{
  final TextEditingController _villeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page Meteo'),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width:300,
                child:TextField(
                  controller: _villeController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.place),
                    border: OutlineInputBorder(),
                    hintText: 'Ville',
                  ),
                  autofocus: false,
                ),
        ),
            Container(height: 20),
              Container(
                child: SizedBox(
                  width:300,
                  height:50,
                  child:ElevatedButton(
                    child: const Text("Chercher"),
                    onPressed: (){
                      _onGetMeteoDetails(context);
                    },
                  ),
                ),
              ),
            // Text(onPressed: onPressed, child: Text("")),

          ],
        ),

      ),
    );}

  void _onGetMeteoDetails(BuildContext context) {
    String ville=_villeController.text;
    Navigator.push(context,
    MaterialPageRoute(builder: (context)=>MeteoDetailsPage(ville:ville),
    ),
    );
  }
}
