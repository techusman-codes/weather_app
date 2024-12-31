import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:weather_app/pages/additional_info.dart';
import 'package:weather_app/pages/hourly_card.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/pages/secret.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      String cityName = 'London';
      final res = await http.get(
        Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$openWeatherApiKey',
        ),
      );

      final data = jsonDecode(res.body);
      // temp = data['main']['temp'] - 2;

      if (data['cod'] != '200') {
        throw 'An unexpected error occured';
      }
      // data['list'][0]['main']['temp'];
      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Weather App',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureBuilder(
        future: getCurrentWeather(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: const CircularProgressIndicator.adaptive(),
            );
          }
          // if (snapshot.hasError) {
          //   return Text(snapshot.error.toString());
          // }

          final data = snapshot.data;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // main card
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 10,
                          sigmaY: 10,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Text(
                                '200 k',
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Icon(
                                Icons.cloud,
                                size: 32,
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Text(
                                'Rain',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // weather forcast card
                const SizedBox(
                  height: 20,
                ),

                const Text(
                  'Weather Forcast',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      HourlyCard(
                        icon: Icons.cloud,
                        time: '0.00',
                        tempreature: '302.22',
                      ),
                      HourlyCard(
                        icon: Icons.sunny,
                        time: '3.00',
                        tempreature: '300.52',
                      ),
                      HourlyCard(
                        icon: Icons.cloud,
                        time: '06.00',
                        tempreature: '302.22',
                      ),
                      HourlyCard(
                        icon: Icons.sunny,
                        time: '09.00',
                        tempreature: '300.12',
                      ),
                      HourlyCard(
                        icon: Icons.cloud,
                        time: '12.00',
                        tempreature: '304.12',
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: 20,
                ),
                // addistional info
                const Text(
                  'Additional Information',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AdditionalInfo(
                      icon: Icons.water_drop,
                      label: 'Humidity',
                      value: '91',
                    ),
                    AdditionalInfo(
                      icon: Icons.air,
                      label: 'WindSpeed',
                      value: '7.5',
                    ),
                    AdditionalInfo(
                      icon: Icons.beach_access,
                      label: 'Pressure',
                      value: '1000',
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
