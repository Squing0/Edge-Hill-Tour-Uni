import 'package:flutter/material.dart';

void main() {
  runApp(
    // const Center(child: Text(
    //   "Hello, worl!",
    //   textDirection: TextDirection.ltr,
    // ),)
    const MyApp(),
  );
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    // return const MaterialApp(
    //   home: Center(
    //     child: Text(
    //       "Hello, world!",
    //       textDirection: TextDirection.ltr,
    //     ),
    //   ),
    // );
    const String appTitle = "Edge Hill Tour";
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
          backgroundColor: Colors.blue,
        ),
        body:  Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset("images/image1.jpg"),
            Image.asset("images/image2.jpg"),
            Image.asset("images/image3.jpg"),
          ],
        )
      ),
    );
  }
}