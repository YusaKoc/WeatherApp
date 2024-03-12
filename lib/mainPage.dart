import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MainPage());
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Temperatures? _temperatures;
  Temperatures2? _temperatures2;
  Temperatures3? _temperatures3;

  @override
  void initState() {
    super.initState();
    fetchWeatherData();
    fetchWeatherData2();
    fetchWeatherData3();
  }

  Future<void> fetchWeatherData() async {
    final response = await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=36.899264&lon=34.886041&appid=db30c7fdba90460bd984624eaa66518f'));
    if (response.statusCode == 200) {
      setState(() {
        _temperatures = Temperatures.fromJson(jsonDecode(response.body));
      });
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<void> fetchWeatherData2() async {
    final response2 = await http.get(Uri.parse("https://api.openweathermap.org/data/2.5/weather?lat=41.0091982&lon=28.9662187&appid=db30c7fdba90460bd984624eaa66518f"));
    if (response2.statusCode == 200) {
      setState(() {
        _temperatures2 = Temperatures2.fromJson(jsonDecode(response2.body));
      });
    } else {
      throw Exception("Failed to load weather data");
    }
  }
  Future<void> fetchWeatherData3() async {
    final response3 = await http.get(Uri.parse("https://api.openweathermap.org/data/2.5/weather?lat=39.941307&lon=32.875748&appid=db30c7fdba90460bd984624eaa66518f"));
    if (response3.statusCode == 200) {
      setState(() {
        _temperatures3 = Temperatures3.fromJson(jsonDecode(response3.body));
      });
    } else {
      throw Exception("Failed to load weather data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text('Weather App'),
        ),
        body: Column(
          children: [
            Text("Turkiye",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 50),),
            Container(height: 2,width: 50000,color: Colors.red,),
            Center(
              child: (_temperatures == null && _temperatures2 == null && _temperatures3==null)
                  ? CircularProgressIndicator()
                  : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (_temperatures != null)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text('Tarsus'),
                        subtitle: Text('Feels Like: ${_temperatures!.main.feelsLike.toStringAsFixed(0)}C Temperature: ${_temperatures!.main.temp.toStringAsFixed(0)}C'),
                        leading: Image.asset("assets/tarsus_880460_3.jpg"),
                      ),
                    ),
                  Text('Description: ${_temperatures!.weather[0].description}'),
                  SizedBox(height: 10,),
                  Container(height: 2,width: 50000,color: Colors.black,),

                  if (_temperatures2 != null)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text('İstanbul'),
                        subtitle: Text('Feels Like: ${_temperatures2!.main2.feelsLike2.toStringAsFixed(0)}C Temperature: ${_temperatures2!.main2.temp2.toStringAsFixed(0)}C'),
                        leading: Image.asset("assets/galata.jpg"),
                      ),
                    ),
                  Text('Description: ${_temperatures2!.weather2[0].description2}'),
                  SizedBox(height: 10,),
                  Container(height: 2,width: 50000,color: Colors.black,),

                  if (_temperatures3 != null)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text('Ankara'),
                        subtitle: Text('Feels Like: ${_temperatures3!.main3.feelsLike3.toStringAsFixed(0)}C Temperature: ${_temperatures3!.main3.temp3.toStringAsFixed(0)}C'),
                        leading: Image.asset("assets/270px-Ataturk's_Mausoleum_(6225341313).jpg"),
                      ),
                    ),
                  Text('Description: ${_temperatures3!.weather3[0].description3}'),
                  SizedBox(height: 10,),
                  Container(height: 2,width: 50000,color: Colors.black,),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Temperatures {
  Coord coord;
  List<Weather> weather;
  String base;
  Main main;
  int visibility;
  Wind wind;
  Clouds clouds;
  int dt;
  Sys sys;
  int timezone;
  int id;
  String name;
  int cod;

  Temperatures({
    required this.coord,
    required this.weather,
    required this.base,
    required this.main,
    required this.visibility,
    required this.wind,
    required this.clouds,
    required this.dt,
    required this.sys,
    required this.timezone,
    required this.id,
    required this.name,
    required this.cod,
  });

  factory Temperatures.fromJson(Map<String, dynamic> json) {
    return Temperatures(
      coord: Coord.fromJson(json['coord']),
      weather: (json['weather'] as List).map((e) => Weather.fromJson(e)).toList(),
      base: json['base'],
      main: Main.fromJson(json['main']),
      visibility: json['visibility'],
      wind: Wind.fromJson(json['wind']),
      clouds: Clouds.fromJson(json['clouds']),
      dt: json['dt'],
      sys: Sys.fromJson(json['sys']),
      timezone: json['timezone'],
      id: json['id'],
      name: json['name'],
      cod: json['cod'],
    );
  }
}


