import 'dart:ui';

import 'package:flutter/material.dart';

import '../models/daydetail.dart';
import '../utils/convertors.dart';


class DayCard extends StatelessWidget {

  final DayDetail day;
  const DayCard({Key? key, required this.day}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context)
          .size
          .width /
          5.5,
      child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.center,
          mainAxisAlignment:
          MainAxisAlignment
              .center,
          children: [
            Text(
              Convertors()
                  .getDay(day.title),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight:
                  FontWeight.bold),
            ),
            SizedBox(
              height: 5,
            ),

            Stack(
                children: [
                  Opacity(
                      child: Image.asset(
                        'assets/${Convertors().weatherIconUrl(day.icon)}.png',
                        color: Colors.black,
                        height: 50,
                        width: 50,
                      ),
                      opacity: 0.4
                  ),
                  ClipRect(
                      child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                          child: Image.asset(
                            'assets/${Convertors().weatherIconUrl(day.icon)}.png',
                            height: 50,
                            width: 50,)
                      )
                  )
                ]
            ),
            SizedBox(
              height: 2,
            ),
            Row(
              crossAxisAlignment:
              CrossAxisAlignment
                  .start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  Convertors()
                      .getCelsiusFromKelvin(
                      day.temp),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25),
                  textAlign: TextAlign.center,
                ),
                Text(
                  '°',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14),
                ),
              ],
            ),
            SizedBox(
              height: 2,
            ),
            Text(
              day.wind,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 12),
            ),
            Text(
              'km/h',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 12),
            )
          ]),
    );
  }
}
