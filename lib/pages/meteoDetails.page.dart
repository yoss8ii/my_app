import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class MeteoDetailsPage extends StatefulWidget{
  final String ville;
   MeteoDetailsPage({required this.ville});
  @override
  _MeteoDetailsPageState createState() => _MeteoDetailsPageState();
}

class _MeteoDetailsPageState extends State<MeteoDetailsPage> {
  Map<String,dynamic>? meteoData;
  bool isLoading=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMeteoData(widget.ville);
  }

  Future<void> getMeteoData(String ville) async {
    setState(() {
      isLoading = true;
    });
    String apiKey = '72206e7fb0b1d0c8a3df7adca9cbba35';
    String url = 'https://api.openweathermap.org/data/2.5/forecast?q=$ville&appid=$apiKey';

    try {
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        setState(() {
          meteoData = json.decode(response.body);
          print(meteoData);
        });
      } else {
        print('Request failed: ${response.statusCode}.');
      }
    } catch (e) {
      print(' erreur: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page Meteo Details ${widget.ville}'),
      ),
      //if isLod=true ->center
      body: isLoading ? Center(
        child: CircularProgressIndicator(),
      )
          :meteoData!=null
          ? ListView.builder(
        itemCount: meteoData!['list'].length,
        itemBuilder: (context,index){
          Map<String,dynamic> weather= meteoData!['list'][index]['weather'][0];

          DateTime dateTime=DateTime.parse(meteoData!['list'][index]['dt_txt']);
          String time='${dateTime.hour.toString().padLeft(2,'0')}:${dateTime.minute.toString().padLeft(2,'0')}';
          String date=DateFormat('dd/MM/yyyy').format(dateTime);
    //String dateText=DateFormat('dd/MM/yyyy').format(DateTime.now());
    //String timeText=DateFormat('HH:mm').format(DateTime.now());
          double temperature=meteoData!['list'][index]['main']['temp']- 273.15;
          String description=weather['description'];
          String iconCode=weather['icon'];

          return Card(
            child: ListTile(
              title:Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage('http://openweathermap.org/img/w/$iconCode.png'),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(date),
                      SizedBox(height: 5),
                      Text('$time | $description'),
                    ],
                  ),
                ],
              ),
              subtitle:Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('${temperature.toStringAsFixed(0)}°C'),
                ],
              ),
            ),
          );
          },
      )
          :Container(),
    );
  }
}