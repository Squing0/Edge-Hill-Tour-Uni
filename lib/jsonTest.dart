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
    viewModel.loadLocations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location View'),
      ),
      body: ListView.builder(
        itemCount: viewModel.locations.length,
        itemBuilder: (context, index) {
          final location = viewModel.locations[index];
          return ListTile(
            title: Text(location.name),
            subtitle: Text(location.description),
            // Add more UI elements as needed
          );
        },
      ),
    );
  }
}