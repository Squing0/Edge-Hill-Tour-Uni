// ignore_for_file: avoid_print, file_names

import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:edge_hill_tour/models/location_model.dart';

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

    if (jsonString.isEmpty) {
      print('JSON file is empty or null.');
    } 
  } 
  catch (error) {
    print('Error loading JSON file: $error');
  }
}
}