import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'dart:math' as math;
import 'package:url_launcher/url_launcher.dart';

class CompassPage extends StatefulWidget{
  const CompassPage({super.key, required this.fileName});

  final String fileName;

  @override
  State<CompassPage> createState() => _CompassPageState(fileName);
}

class _CompassPageState extends State<CompassPage> {
  String fileName2 = "";
  int currentIndex = 0;
  final double targetRadius = 100;
  Position? _currentPosition; 
  Stream<Position>? _positionStream; // Use Stream<Position> to continuously update location
  List<dynamic>? locations;
  double? heading = 0; 

   _CompassPageState(String fileName) {
    fileName2 = fileName;
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _positionStream = Geolocator.getPositionStream(); // Initialize the position stream
    loadLocations();

    FlutterCompass.events!.listen((event) {setState(() {  
      heading = event.heading;
    });
    });
  }

   void _getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      await Geolocator.requestPermission();
    }

    Position currentPosition = await Geolocator.getCurrentPosition();
    setState(() {
      _currentPosition = currentPosition;
    });
  }

    Future<void> loadLocations() async{
      List<dynamic> loadedLocations = await loadJsonFile();
    setState(() { locations = loadedLocations; 
    });
    }

      Future<List<dynamic>> loadJsonFile() async {
    String jsonString = await rootBundle.loadString("assets/$fileName2.json");
    return json.decode(jsonString);
  }

  void goToNextLocation(){
    setState((){
      if(currentIndex < locations!.length - 1){
        currentIndex++;
      }
    });
  }

  void goToPreviousLocation(){
    setState((){
      if(currentIndex > 0){
        currentIndex--;
      }
    });
  }

@override
  Widget build(BuildContext context) {
    const title = "Compass Page";
    return MaterialApp(
      title: title,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 81, 0, 255),
          brightness: Brightness.dark,
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Compass Page",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          backgroundColor: const Color.fromARGB(255, 220, 212, 98),
        ),
        body: Column(
          children: [
            if (locations != null)
              Expanded(
                child: ListView(
                  children: [
                    MainInfoSection(
                      name: locations![currentIndex]['name'] ?? '',
                      imageRef: locations![currentIndex]['imageRef'] ?? '',
                      description: locations![currentIndex]['description'] ?? '',
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: 
                      [Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: ElevatedButton(onPressed: () =>_launchUrl(locations![currentIndex]['url'] ?? ''), 
                        child: const Text("More Information", style: TextStyle(fontStyle: FontStyle.italic, color: Colors.white))),
                        )
                      ]
                    ),
                    StreamBuilder<Position>(
                      stream: _positionStream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return DistanceFromCurrentLocation(
                            currentPosition: snapshot.data!,
                            destinationLatitude: locations![currentIndex]['latitude'] != null
                                ? double.parse(locations![currentIndex]['latitude'].toString())
                                : 0.0,
                            destinationLongitude: locations![currentIndex]['longitude'] != null
                                ? double.parse(locations![currentIndex]['longitude'].toString())
                                : 0.0,
                          );
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          return const CircularProgressIndicator();
                        }
                      },
                    ),                           
                  ],
                ),
              ),
            if (locations == null)
              const Center(
                child: CircularProgressIndicator(),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: goToPreviousLocation,
                  child: const Text('Previous'),
                ),
                ElevatedButton(
                  onPressed: goToNextLocation,
                  child: const Text('Next'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _launchUrl(String url) async{
    final Uri urlFinal = Uri.parse(url);
    if(!await launchUrl(urlFinal)){
      throw Exception('Could not launch $url');
    }
  }

}

Future<Position> getCurrentLocation() async {
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    await Geolocator.requestPermission();
  }
  
  return await Geolocator.getCurrentPosition();
}

class DistanceFromCurrentLocation extends StatefulWidget {
  final Position currentPosition;
  final double destinationLatitude;
  final double destinationLongitude;

  const DistanceFromCurrentLocation({super.key, 
    required this.currentPosition,
    required this.destinationLatitude,
    required this.destinationLongitude,
  });

  @override
  _DistanceFromCurrentLocationState createState() =>
      _DistanceFromCurrentLocationState();
}

class _DistanceFromCurrentLocationState
    extends State<DistanceFromCurrentLocation> {
  double _heading = 0; // Compass heading from Flutter Compass

  @override
  void initState() {
    super.initState();
    _startListeningCompass();
  }

  void _startListeningCompass() {
    FlutterCompass.events!.listen((event) {
      setState(() {
        _heading = event.heading!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double distanceInMeters = Geolocator.distanceBetween(
      widget.currentPosition.latitude,
      widget.currentPosition.longitude,
      widget.destinationLatitude,
      widget.destinationLongitude,
    );

    double distanceInKm = distanceInMeters / 1000;

    double targetAngle = math.atan2(
          widget.destinationLongitude - widget.currentPosition.longitude,
          widget.destinationLatitude - widget.currentPosition.latitude,
        ) *
        (180 / math.pi);

    // Calculate the rotation angle for the compass needle
    double rotationAngle = targetAngle - (_heading ?? 0);

    //     if (rotationAngle > 180) { // Don't think this helped accuracy much even if is more smooth
    //   rotationAngle -= 360;
    // } else if (rotationAngle < -180) {
    //   rotationAngle += 360;
    // }

    rotationAngle *= -1;

    return Container(
      padding:
          const EdgeInsets.only(left: 10.0, top: 5, right: 10, bottom: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Distance from Current Location: ${distanceInMeters.toStringAsFixed(2)} meters',
            style: const TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
          ),
          const SizedBox(height: 15),
          Stack(
            alignment: Alignment.center,
            children: [
              Image.asset("images/cadrant.png", scale: 1),
              Transform.rotate(
                angle: ((rotationAngle) * (math.pi / 180) * -1),
                child: Image.asset("images/compass.png"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MainInfoSection extends StatelessWidget{
  const MainInfoSection({super.key, 
  required this.name, 
  required this.description, 
  required this.imageRef});

  final String name;
  final String description;
  final String imageRef;

  @override
  Widget build(BuildContext context){
    return SizedBox(
      height: 400,
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            AppBar(
              title: Text(name),
              backgroundColor: const Color.fromARGB(255, 95,41,95),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                  image: AssetImage("images/$imageRef"), 
                  fit: BoxFit.cover),
                  border: Border.all(color: const Color.fromARGB(255, 95,41,95), width: 10),
                  ) ,
                )        
            ),         
            TextSection(description: description),         
          ]
        )
      )
    );
  }
}

class TextSection extends StatelessWidget{
  const TextSection({
    super.key,
    required this.description,
  });

  final String description;

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(right: 15, left: 20),
      child: Text(
        description,
        softWrap: true,
        style: const TextStyle(fontSize: 20),
      )
    );
  }
}