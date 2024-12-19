import 'package:agri_saathi/appscreens/marketplaceprice/marketprice.dart';
import 'package:agri_saathi/appscreens/nearbyyou/toolnearyou.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather/weather.dart';
import 'package:agri_saathi/appscreens/wheather/consts.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final WeatherFactory _wf = WeatherFactory(OPENWHEATHER_API_KEY);

  Weather? _weather;

  @override
  void initState() {
    super.initState();
    _fetchWeather();
    getCurrentLocation();
  }

  Future<void> _fetchWeather() async {
    Weather? weather = await _wf.currentWeatherByCityName("Kakinada");
    setState(() {
      _weather = weather;
    });
  }

  getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      print("Location Denied");
      LocationPermission ask = await Geolocator.checkPermission();
    } else {
      Position currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
      print("Latitude=${currentPosition.latitude.toString()}");
      print("Longitude=${currentPosition.longitude.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F5E8),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Upper part: Green container and Weather card inside a Stack
            Stack(
              clipBehavior: Clip.none,
              children: [
                // Green header container (fixed background)
                Container(
                  height: MediaQuery.of(context).size.height * 0.3, // Adjust the height as needed
                  padding: const EdgeInsets.only(
                    top: 50,
                    left: 20,
                    right: 20,
                    bottom: 50,
                  ),
                  decoration: const BoxDecoration(
                    color: Color(0xFF7CB342),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Greeting text
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hello, Farmer ",
                                style: GoogleFonts.roboto(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "Sunday, 01 Dec 2024",
                                style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.notifications,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Weather card (overlapping the green header)
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.17, // Adjust as needed
                  left: 20,
                  right: 20,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Location and weather
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _weather?.areaName ?? "Fetching...",
                                  style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  "${_weather?.temperature?.celsius?.toStringAsFixed(1) ?? '--'}°C Soil temp",
                                  style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Image.network(
                                  'https://openweathermap.org/img/wn/${_weather?.weatherIcon ?? "10d"}@2x.png',
                                  width: 50,
                                  height: 50,
                                ),
                                Text(
                                  "${_weather?.temperature?.celsius?.toStringAsFixed(1) ?? '--'}°C",
                                  style: GoogleFonts.roboto(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // Weather details
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            weatherInfo("${_weather?.humidity ?? 0}%", "Humidity"),
                            weatherInfo("${_weather?.windSpeed ?? 0} m/s", "Wind"),
                            weatherInfo("${_weather?.rainLast3Hours ?? 0} mm", "Rainfall"),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // Sunrise and Sunset
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            sunriseSunsetItem(
                              _weather?.sunrise != null
                                  ? "${_weather?.sunrise?.hour}:${_weather?.sunrise?.minute}"
                                  : "--:--",
                              Icons.wb_sunny,
                              "Sunrise",
                            ),
                            sunriseSunsetItem(
                              _weather?.sunset != null
                                  ? "${_weather?.sunset?.hour}:${_weather?.sunset?.minute}"
                                  : "--:--",
                              Icons.nightlight_round,
                              "Sunset",
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Add spacing to avoid overlap of the weather card and scrollable content
            const SizedBox(height: 150), // Increased height to avoid overlap
            // Scrollable content
            Marketprice(),
            Toolnearyou(),
          ],
        ),
      ),
    );
  }

  Widget weatherInfo(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.roboto(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: GoogleFonts.roboto(
            fontSize: 14,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }

  Widget sunriseSunsetItem(String time, IconData icon, String label) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.amber, size: 20),
            const SizedBox(width: 5),
            Text(
              time,
              style: GoogleFonts.roboto(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: GoogleFonts.roboto(
            fontSize: 14,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}
