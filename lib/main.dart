import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:edge_hill_tour/view/select_tour/select_tour.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

  runApp(
    const SelectTourPage()
  );
}

// Needed purely for testing (not actual app)
class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return const MaterialApp(
      title: "appTitle",
    );
  }
}