class Clouds {
  int all;

  Clouds({
    required this.all,
  });

  factory Clouds.fromJson(Map<String, dynamic> json) {
    return Clouds(
      all: json['all'],
    );
  }
}

class Coord {
  double lon;
  double lat;

  Coord({
    required this.lon,
    required this.lat,
  });

  factory Coord.fromJson(Map<String, dynamic> json) {
    return Coord(
      lon: json['lon'].toDouble(),
      lat: json['lat'].toDouble(),
    );
  }
}

class Main {
  double temp;
  double feelsLike;

  Main({
    required this.temp,
    required this.feelsLike,
  });

  factory Main.fromJson(Map<String, dynamic> json) {
    return Main(
      temp: json['temp'].toDouble() - 273,
      feelsLike: json['feels_like'].toDouble() - 273,
    );
  }
}

class Sys {
  int sunrise;
  int sunset;

  Sys({
    required this.sunrise,
    required this.sunset,
  });

  factory Sys.fromJson(Map<String, dynamic> json) {
    return Sys(
      sunrise: json['sunrise'],
      sunset: json['sunset'],
    );
  }
}

class Weather {
  String description;

  Weather({
    required this.description,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      description: json['description'],
    );
  }
}

class Wind {
  double speed;

  Wind({
    required this.speed,
  });

  factory Wind.fromJson(Map<String, dynamic> json) {
    return Wind(
      speed: json['speed'].toDouble(),
    );
  }
}

// İstanbul için hava durumu modeli

class Temperatures2 {
  Coord2 coord2;
  List<Weather2> weather2;
  String base2;
  Main2 main2;
  int visibility2;
  Wind2 wind2;
  Clouds2 clouds2;
  int dt2;
  Sys2 sys2;
  int timezone2;
  int id2;
  String name2;
  int cod2;

  Temperatures2({
    required this.coord2,
    required this.weather2,
    required this.base2,
    required this.main2,
    required this.visibility2,
    required this.wind2,
    required this.clouds2,
    required this.dt2,
    required this.sys2,
    required this.timezone2,
    required this.id2,
    required this.name2,
    required this.cod2,
  });

  factory Temperatures2.fromJson(Map<String, dynamic> json) {
    return Temperatures2(
      coord2: Coord2.fromJson(json['coord']),
      weather2: (json['weather'] as List).map((e) => Weather2.fromJson(e)).toList(),
      base2: json['base'],
      main2: Main2.fromJson(json['main']),
      visibility2: json['visibility'],
      wind2: Wind2.fromJson(json['wind']),
      clouds2: Clouds2.fromJson(json['clouds']),
      dt2: json['dt'],
      sys2: Sys2.fromJson(json['sys']),
      timezone2: json['timezone'],
      id2: json['id'],
      name2: json['name'],
      cod2: json['cod'],
    );
  }
}

class Clouds2 {
  int all2;

  Clouds2({
    required this.all2,
  });

  factory Clouds2.fromJson(Map<String, dynamic> json) {
    return Clouds2(
      all2: json['all'],
    );
  }
}

class Coord2 {
  double lon2;
  double lat2;

  Coord2({
    required this.lon2,
    required this.lat2,
  });

  factory Coord2.fromJson(Map<String, dynamic> json) {
    return Coord2(
      lon2: json['lon'].toDouble(),
      lat2: json['lat'].toDouble(),
    );
  }
}

class Main2 {
  double temp2;
  double feelsLike2;

