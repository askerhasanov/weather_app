import 'package:flutter/material.dart';
import 'package:weather_app/helpers/weatherhelper.dart';
import 'package:weather_app/models/citydata.dart';
import 'package:weather_app/models/cityweather.dart';
import 'package:weather_app/utils/convertors.dart';

import '../utils/globalvars.dart';


class LocationCard extends StatefulWidget {

  final CityData city;
  const LocationCard({Key? key, required this.city}) : super(key: key);

  @override
  State<LocationCard> createState() => _LocationCardState();
}

class _LocationCardState extends State<LocationCard> {

  Future<CityWeather?>? weather;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getWeather();
  }

  getWeather() {
    weather = WeatherHelper().getWeatherData(widget.city);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        setState(() {
          selectedCity = widget.city;
        });
        Navigator.pop(context, 'selectedCity');
      },
      child: Semantics(
        button: true,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFFAAA5A5B2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
              child: FutureBuilder<CityWeather?>(
                future: weather!,
                builder: (context, snapshot){
                  if(snapshot.connectionState != ConnectionState.done){
                    return Center(child: CircularProgressIndicator(),);
                  }else{
                    if(snapshot.hasError){
                      return Center(child: Text('Something went wrong ${snapshot.error}'),);
                    }else{
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ///leftside
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        snapshot.data!.city.name,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25,
                                            shadows: [
                                              Shadow(
                                                  color: Colors.black,
                                                  offset: Offset(0,0),
                                                  blurRadius: 5
                                              )
                                            ]
                                        ),
                                      ),
                                      Text(
                                        snapshot.data!.current.condition,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            shadows: [
                                              Shadow(
                                                  color: Colors.black,
                                                  offset: Offset(0,0),
                                                  blurRadius: 5
                                              )
                                            ]
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            'HUMIDITY',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14,
                                                shadows: [
                                                  Shadow(
                                                      color: Colors.black,
                                                      offset: Offset(0,0),
                                                      blurRadius: 5
                                                  )
                                                ]
                                            ),
                                          ),
                                          SizedBox(width: 10,),
                                          Text(
                                            '${snapshot.data!.current.humidity}%',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                                shadows: [
                                                  Shadow(
                                                      color: Colors.black,
                                                      offset: Offset(0,0),
                                                      blurRadius: 5
                                                  )
                                                ]
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'WIND',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14,
                                                shadows: [
                                                  Shadow(
                                                      color: Colors.black,
                                                      offset: Offset(0,0),
                                                      blurRadius: 5
                                                  )
                                                ]
                                            ),
                                          ),
                                          SizedBox(width: 10,),
                                          Text(
                                            '${snapshot.data!.current.wind} km/h',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                                shadows: [
                                                  Shadow(
                                                      color: Colors.black,
                                                      offset: Offset(0,0),
                                                      blurRadius: 5
                                                  )
                                                ]
                                            ),
                                          ),
                                        ],
                                      )

                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          ///rightside
                          Expanded(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children:[
                                  Image.asset('assets/${Convertors().weatherIconUrl(snapshot.data!.current.icon)}.png', height: 70,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('${Convertors().getCelsiusFromKelvin(snapshot.data!.current.temp)}',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 50,
                                            shadows: [
                                              Shadow(
                                                  color: Colors.black,
                                                  offset: Offset(0,0),
                                                  blurRadius: 5
                                              )
                                            ]
                                        ), ),
                                      Text('°c',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            shadows: [
                                              Shadow(
                                                  color: Colors.black,
                                                  offset: Offset(0,0),
                                                  blurRadius: 5
                                              )
                                            ]
                                        ), )
                                    ],
                                  )
                                ]
                            ),
                          ),
                        ],
                      );
                    }
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
