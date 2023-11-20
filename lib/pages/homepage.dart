import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:weather_app/customwidgets/additioncard.dart';
import 'package:weather_app/customwidgets/daycard.dart';
import 'package:weather_app/helpers/weatherhelper.dart';
import 'package:weather_app/models/cityweather.dart';
import 'package:weather_app/models/daydetail.dart';
import 'package:weather_app/pages/selectcitypage.dart';
import 'package:weather_app/utils/globalvars.dart';
import '../utils/convertors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

Future<CityWeather?>? detail;

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    detail = WeatherHelper().getWeatherData(selectedCity);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueAccent,
        body: FutureBuilder<CityWeather?>(
          future: detail,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return Container(decoration: BoxDecoration(gradient: mainGradient),child: Center(child: CircularProgressIndicator(color: Colors.white, strokeWidth: 5,)));
            } else {
              if (snapshot.hasError) {
                return Container(
                  child: Center(
                    child: Text('Something went wrong', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                  ),
                );
              } else {
                if (snapshot.data == null) {
                  return Stack(
                    children: [
                      //background image
                      Container(
                        height: Convertors().getHeight(context),
                        width: Convertors().getWidth(context),
                        decoration: BoxDecoration(gradient: mainGradient),
                      ),
                      //content to show
                      SafeArea(
                        child: Container(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Column(
                              children: [
                                SizedBox(height: 20,),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.place,
                                            size: 30,
                                            color: Colors.white,
                                            shadows: [
                                              Shadow(
                                                  color: Colors.black,
                                                  offset: Offset(0, 0),
                                                  blurRadius: 10)
                                            ],
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          TextButton(
                                            onPressed: () async {
                                              var response = Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          SelectCityPage()));
                                              if (await response ==
                                              'selectedCity') {
                                                setState(() {
                                                  detail = WeatherHelper()
                                                      .getWeatherData(
                                                      selectedCity!);
                                                });
                                              }
                                            },
                                            child: Text(
                                              'Select City',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                        onPressed: () async {
                                          var response = Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SelectCityPage()));
                                          if (await response ==
                                              'selectedCity') {
                                            setState(() {
                                              detail = WeatherHelper()
                                                  .getWeatherData(
                                                      selectedCity!);
                                            });
                                          }
                                        },
                                        icon: const Icon(
                                          Icons.menu,
                                          size: 30,
                                          color: Colors.white,
                                        ))
                                  ],
                                ),
                                Expanded(
                                    child: Center(
                                  child: Text('Please select a city', style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold,)),
                                ))
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                } else {
                  return Stack(
                    children: [
                      //background image
                      Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: Image.network(
                            '${snapshot.data!.backgroundImage}',
                            fit: BoxFit.cover,
                          ),
                        decoration: BoxDecoration(
                            gradient: mainGradient),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.black38,
                      ),
                      //content to show
                      SafeArea(
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Column(
                              children: [
                                SizedBox(height: 20,),
                                //header part
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.place,
                                            size: 30,
                                            color: Colors.white,
                                            shadows: [
                                              Shadow(
                                                  color: Colors.black,
                                                  offset: Offset(0, 0),
                                                  blurRadius: 10)
                                            ],
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Expanded(
                                            child: Text(
                                              '${snapshot.data!.city.name}, ${snapshot.data!.city.country}',
                                              overflow: TextOverflow.clip,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                        onPressed: () async {
                                          var response = Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SelectCityPage()));
                                          if (await response ==
                                              'selectedCity') {
                                            setState(() {
                                              detail = WeatherHelper()
                                                  .getWeatherData(
                                                      selectedCity!);
                                            });
                                          }
                                        },
                                        icon: const Icon(
                                          Icons.menu,
                                          size: 30,
                                          color: Colors.white,
                                        ))
                                  ],
                                ),
                                //mid part
                                Expanded(
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              '${Convertors().getMonth()}',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 40),
                                            ),
                                            Text(
                                              'updated as of ${'${Convertors().getDate()}'}',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Image.asset(
                                              'assets/${Convertors().weatherIconUrl(snapshot.data!.current.icon)}.png',
                                              height: 100,
                                              width: 100,
                                            ),
                                            Text(
                                              '${snapshot.data!.current.condition}',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 50,
                                                  shadows: [
                                                    Shadow(
                                                      color: Colors.black,
                                                      offset: Offset(1, 1),
                                                      blurRadius: 10,
                                                    )
                                                  ],
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  Convertors()
                                                      .getCelsiusFromKelvin(
                                                          snapshot.data!.current
                                                              .temp),
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 90,
                                                      shadows:shadow,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  '°C',
                                                  style: TextStyle(
                                                      fontSize: 30,
                                                      shadows: shadow,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFeatures: [
                                                        FontFeature
                                                            .superscripts()
                                                      ]),
                                                )
                                              ],
                                            )
                                          ],
                                        )
                                      ]),
                                ),
                                // bottom weather details
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    AdditionCard(title: 'humidity', detail: snapshot.data!.current.humidity),
                                    AdditionCard(title: 'wind', detail: snapshot.data!.current.wind),
                                    AdditionCard(title: 'feel', detail: Convertors().getCelsiusFromKelvin(snapshot.data!.current.feelLike)),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                //day cards
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Color(0xFF535353).withOpacity(0.6),
                                  ),
                                  height: 160,
                                  width: double.maxFinite,
                                  child: ListView.builder(
                                      itemCount: 4,
                                      shrinkWrap: true,
                                      itemExtent: (MediaQuery.of(context).size.width-30)/4,
                                      scrollDirection: Axis.horizontal,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        DayDetail day =
                                            snapshot.data!.days[index];
                                        return DayCard(day: day);
                                      }),
                                ),
                                SizedBox(height: 20,),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                }
              }
            }
          },
        ));
  }
}
