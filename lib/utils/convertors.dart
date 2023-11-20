import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class Convertors{

  String getDay(String epoch){
    List<String> days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    int  e = int.parse(epoch);
    DateTime date = DateTime.fromMillisecondsSinceEpoch(e*1000);
    String formattedDay = days[date.weekday -1];
    String formattedDate = '${date.day}';
    return '$formattedDay $formattedDate';
  }

  String getMonth(){
    DateTime now = DateTime.now();
    String formattedDate = DateFormat(DateFormat.MONTH_DAY).format(now);
    return formattedDate;
  }

  String getDate(){
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd/MM/yyyy kk:mm aa').format(now);
    return formattedDate;
  }

  String getCelsiusFromKelvin(String tempInKelvin){
    double temp = double.parse(tempInKelvin);
    return (temp - 273.15).toStringAsFixed(0);
  }

  double getWidth(BuildContext context){
    return MediaQuery.of(context).size.width;
  }
  double getHeight(BuildContext context){
    return MediaQuery.of(context).size.height;
  }


  String weatherIconUrl(String code){
    if(code == '01d'){
      return 'clearskyD';
    }
    if(code == '01n'){
      return 'clearskyN';
    }
    if(code == '02d'){
      return 'fewcloudsD';
    }
    if(code == '02n'){
      return 'fewcloudsN';
    }
    if(code == '03d' || code == '03n'){
      return 'scatteredclouds';
    }
    if(code == '04d' || code == '04n'){
      return 'brokenclouds';
    }
    if(code == '09d' || code == '09n'){
      return 'showerrain';
    }
    if(code == '10d'){
      return 'rainD';
    }if(code == '10n'){
      return 'rainN';
    }if(code == '11d' || code == '11n'){
      return 'thunderstorm';
    }if(code == '13d' || code == '13n'){
      return 'snow';
    }if(code == '50d' || code == '50n'){
      return 'mist';
    }else{
      return 'notfound';
    }
  }

}