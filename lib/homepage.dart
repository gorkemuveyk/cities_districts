import 'dart:convert';

import 'package:cities_districts/cities.dart';
import 'package:cities_districts/districts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Cities> cities = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      parseJson();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cities and Districts"),
      ),
      body: ListView.builder(
          itemCount: cities.length, itemBuilder: _listBuildter),
    );
  }

  Widget _listBuildter(BuildContext context, int index) {
    return Card(
      child: ExpansionTile(
        title: Text(cities[index].name),
        leading: const Icon(Icons.location_city),
        trailing: Text(cities[index].provinceCode),
        children: cities[index].districts.map((district) {
          return ListTile(
            title: Text(district.name),
          );
        }).toList(),
      ),
    );
  }

  void parseJson() async {
    String jsonString =
        await rootBundle.loadString("assets/cities_districts.json");
    Map<String, dynamic> citiesMap = json.decode(jsonString);

    for (String code in citiesMap.keys) {
      Map<String, dynamic> cityMap = citiesMap[code];
      String cityName = cityMap["name"];
      Map<String, dynamic> districts = cityMap["districts"];

      List<Districts> allDistricts = [];

      for (String districtCode in districts.keys) {
        Map<String, dynamic> districtMap = districts[districtCode];
        String districtName = districtMap["name"];
        Districts district = Districts(name: districtName);

        allDistricts.add(district);
      }

      Cities city =
          Cities(name: cityName, provinceCode: code, districts: allDistricts);
      cities.add(city);
    }

    setState(() {});
  }
}
