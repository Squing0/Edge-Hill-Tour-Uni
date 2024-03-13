import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:edge_hill_tour/view_model/home/locationViewModel.dart';

class LocationView extends StatefulWidget {
  const LocationView({super.key});

  @override
  _LocationViewState createState() => _LocationViewState();
}

class _LocationViewState extends State<LocationView> {
  final LocationViewModel viewModel = LocationViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.loadJsonFile();
  }

  @override
  Widget build(BuildContext context) {
      return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
        title: const Text('Location View'),
      ),
      body: SizedBox(
        height: 200,
        width: 200,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: viewModel.locations.length,
          itemBuilder: (context, index) {
            final location = viewModel.locations[index];
            return  Column(
              children: [
                Text(location.description)
              ]
            );
          },
        ),
      )
      )
      );
  }
}

void debug1(LocationViewModel lol){
  print(lol.locations[0].name);
}

class YourWidget extends StatelessWidget {
  const YourWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
        title: const Text('Your App'),
      ),
      body: FutureBuilder(
        future: loadJsonFile(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            // Explicitly check for nullability before accessing snapshot.data
            List<dynamic>? locations = snapshot.data;

            if (locations == null || locations.isEmpty) {
              return const Center(
                child: Text('No data available'),
              );
            }
            return Builder(
              builder: (BuildContext context) {
            return ListView.builder(
              itemCount: locations.length,
              itemBuilder: (context, index) {
                return Center(
              // child: Text(locations[index]['imageRef'] ?? ''),
              child: Column(children: [
                Text(locations[index]['imageRef'] ?? ''),
                Text(locations[index]['description'] ?? ''),
                Text(locations[index]['latitude'].toString() ?? ''),
                Text(locations[index]['longitude'].toString() ?? ''),
                Text(locations[index]['name'] ?? ''),
                Text("")
              ],)
        );
      },
    );
  },
);
          }
        },
      ),

      )
    );
  }

  Future<List<dynamic>> loadJsonFile() async {
    String jsonString = await rootBundle.loadString('assets/locations.json');
    return json.decode(jsonString);
  }
}