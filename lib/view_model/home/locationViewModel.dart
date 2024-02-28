import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:edge_hill_tour/models/locationModel.dart';

class LocationViewModel{
  List<Location> locations = [];

  Future<void> loadLocations() async{
    final String jsonContent = await rootBundle.loadString("jsonData/locations.json");
    final List<dynamic> jsonList = json.decode(jsonContent);

    locations = jsonList.map((json) => Location.fromJson(json)).toList();

  }
}