  Main2({
    required this.temp2,
    required this.feelsLike2,
  });

  factory Main2.fromJson(Map<String, dynamic> json) {
    return Main2(
      temp2: json['temp'].toDouble() - 273,
      feelsLike2: json['feels_like'].toDouble() - 273,
    );
  }
}

class Sys2 {
  int sunrise2;
  int sunset2;

  Sys2({
    required this.sunrise2,
    required this.sunset2,
  });

  factory Sys2.fromJson(Map<String, dynamic> json) {
    return Sys2(
      sunrise2: json['sunrise'],
      sunset2: json['sunset'],
    );
  }
}

class Weather2 {
  String description2;

  Weather2({
    required this.description2,
  });

  factory Weather2.fromJson(Map<String, dynamic> json) {
    return Weather2(
      description2: json['description'],
    );
  }
}

class Wind2 {
  double speed2;

  Wind2({
    required this.speed2,
  });

  factory Wind2.fromJson(Map<String, dynamic> json) {
    return Wind2(
      speed2: json['speed'].toDouble(),
    );
  }
}

//Ankara için Hava durumu

class Temperatures3 {
  Coord3 coord3;
  List<Weather3> weather3;
  String base3;
  Main3 main3;
  int visibility3;
  Wind3 wind3;
  Clouds3 clouds3;
  int dt3;
  Sys3 sys3;
  int timezone3;
  int id3;
  String name3;
  int cod3;

  Temperatures3({
    required this.coord3,
    required this.weather3,
    required this.base3,
    required this.main3,
    required this.visibility3,
    required this.wind3,
    required this.clouds3,
    required this.dt3,
    required this.sys3,
    required this.timezone3,
    required this.id3,
    required this.name3,
    required this.cod3,
  });

  factory Temperatures3.fromJson(Map<String, dynamic> json) {
    return Temperatures3(
      coord3: Coord3.fromJson(json['coord']),
      weather3: (json['weather'] as List).map((e) => Weather3.fromJson(e)).toList(),
      base3: json['base'],
      main3: Main3.fromJson(json['main']),
      visibility3: json['visibility'],
      wind3: Wind3.fromJson(json['wind']),
      clouds3: Clouds3.fromJson(json['clouds']),
      dt3: json['dt'],
      sys3: Sys3.fromJson(json['sys']),
      timezone3: json['timezone'],
      id3: json['id'],
      name3: json['name'],
      cod3: json['cod'],
    );
  }
}

class Clouds3 {
  int all3;

  Clouds3({
    required this.all3,
  });

  factory Clouds3.fromJson(Map<String, dynamic> json) {
    return Clouds3(
      all3: json['all'],
    );
  }
}

class Coord3 {
  double lon3;
  double lat3;

  Coord3({
    required this.lon3,
    required this.lat3,
  });

  factory Coord3.fromJson(Map<String, dynamic> json) {
    return Coord3(
      lon3: json['lon'].toDouble(),
      lat3: json['lat'].toDouble(),
    );
  }
}

class Main3 {
  double temp3;
  double feelsLike3;

  Main3({
    required this.temp3,
    required this.feelsLike3,
  });

  factory Main3.fromJson(Map<String, dynamic> json) {
    return Main3(
      temp3: json['temp'].toDouble() - 273,
      feelsLike3: json['feels_like'].toDouble() - 273,
    );
  }
}

class Sys3 {
  int sunrise3;
  int sunset3;

  Sys3({
    required this.sunrise3,
    required this.sunset3,
  });

  factory Sys3.fromJson(Map<String, dynamic> json) {
    return Sys3(
      sunrise3: json['sunrise'],
      sunset3: json['sunset'],
    );
  }
}

class Weather3 {
  String description3;

  Weather3({
    required this.description3,
  });

  factory Weather3.fromJson(Map<String, dynamic> json) {
    return Weather3(
      description3: json['description'],
    );
  }
}

class Wind3 {
  double speed3;

  Wind3({
    required this.speed3,
  });

  factory Wind3.fromJson(Map<String, dynamic> json) {
    return Wind3(
      speed3: json['speed'].toDouble(),
    );
  }
}



