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
    // debug1();
  }

  // debug1() {
  //   print(viewModel.locations[1].name);
  //   // TODO: implement debug1
  //   // throw UnimplementedError();
  // }

  @override
  Widget build(BuildContext context) {
      return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
        title: const Text('Location View'),
      ),
      body: Container(
        height: 200,
        width: 200,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: viewModel.locations.length,
          itemBuilder: (context, index) {
            final location = viewModel.locations[index];
            // return ListTile(
            //   title: const Text("location.name"),
            //   subtitle: Text(location.description),
            //   // Add more UI elements as needed
            // );
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
      // body: Column(
      //   children: [
      //     const Text("HI!")
      //   ]
      // )
      //   )
      // );
    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text('Location View'),
    //   ),
    //   body: ListView.builder(
    //     itemCount: viewModel.locations.length,
    //     itemBuilder: (context, index) {
    //       final location = viewModel.locations[index];
    //       return ListTile(
    //         title: Text(location.name),
    //         subtitle: Text(location.description),
    //         // Add more UI elements as needed
    //       );
    //     },
    //   ),
    // );
  }
}

void debug1(LocationViewModel lol){
  print(lol.locations[0].name);
}

class YourWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
        title: Text('Your App'),
      ),
      body: FutureBuilder(
        future: loadJsonFile(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            // Explicitly check for nullability before accessing snapshot.data
            List<dynamic>? locations = snapshot.data as List<dynamic>?;

            if (locations == null || locations.isEmpty) {
              return Center(
                child: Text('No data available'),
              );
            }

            return ListView.builder(
              itemCount: locations.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(locations[index]['imageRef'] ?? ''), // Adjust based on your data structure
                  // Add other widgets as needed
                );
              },
            );
          }
        },
      ),

      )
    );
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text('Your App'),
    //   ),
    //   body: FutureBuilder(
    //     future: loadJsonFile(),
    //     builder: (context, snapshot) {
    //       if (snapshot.connectionState == ConnectionState.waiting) {
    //         return CircularProgressIndicator();
    //       } else if (snapshot.hasError) {
    //         return Center(
    //           child: Text('Error: ${snapshot.error}'),
    //         );
    //       } else {
    //         // Explicitly check for nullability before accessing snapshot.data
    //         List<dynamic>? locations = snapshot.data as List<dynamic>?;

    //         if (locations == null || locations.isEmpty) {
    //           return Center(
    //             child: Text('No data available'),
    //           );
    //         }

    //         return ListView.builder(
    //           itemCount: locations.length,
    //           itemBuilder: (context, index) {
    //             return ListTile(
    //               title: Text(locations[index]['name'] ?? ''), // Adjust based on your data structure
    //               // Add other widgets as needed
    //             );
    //           },
    //         );
    //       }
    //     },
    //   ),
    // );
  }

  Future<List<dynamic>> loadJsonFile() async {
    String jsonString = await rootBundle.loadString('assets/locations.json');
    return json.decode(jsonString);
  }
}