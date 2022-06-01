import 'package:example/weather_screen/weather_data/my_location.dart';
import 'package:example/weather_screen/weather_data/network.dart';
import 'package:example/weather_screen/weather_screen.dart';
import 'package:flutter/material.dart';

const apiKey = '7a2a88dcfcb6ab8a79a2483118a48ade';

class WeatherLoading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<WeatherLoading> {
  late double latitude3;
  late double longitude3;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation();
  }

  void getLocation() async {
    MyLocation myLocation = MyLocation();
    await myLocation.getMyCurrentLocation();
    latitude3 = myLocation.latitude2;
    longitude3 = myLocation.longitude2;
    print(latitude3);
    print(longitude3);

    Network network = Network(
        'https://api.openweathermap.org/data/2.5/weather'
            '?lat=$latitude3&lon=$longitude3&appid=$apiKey&units=metric',
        'https://api.openweathermap.org/data/2.5/air_pollution'
            '?lat=$latitude3&lon=$longitude3&appid=$apiKey');

    var weatherData = await network.getJsonData();
    print(weatherData);

    var airData = await network.getAirData();
    print(airData);

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return WeatherScreen(
        parseWeatherData: weatherData,
        parseAirPollution: airData,
      );
    }));
  }

  // void fetchData() async{
  //
  //     var myJson = parsingData['weather'][0]['description'];
  //     print(myJson);
  //
  //     var wind = parsingData['wind']['speed'];
  //     print(wind);
  //
  //     var id =parsingData['id'];
  //     print(id);
  //   }else{
  //     print(response.statusCode);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          // onPressed: null,
          onPressed: (){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WeatherScreen())
            );
          },
          child: Text(
            'Get my location',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
