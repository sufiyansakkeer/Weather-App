import 'package:flutter/material.dart';
import 'package:weather_app/api_key/api_key.dart';
import 'package:weather_app/model/weather.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CurrentWeatherPage extends StatefulWidget {
  const CurrentWeatherPage({super.key});

  @override
  State<CurrentWeatherPage> createState() => _CurrentWeatherPageState();
}

class _CurrentWeatherPageState extends State<CurrentWeatherPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: FutureBuilder(
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Weather? weather = snapshot.data;
                if (weather == null) {
                  return const Text("Error while getting data");
                } else {
                  return weatherBox(weather);
                }
              } else {
                return const CircularProgressIndicator(
                  strokeWidth: 2,
                );
              }
            },
            future: getCurrentWeather(),
          ),
        ),
      ),
    );
  }

  Widget weatherBox(Weather weather) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          child: Text(
            "${weather.temp}°C",
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(5),
          child: Text(
            weather.description,
          ),
        ),
        Container(
          margin: const EdgeInsets.all(5),
          child: Text(
            "Feels Like:${weather.feelsLike}°C",
          ),
        ),
        Container(
          margin: const EdgeInsets.all(5),
          child: Text(
            "H: ${weather.high}°C L:${weather.low}°C",
          ),
        ),
      ],
    );
  }

  Future getCurrentWeather() async {
    Weather? weather;
    String city = "thrissur";

    var url =
        "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      weather = Weather.fromJson(jsonDecode(response.body));
    } else {}
    return weather;
  }
}
