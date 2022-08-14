import 'dart:convert';

import 'package:assignment_4/models/weather_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  Future<WeatherData> futureData = Future<WeatherData>.delayed(const Duration(seconds: 0), () {
    return const WeatherData();
  });
  final _cityTextController = TextEditingController(); // The city text controller
  var city = "";

  //Code to get the weather for the city given by user
  Future<WeatherData> getWeatherData() async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&units=metric&appid=2c8d07a872803f8287189b1366f2dda6'));
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json['main'] != null) {
        return WeatherData.fromJson(json['main']);
      } else {
        throw Exception('Data parsing error');
      }
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather'),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            TextFormField(
              controller: _cityTextController,
              decoration: InputDecoration(
                hintText: "City Name",
                errorBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(6.0),
                  borderSide: const BorderSide(
                    color: Colors.red,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: ElevatedButton(
                onPressed: () {
                  var newCity = _cityTextController.text;
                  if (newCity.isNotEmpty) {
                    setState(() {
                      city = newCity;
                      futureData = getWeatherData();
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // <-- Radius
                  ),
                ),
                child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                    child: const Text('Fetch Data')),
              ),
            ),
            Expanded(
              child: FutureBuilder<WeatherData>( // Future builder to show whether data
                future: futureData,
                builder: (context, snapshot) {
                  if (city.isNotEmpty) {
                    if (snapshot.hasData) { //If the snapshot has data
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                child: Text("Temperature: ${snapshot.data?.temp}", style: const TextStyle(
                                    fontSize: 16
                                ),)
                            ),
                            Container(
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                child: Text("Feels Like: ${snapshot.data?.feelsLike}", style: const TextStyle(
                                  fontSize: 16
                                ),)
                            ),
                            Container(
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                child: Text("Temperature Min: ${snapshot.data?.tempMin}", style: const TextStyle(
                                    fontSize: 16
                                ),)
                            ),
                            Container(
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                child: Text("Temperature Max: ${snapshot.data?.tempMax}", style: const TextStyle(
                                    fontSize: 16
                                ),)
                            ),
                            Container(
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                child: Text("Pressure: ${snapshot.data?.pressure}", style: const TextStyle(
                                    fontSize: 16
                                ),)
                            ),
                            Container(
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                child: Text("Humidity: ${snapshot.data?.humidity}", style: const TextStyle(
                                    fontSize: 16
                                ),)
                            ),
                          ],
                        ),
                      );
                    } else if (snapshot.hasError) { //If the snapshot has error
                      return Center(child: Text('${snapshot.error}'));
                    }
                    return const Center(child: CircularProgressIndicator());
                  }
                  return const Center(child: Text('No Data'));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
