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
        title: Text('Geolocation Demo'),
      ),
      body: Center(
        child: _position == null
            ? CircularProgressIndicator()
            : Text('Latitude: ${_position!.latitude}, Longitude: ${_position!.longitude}'),
      ),
    );
  }
}

class MyApp6 extends StatelessWidget {
  const MyApp6({super.key});
 
  @override
  Widget build(BuildContext context) {
	
return MaterialApp( 
 
  
home: GeolocationApp(),
	
);  }
}
class GeolocationApp extends StatefulWidget {
  const GeolocationApp({super.key});
  @override
  State<GeolocationApp> createState() => _GeolocationAppState();
}
class _GeolocationAppState extends State<GeolocationApp> {
  Position? _currentLocation;
  late bool servicePermission = false;
  late LocationPermission permission;
  Future<Position> _getCurrentLocation() async {
	
servicePermission = await Geolocator.isLocationServiceEnabled();
	
if (!servicePermission) {  
print("Service Disabled");
	
}
	
permission = await Geolocator.checkPermission();
	
if (permission == LocationPermission.denied) {  
permission = await Geolocator.requestPermission();
	
}
	
return await Geolocator.getCurrentPosition();  }
  @override
  Widget build(BuildContext context) {
	
return Scaffold(  
appBar: AppBar(
    
title: Text("Get Your Location"),
    
centerTitle: true,
  
),
  
body: Center(
      
child: Column(
        
mainAxisAlignment: MainAxisAlignment.center,
        
crossAxisAlignment: CrossAxisAlignment.center,
        
children: [
          
Text(
            
"Location Coordinates",
            
style: TextStyle(
              
fontSize: 24,
              
fontWeight: FontWeight.bold,
            
),
          
),
          
SizedBox(
            
height: 6,
          
),
          
Text(
              
// "${_currentLocation}"
              
"Latitude = ${_currentLocation?.latitude} ; Longitude = ${_currentLocation?.longitude}"
              
),
          
SizedBox(
            
height: 30.0,
          
),
          
ElevatedButton(onPressed: () async {
            
_currentLocation= await _getCurrentLocation();
            
/// Determine the current position of the device.
            
///
            
/// When the location services are not enabled or permissions
            
/// are denied the `Future` will return an error.
          
}, child: Text('get location'))
        
],
      
)),
	
);  }
}

Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
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

  return await Geolocator.getCurrentPosition();
}