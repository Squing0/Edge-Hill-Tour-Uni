import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:edge_hill_tour/models/locationModel.dart';

class LocationViewModel{
  List<Location> locations = [];

  Future<void> loadLocations() async{
    final String jsonContent = await rootBundle.loadString('locations.json');
    final List<dynamic> jsonList = json.decode(jsonContent);

    locations = jsonList.map((json) => Location.fromJson(json)).toList();

  }

  void loadJsonFile() async {
  try {
    String jsonString = await rootBundle.loadString('locations.json');

    if (jsonString.isNotEmpty) {
      List<dynamic> locations = json.decode(jsonString);

      // Use the 'locations' list as needed
    } else {
      print('JSON file is empty or null.');
    }
  } catch (error) {
    print('Error loading JSON file: $error');
  }
}

}