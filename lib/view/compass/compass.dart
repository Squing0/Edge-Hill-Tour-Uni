import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:geolocator/geolocator.dart';

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

   _CompassPageState(String fileName) {
    fileName2 = fileName;
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

// GPT CODE FOR CHANGING STATE WITH RADIUS
  _checkDistance(Position currentPosition) {
    List<dynamic> locations = []; // Load locations from JSON file
    Map<String, dynamic> currentLocation = locations[currentIndex + 1];

    double targetLatitude = currentLocation['latitude']; // Get latitude of current location
    double targetLongitude = currentLocation['longitude']; // Get longitude of current location

    double distanceInMeters = Geolocator.distanceBetween(
      currentPosition.latitude,
      currentPosition.longitude,
      targetLatitude,
      targetLongitude,
    );

    if (distanceInMeters <= targetRadius) {
      // User is within the specified radius
      setState(() {
        currentIndex++; // Increase index by 1
      });
    }
  } 



  _getCurrentLocation() async {
    await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    ).then((Position position) {
      setState(() {
        _currentPosition = position;
        _checkDistance(_currentPosition!); // Call _checkDistance here
      });
    }).catchError((e) {
      print(e);
    });
  }

      Future<List<dynamic>> loadJsonFile() async {
    String jsonString = await rootBundle.loadString("assets/$fileName2.json");
    return json.decode(jsonString);
  }

  @override
  Widget build(BuildContext context){
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
        // resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text("Compass Page"),
          backgroundColor: const Color.fromARGB(255, 5, 142, 24),
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
          }
          else{
            List<dynamic>? locations = snapshot.data;

            if (locations == null || locations.isEmpty) {
              return const Center(
                child: Text('No data available'),
              );
            }

            Map<String, dynamic> locationAtIndex = locations[currentIndex];
            
            return Column(
              children:[
                Expanded(
                  child: ListView.builder(
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return Center(
                          child: SingleChildScrollView(
                            child: SizedBox(
                              height: 900,
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  const CompassSection(),
                                  MainInfoSection(name: locationAtIndex['name'] ?? '', imageRef: locationAtIndex['imageRef'] ?? '', description: locationAtIndex['description'] ?? ''),
                                ]
                              )
                            )
                            )
                        );
                      },
                    ),

                )
              ]
            );



          }

          }
  
        )
      )
      
    );

  }










  
}


class ImageSection extends StatelessWidget{
  const ImageSection({super.key, required this.image, required this.height});

  final String image;
  final double height;

  @override
  Widget build(BuildContext context){
    return Image.asset(
      image,
      // width: 612,
      height: height,
      fit: BoxFit.cover,
    );
  }
}

class CompassSection extends StatelessWidget{
  const CompassSection({super.key});

  @override
  Widget build(BuildContext context){
    return  Stack(
      children: <Widget>[
        Image.asset("images/campusBirdsEye.jpg", fit: BoxFit.contain),
      ]
    );
  }
}

class MainInfoSection extends StatelessWidget{
  MainInfoSection({super.key, 
  required this.name, 
  required this.description, 
  required this.imageRef});

  final String name;
  final String description;
  final String imageRef;

  final player = AudioPlayer();

  @override
  Widget build(BuildContext context){
    return SizedBox(
      height: 250,
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            AppBar(
              title: Text(name),
              backgroundColor: const Color.fromARGB(255, 206, 8, 255),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:[
                SizedBox(
                  height: 200,
                child: Image.asset("images/$imageRef", fit: BoxFit.contain),
                ),           
              ]
              
            ),
            Padding(
              padding:    const EdgeInsets.only(top: 19),
              child: IconButton(
                icon: const Icon(Icons.audio_file),
                color: Colors.green,
                onPressed: (){
                  player.play(UrlSource("assets/trial.mp3"));
                },
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
      padding: const EdgeInsets.all(24),
      child: Text(
        description,
        softWrap: true,
        style: const TextStyle(fontSize: 20),
      )
    );

  }
}