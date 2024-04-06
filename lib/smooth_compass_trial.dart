import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'dart:math' as math;
import 'package:geolocator/geolocator.dart';
import 'package:vector_math/vector_math.dart' as vector;
import 'package:permission_handler/permission_handler.dart';

class MyApp8 extends StatelessWidget{
  const MyApp8({super.key});

  @override
  build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen()
      );
  }
}

class HomeScreen extends StatefulWidget{
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

// class _HomeScreenState extends State<HomeScreen>{
//   // Setting compass
//   double? heading = 0;

//   @override
//   void initState(){
//     // implement initState
//     super.initState();
//     FlutterCompass.events!.listen((event) {setState(() {
//       heading = event.heading;
//     });
//     });
//   }

class _HomeScreenState extends State<HomeScreen> {
  double? heading = 0;
  double smoothHeading = 0;

  @override
  void initState() {
    super.initState();
    FlutterCompass.events!.listen((event) {
      setState(() {
        heading = event.heading;
        smoothHeading = _smoothHeading(event.heading);
      });
    });
  }

  double _smoothHeading(double? newHeading) {
    // Smoothing logic can be implemented here
    // For simplicity, a moving average over 3 readings is used
    smoothHeading = (smoothHeading * 2 + (newHeading ?? 0)) / 3;
    return smoothHeading;
  }

  // @override
  // Widget build(BuildContext context){
  //   return Scaffold(
  //     backgroundColor: Colors.black,
  //     appBar: AppBar(
  //       backgroundColor: Colors.grey.shade900,
  //       centerTitle: true,
  //       title: Text("Compass App", style: TextStyle(color: Colors.white)),
  //     ),
  //     body: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children:[
  //         Text("${heading!.ceil()}", 
  //         style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold)),
  //         SizedBox(height: 50,),
  //         //Showing compass
  //         Padding(padding: EdgeInsets.all(18),
  //         child: Stack(
  //           alignment: Alignment.center,
  //           children:[
  //             Image.asset("images/cadrant.png"),
  //             Transform.rotate(
  //               angle: ((heading ?? 0) * (math.pi / 180) * -1),
  //               child: Image.asset("images/compass.png", scale: 1.1)
  //               ),
  //           ]
  //         )
  //         )
  //       ]
  //     )

  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        centerTitle: true,
        title: Text("Compass App", style: TextStyle(color: Colors.white)),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("${smoothHeading.ceil()}",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold)),
            SizedBox(
              height: 50,
            ),
            //Showing compass
            Padding(
                padding: EdgeInsets.all(18),
                child: Stack(alignment: Alignment.center, children: [
                  Image.asset("images/cadrant.png"),
                  Transform.rotate(
                      angle: ((smoothHeading ?? 0) * (math.pi / 180) * -1),
                      child: Image.asset("images/compass.png", scale: 1.1)),
                ]))
          ]),
    );
  }
}

class CompassApp extends StatefulWidget {
  @override
  _CompassAppState createState() => _CompassAppState();
}

class _CompassAppState extends State<CompassApp> {
  double _targetLatitude = 53.5660091; // Example latitude
  double _targetLongitude = -2.8879666; // Example longitude
  double _currentLatitude = 53.56554293;
  double _currentLongitude = -2.8880910;
  double ?_bearing = 0.0;

   @override
  void initState(){
    // implement initState
    super.initState();
    FlutterCompass.events!.listen((event) {setState(() {
      _bearing = event.heading;
    });
    });
  }
  
  void _getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentLatitude = position.latitude;
      _currentLongitude = position.longitude;
    });
  }

  double _calculateBearing(
      double startLat, double startLng, double endLat, double endLng) {
    double dLng = vector.radians(endLng - startLng);
    double startLatRadians = vector.radians(startLat);
    double endLatRadians = vector.radians(endLat);

    double y = math.sin(dLng) * math.cos(endLatRadians);
    double x = math.cos(startLatRadians) * math.sin(endLatRadians) -
        math.sin(startLatRadians) * math.cos(endLatRadians) * math.cos(dLng);

    double bearing = math.atan2(y, x);
    return (vector.degrees(bearing) + 360) % 360;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Compass App'),
        ),
        body: Center(
          child: Transform.rotate(
            angle: ((_bearing ?? 0) * (math.pi / 180) * -1),
            child: Image.asset('images/compass.png'), // Your compass image
          ),
        ),
      ),
    );
  }
}

// FLUTTER COMPASS YOUTUBE

class MyApp13 extends StatefulWidget {
  const MyApp13({
    Key? key,
  }) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp13> {
  bool _hasPermissions = false;

  @override
  void initState() {
    super.initState();

    _fetchPermissionStatus();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.brown[600],
        body: Builder(
          builder: (context) {
            if (_hasPermissions) {
              return _buildCompass();
            } else {
              return _buildPermissionSheet();
            }
          },
        ),
      ),
    );
  }

  Widget _buildCompass() {
    return StreamBuilder<CompassEvent>(
      stream: FlutterCompass.events,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error reading heading: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        double? direction = snapshot.data!.heading;

        // if direction is null, then device does not support this sensor
        // show error message
        if (direction == null) {
          return const Center(
            child: Text("Device does not have sensors !"),
          );
        }

        return NeuCircle(
          child: Transform.rotate(
            angle: (direction * (math.pi / 180) * -1),
            child: Image.asset(
              'images/compass2.png',
              color: Colors.white,
              fit: BoxFit.fill,
            ),
          ),
        );
      },
    );
  }

  Widget _buildPermissionSheet() {
    return Center(
      child: ElevatedButton(
        child: const Text('Request Permissions'),
        onPressed: () {
          Permission.locationWhenInUse.request().then((ignored) {
            _fetchPermissionStatus();
          });
        },
      ),
    );
  }

  void _fetchPermissionStatus() {
    Permission.locationWhenInUse.status.then((status) {
      if (mounted) {
        setState(() => _hasPermissions = status == PermissionStatus.granted);
      }
    });
  }
}


class NeuCircle extends StatelessWidget {
  final child;
  const NeuCircle({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      alignment: Alignment.center,
      margin: EdgeInsets.all(40),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.brown[600],
        boxShadow: [
          BoxShadow(
              color: Colors.brown.shade800,
              offset: Offset(4.0, 4.0),
              blurRadius: 15.0,
              spreadRadius: 1.0),
          BoxShadow(
              color: Colors.brown.shade500,
              offset: Offset(-4.0, -4.0),
              blurRadius: 15.0,
              spreadRadius: 1.0),
        ],
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.brown.shade500,
            Colors.brown.shade600,
            Colors.brown.shade700,
            Colors.brown.shade800,
          ],
          stops: [0.1, 0.3, 0.8, 1],
        ),
      ),
      child: child,
    );
  }
}