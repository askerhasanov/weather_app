import 'package:flutter/material.dart';
import '../utils/globalvars.dart';

class AdditionCard extends StatelessWidget {
  final String title;
  final String detail;
  const AdditionCard({Key? key, required this.title, required this.detail}) : super(key: key);


  IconData getIcon(String title){
    if(title == 'humidity'){
      return Icons.water_drop_outlined;
    }
    if(title == 'wind'){
      return Icons.air;
    }
    if(title == 'feel'){
      return Icons.thermostat_outlined;
    }else{
      return Icons.error_outline;
    }
  }

  String getTitle(String title){
    if(title == 'feel'){
      return 'FEELS LIKE';
    }else{
      return title.toUpperCase();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Icon(
          getIcon(title),
          size: 40,
          color: Colors.white,
          shadows: shadow,
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          getTitle(title),
          style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              shadows: shadow,
              fontWeight: FontWeight.bold),
        ),
        Text(
          '${detail} ${title == 'humidity' ? '%' : title == 'wind' ? 'km/h': ''}',
          style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              shadows: shadow,
              fontWeight: FontWeight.bold),
        ),
      ]),
    );
  }
}
