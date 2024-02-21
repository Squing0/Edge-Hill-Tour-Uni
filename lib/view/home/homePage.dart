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
      // appBar: AppBar(
      //     title: const Text("Home Page"),
      //     backgroundColor: Color.fromARGB(255, 5, 142, 24),
      //   ),
        body: Container(
          height: 450,
          alignment: Alignment.center,
          child: Column(children: [const Text("Edge Hill Tour", 
          style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.w700)),
          Spacer(),
          const ElevatedButton(            
              onPressed: null,
              child: const Text(
                "Select Tour", 
                style: TextStyle(fontSize: 45, color: Colors.white),
                ),
            ),]) ,
          )

    )
    );
  }
}