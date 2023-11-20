import 'package:flutter/material.dart';
import 'package:weather_app/customwidgets/locationcard.dart';
import 'package:weather_app/database/city_db.dart';
import 'package:weather_app/helpers/citysearchhelper.dart';
import 'package:weather_app/models/citydata.dart';
import 'package:weather_app/utils/globalvars.dart';

class SelectCityPage extends StatefulWidget {
  const SelectCityPage({super.key});

  @override
  State<SelectCityPage> createState() => _SelectCityPageState();
}

class _SelectCityPageState extends State<SelectCityPage> {

  TextEditingController searchController = TextEditingController();
  Future<List<CityData>>? futureCities;
  final cityDb = CityDB();
  List<CityData> suggestionsList = [];

  @override
  void initState() {
    // TODO: implement initState
    fetchCities();
  }

  void fetchCities(){
    setState(() {
      futureCities = cityDb.fetchAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    int? length;
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(gradient: mainGradient),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  /// top text line
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Saved Locations',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.search,
                            size: 40,
                            color: Colors.white,
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: FutureBuilder<List<CityData>>(
                      future: futureCities,
                      builder: (context, snapshot){
                        if(snapshot.connectionState != ConnectionState.done){
                          return Center(child: CircularProgressIndicator(),);
                        }else{
                          if(snapshot.hasError){
                            return Center(child: Text('Something went wrong ${snapshot.error}'),);
                          }else{
                            if(snapshot.data!.length ==0){
                              return Center(child: Text('You have not added any cities'),);
                            }else{
                              length = snapshot.data!.length;
                              return Column(
                                children: [
                                  Expanded(
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: snapshot.data!.length,
                                          itemBuilder: (context, index) {
                                            return LocationCard(city: snapshot.data![index]);
                                          })),
                                ],
                              );
                            }
                          }
                        }
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      List<CityData> cities = await CityDB().fetchAll();
                      var response = await showDialog(
                          context: context,
                          builder: (context){
                            return StatefulBuilder(
                              builder: (context, setState) {
                                return Dialog(
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 300,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                        gradient: mainGradient
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: 50,
                                            width: MediaQuery.of(context).size.width,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: Color(0xFFAAA5A5B2),
                                            ),
                                            child: TextField(
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: 'Search',
                                                contentPadding: EdgeInsets.only(
                                                  left: 20,
                                                  top: 10,
                                                  bottom: 10
                                                ),
                                                suffixIcon: Icon(Icons.search, size: 20, color: Colors.white,),
                                              ),
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold
                                              ),
                                              controller: searchController,
                                              onChanged: (text) async {
                                                if(text.length > 2){
                                                  List<CityData> resultList = await CitySearchHelper().getSearchedCities(text);
                                                  setState(() {
                                                    suggestionsList = resultList;
                                                  });
                                                }
                                                if(text.length ==0){
                                                  setState(() {
                                                    suggestionsList =[];
                                                  });
                                                }
                                              },
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 200,
                                          width: MediaQuery.of(context).size.width,
                                          child: ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: suggestionsList.length,
                                              itemBuilder: (context, index){
                                                CityData city = suggestionsList[index];
                                                return Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(10),
                                                      color: Color(0xFFAAA5A5B2),
                                                    ),
                                                    child: ListTile(
                                                      title:Text('${city.name}', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),),
                                                      subtitle: Text('${city.country}'),
                                                      onTap: (){
                                                        Navigator.pop(context, city);
                                                      },
                                                    ),
                                                  ),
                                                );
                                              }
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                      );
                      if(response != null){
                        int index = cities.indexWhere((element) => element.id == response.id);
                        if (index != -1) {
                          print('You have already added this city');
                        } else {
                          cityDb.create(city: response);
                          setState((){
                            futureCities = cityDb.fetchAll();
                          });
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFAAA5A5B2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_circle_outline,
                            color: Colors.white,
                            size: 30,
                            shadows: [
                              Shadow(
                                  color: Colors.black,
                                  offset: Offset(0, 0),
                                  blurRadius: 5
                              )
                            ],),
                          SizedBox(width: 10,),
                          Text('Add new',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                      color: Colors.black,
                                      offset: Offset(0, 0),
                                      blurRadius: 5
                                  )
                                ]
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
