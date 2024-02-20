import 'package:flutter/material.dart';

class HomePage extends StatelessWidget{
  const HomePage({super.key});

  @override
  Widget build(BuildContext context){
    const title = "HomePage";
    return  MaterialApp(
        title: title,
        theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 81, 0, 255),
          brightness: Brightness.dark,
          ),
    ),
    home: Scaffold(
      appBar: AppBar(
          title: const Text("Home Page"),
          backgroundColor: Color.fromARGB(255, 5, 142, 24),
        ),
    )
    );
  }
}