import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

Position? _position;

class MyApp5 extends StatelessWidget{
  const MyApp5({super.key});

  @override
  build(BuildContext context) {
    return MaterialApp(home: Scaffold(body: MyHomePage()),);
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Position? _position;

  @override
  void initState() {
    super.initState();
    _getCurrentPosition();
  }

  _getCurrentPosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _position = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Geolocation Demo'),
      ),
      body: Center(
        child: _position == null
            ? const CircularProgressIndicator()
            : Text('Latitude: ${_position!.latitude}, Longitude: ${_position!.longitude}'),
      ),
    );
  }
}

class MyApp10 extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp10> {
  late Position _currentPosition;
  late double _distanceInMeters;

  final double targetLatitude = 53.566088;
  final double targetLongitude = -2.888123; // Example target longitude

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  _getCurrentLocation() async {
    await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        _distanceInMeters = Geolocator.distanceBetween(
            _currentPosition.latitude,
            _currentPosition.longitude,
            targetLatitude,
            targetLongitude);
      });
    }).catchError((e) {
      print(e);
    });

    const LocationSettings locationSettings = LocationSettings(
  accuracy: LocationAccuracy.best,
  distanceFilter: 6,
);

    // Continuously update the location and distance
    Geolocator.getPositionStream(locationSettings: locationSettings).listen((Position position) {
      setState(() {
        _currentPosition = position;
        _distanceInMeters = Geolocator.distanceBetween(
            _currentPosition.latitude,
            _currentPosition.longitude,
            targetLatitude,
            targetLongitude);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Distance Calculator'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _currentPosition != null
                  ? Text(
                      'Current Location: ${_currentPosition.latitude}, ${_currentPosition.longitude}')
                  : const CircularProgressIndicator(),
              const SizedBox(height: 20),
              _currentPosition != null
                  ? Text(
                      'Distance to Target: ${_distanceInMeters?.toStringAsFixed(2) ?? "Calculating..."} meters')
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}

// Site example (asks user if they want to allow location):

Future<Position> _determinePosition() async {
  // Check if location services are enabled
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled return an error message
    return Future.error('Location services are disabled.');
  }

  // Check location permissions
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
      'Location permissions are permanently denied, we cannot request permissions.');
  }

  // If permissions are granted, return the current location
  return await Geolocator.getCurrentPosition();
}

class MyApp11 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FutureBuilder(
          future: _determinePosition(),
          builder: (BuildContext context, AsyncSnapshot<Position> snapshot) {
            if (snapshot.hasData) {
              return Center(
                child: Text(
                    'Your current location:\\\\nLatitude: ${snapshot.data!.latitude}, Longitude: ${snapshot.data!.longitude}'),
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            // The connection state is still ongoing
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

void getLocationUpdates() {
  final locationSettings = LocationSettings(accuracy: LocationAccuracy.high, distanceFilter: 100);
  StreamSubscription<Position> positionStream = Geolocator.getPositionStream(locationSettings: locationSettings).listen(
    (Position position) {
        print(position == null ? 'Unknown' : '${position.latitude}, ${position.longitude}');
    }
  );
}

// Chatgpt something occurs when radius entered

class LocationAwareWidget extends StatefulWidget {
  @override
  _LocationAwareWidgetState createState() => _LocationAwareWidgetState();
}

class _LocationAwareWidgetState extends State<LocationAwareWidget> {
  final double targetLatitude = 53.565462; // Example target latitude
  final double targetLongitude = -2.888090; // Example target longitude
  final double targetRadius = 6; // Example target radius in meters

  late Position _currentPosition;
  bool _isWithinRadius = false;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  _getCurrentLocation() async {
    await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });

      _checkDistance();
    }).catchError((e) {
      print(e);
    });

    // Continuously update the location
    Geolocator.getPositionStream().listen((Position position) {
      setState(() {
        _currentPosition = position;
        _checkDistance();
      });
    });
  }

  _checkDistance() {
    if (_currentPosition != null) {
      double distanceInMeters = Geolocator.distanceBetween(
          _currentPosition.latitude,
          _currentPosition.longitude,
          targetLatitude,
          targetLongitude);

      setState(() {
        _isWithinRadius = distanceInMeters <= targetRadius;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location Aware App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _currentPosition != null
                ? Text(
                    'Current Location: ${_currentPosition.latitude}, ${_currentPosition.longitude}')
                : CircularProgressIndicator(),
            SizedBox(height: 20),
            _isWithinRadius
                ? Text(
                    'You are within the specified radius!',
                    style: TextStyle(color: Colors.green, fontSize: 20),
                  )
                : Text(
                    'You are outside the specified radius.',
                    style: TextStyle(color: Colors.red, fontSize: 20),
                  ),
          ],
        ),
      ),
    );
  }
}