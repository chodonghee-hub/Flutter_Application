import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timer_builder/timer_builder.dart';
import 'weather_model/weather_model.dart';

class WeatherScreen extends StatefulWidget {
  WeatherScreen({this.parseWeatherData, this.parseAirPollution});
  final dynamic parseWeatherData;
  final dynamic parseAirPollution;

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  WeatherModel model = WeatherModel();
  late String cityName;
  late int temp;
  late Widget icon;
  late String des;
  late Widget airIcon;
  late Widget airState;
  late double dust1;
  late double dust2;
  var date = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // ###################### 에러 발생 #########################
    // updateData(widget.parseWeatherData, widget.parseAirPollution);
  }

  void updateData(dynamic weatherData, dynamic airData) {
    double temp2 = weatherData['main']['temp'].toDouble();
    int condition = weatherData['weather'][0]['id'];
    int index = airData['list'][0]['main']['aqi'];
    des = weatherData['weather'][0]['description'];
    dust1 = airData['list'][0]['components']['pm10'];
    dust2 = airData['list'][0]['components']['pm2_5'];
    temp = temp2.round();
    cityName = weatherData['name'];
    icon = model.getWeatherIcon(condition)!;
    airIcon = model.getAirIcon(index)!;
    airState = model.getAirCondition(index)!;

    print(temp);
    print(cityName);
  }

  String getSystemTime() {
    var now = DateTime.now();
    return DateFormat("h:mm a").format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        //title: Text(''),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.near_me),
          onPressed: () {},
          iconSize: 30.0,
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.location_searching,
            ),
            onPressed: () {},
            iconSize: 30.0,
          )
        ],
      ),
      body: Container(
        child: Stack(
          children: [
            Image.asset(
              'image/weather_background2.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 150.0,
                            ),
                            Text('WeahterScreen'),

                            // Text(
                            //   '$cityName',
                            //   style: TextStyle(
                            //     fontFamily: 'Noto_Sans_KR',
                            //     fontSize: 20.0,
                            //     color: Color.fromARGB(255, 255, 255, 255),
                            //   ),
                            // ),
                            // Row(
                            //   children: [
                            //     TimerBuilder.periodic(
                            //       (Duration(minutes: 1)),
                            //       builder: (context) {
                            //         print('${getSystemTime()}');
                            //         return Text(
                            //           '${getSystemTime()}',
                            //           style: TextStyle(
                            //             fontFamily: 'Noto_Sans_KR',
                            //             fontSize: 20.0,
                            //             color: Color.fromARGB(255, 255, 255, 255),
                            //           ),
                            //         );
                            //       },
                            //     ),
                            //     Text(DateFormat(' - EEEE, ').format(date),
                            //       style: TextStyle(
                            //         fontFamily: 'Noto_Sans_KR',
                            //         fontSize: 20.0,
                            //         color: Color.fromARGB(255, 255, 255, 255),
                            //       ),
                            //     ),
                            //     Text(DateFormat('d MMM, yyy').format(date),
                            //       style: TextStyle(
                            //         fontFamily: 'Noto_Sans_KR',
                            //         fontSize: 20.0,
                            //         color: Color.fromARGB(255, 255, 255, 255),
                            //       ),
                            //     ),
                            //   ],
                            // )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text(
                            //   '$temp\u2103',
                            //   style: TextStyle(
                            //     fontFamily: 'Noto_Sans_KR',
                            //     fontSize: 20.0,
                            //     color: Color.fromARGB(255, 255, 255, 255),
                            //   ),
                            // ),
                            Text('temp'),
                            Row(
                              children: [
                                // icon,
                                SizedBox(
                                  width: 10.0,
                                ),
                                // Text(
                                //   '$des',
                                //   style: TextStyle(
                                //     fontFamily: 'Noto_Sans_KR',
                                //     fontSize: 20.0,
                                //     color: Color.fromARGB(255, 255, 255, 255),
                                //   ),
                                // ),
                                Text('des'),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Divider(
                        height: 15.0,
                        thickness: 2.0,
                        color: Colors.white30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                'AQI(대기질지수)',
                                style: TextStyle(
                                  fontFamily: 'Noto_Sans_KR',
                                  fontSize: 20.0,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                              ),
                              // SizedBox(
                              //   height: 10.0,
                              // ),
                              // airIcon,
                              // SizedBox(
                              //   height: 10.0,
                              // ),
                              // airState,
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                '미세먼지',
                                style: TextStyle(
                                  fontFamily: 'Noto_Sans_KR',
                                  fontSize: 20.0,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              // Text(
                              //   '$dust1',
                              //   style: TextStyle(
                              //     fontFamily: 'Noto_Sans_KR',
                              //     fontSize: 20.0,
                              //     color: Color.fromARGB(255, 255, 255, 255),
                              //   ),
                              // ),
                              Text('dust'),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                '㎍/m3',
                                style: TextStyle(
                                  fontFamily: 'Noto_Sans_KR',
                                  fontSize: 20.0,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                '초미세먼지',
                                style: TextStyle(
                                  fontFamily: 'Noto_Sans_KR',
                                  fontSize: 20.0,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              // Text(
                              //   '$dust2',
                              //   style: TextStyle(
                              //     fontFamily: 'Noto_Sans_KR',
                              //     fontSize: 20.0,
                              //     color: Color.fromARGB(255, 255, 255, 255),
                              //   ),
                              // ),
                              Text('dust2'),

                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                '㎍/m3',
                                style: TextStyle(
                                  fontFamily: 'Noto_Sans_KR',
                                  fontSize: 20.0,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
