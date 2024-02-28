import 'package:flutter/material.dart';
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
      body: ListView.builder(
        itemCount: viewModel.locations.length,
        itemBuilder: (context, index) {
          final location = viewModel.locations[0];
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