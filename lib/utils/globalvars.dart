import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/models/citydata.dart';

CityData? selectedCity;

CityData? addedCity;


LinearGradient mainGradient =LinearGradient(
      begin: Alignment(-0.84, 1.0),
      end: Alignment(0.84, -1.0),
      colors: [
        Color(0xFF391A49),
        Color(0xFF301D5C),
        Color(0xFF262171),
        Color(0xFF301D5C),
        Color(0xFF391A49),
      ],
      stops: [0.1121, 0.3242, 0.5592, 0.6939, 0.8957],
    );


List<Shadow> shadow = [
  Shadow(
    color: Colors.black,
    offset: Offset(1,1),
    blurRadius: 10,
  )
];