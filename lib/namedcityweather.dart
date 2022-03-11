import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'LocationScreen.dart';
import 'network.dart';

class CityWeather extends StatefulWidget {
  const CityWeather({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<CityWeather> {
  Position? position;
  double? latitude;
  double? longitude;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  String? CityName;

  void getLocatoin(String cname) async {

    networkhelper helper = networkhelper(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$cname&appid=ebb6ca3ff8a465445ea9c972bea4fe79'));

    var weatherData = await helper.getData();
    print(weatherData);

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(locationWeather: weatherData);
    }));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
        image: DecorationImage(
        image: AssetImage('images/city_background.jpg'),
          fit: BoxFit.cover,
        ),
        ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'City Name',
                      hintText:  'Enter City Name'
                ),
                onChanged: (value){
                  CityName=value;
                },
              ),
              SizedBox(height: 20,),
              ElevatedButton(
                  onPressed: () async {
                    getLocatoin(CityName.toString());
                  },
                  child: Text('Get Weather')
              )
            ],
          ),
        ),
    );
  }
}