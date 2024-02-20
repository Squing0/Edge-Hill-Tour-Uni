import 'package:flutter/material.dart';

class SelectTourPage extends StatelessWidget{
  const SelectTourPage({super.key});

  @override
  Widget build(BuildContext context){
    const title = "Tour Selection";

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
          title: const Text("Tour Selection"),
          backgroundColor: const Color.fromARGB(255, 5, 142, 24),
        ),
        body: 
        // Center(
        //   child: Column(
        //     children:
        //     ListView(
        //       children: <Widget>[
        //         Container(
                  
        //         )
        //       ]
        //     ),
        //   ),
        //   )
        ListView(
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          children: <Widget>[
            ListContainer(),
            ListContainer(),
            ListContainer(),
            ListContainer()
          ]
        )
    )
    );
  }

  Container ListContainer() {
    return Container(
            height: 50,
            color: Colors.amber[500],
            child: const Row
            (
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
              children: <Widget>[
                Text("Item1"),
                Spacer(), // Works but doesn't feel right
                Text("Item2"),
              ],
            ),
          );
  }
}