import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/constants.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/screens/search_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({this.locationWeather});

  final locationWeather;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  WeatherModel weather = WeatherModel();

  DateTime date = DateTime.now();

  late int temperature;
  late String weatherIcon;
  late String cityName;
  late String dayName;
  late String weatherCondition;

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = 'Error';
        cityName = '';
        weatherCondition = '';
        return;
      }

      var temp = weatherData['main']['temp'];
      temperature = temp.toInt();

      var condition = weatherData['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(condition);

      cityName = weatherData['name'];

      dayName = DateFormat('EEEE').format(date);

      weatherCondition = weatherData['weather'][0]['main'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            padding: EdgeInsets.only(left: 30),
            icon: Icon(
              Icons.location_on,
              color: kIconColor,
            ),
            iconSize: 35,
            onPressed: () async {
              var weatherData = await weather.getLocationWeather();
              updateUI(weatherData);
            },
          ),
          actions: [
            IconButton(
              padding: EdgeInsets.only(right: 30),
              icon: Icon(
                Icons.search,
                color: kIconColor,
              ),
              iconSize: 40,
              onPressed: () async {
                var typedName = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SearchScreen();
                    },
                  ),
                );
                if (typedName != null) {
                  var weatherData = await weather.getCityWeather(typedName);
                  updateUI(weatherData);
                }
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 40),
            margin: EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: kBackColor,
            ),
            alignment: Alignment.center,
            // constraints: BoxConstraints.expand(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Container(
                      child: Text(
                        '$cityName',
                        style: kCustomTextStyle.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 48,
                        ),
                      ),
                    ),
                    Text(
                      '$dayName',
                      style: kCustomTextStyle.copyWith(
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Image(
                  image: AssetImage(
                    'assets/images/$weatherIcon.gif',
                  ),
                  height: 200,
                ),
                Column(
                  children: [
                     Text(
                        '$temperature°',
                        style: kCustomTextStyle.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 55,
                        ),
                     ),
                    Text(
                      '$weatherCondition',
                      style: kCustomTextStyle.copyWith(
                        fontSize: 24.0,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),

    );
  }
}