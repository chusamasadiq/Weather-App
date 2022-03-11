import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lab9/network.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lab9/LocationScreen.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  Position? position;
  double? lat;
  double? lon;
  void getLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
        permission = await Geolocator.requestPermission();
        position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.low,
        timeLimit: Duration(seconds: 5));

        lat = position!.latitude;
        lon = position!.longitude;
        networkhelper helper=  networkhelper(Uri.parse("http://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=50ea0297853174e4b487611d4560975b"));
        var weatherdata = await helper.getData();
        print(weatherdata);

      Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(locationWeather: weatherdata);
    }));
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(child: SpinKitDoubleBounce(color: Colors.grey, size: 40)),
      ),
    );
  }


}
