import 'package:edge_hill_tour/view/compass/compass.dart';
import 'package:edge_hill_tour/view/home/homePage.dart';
import 'package:edge_hill_tour/view/select_tour/selectTour.dart';
import 'package:edge_hill_tour/navigationTrial.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

  runApp(
    // const Center(child: Text(
    //   "Hello, worl!",
    //   textDirection: TextDirection.ltr,
    // ),)   
    const HomePage(),
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

    final testColumn = Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Image.asset("images/image1.jpg"),
            ),
            Expanded(
              child: Image.asset("images/image2.jpg"),
            ),
            Expanded(
              child: Image.asset("images/image3.jpg"),
            ),
          ],
        );

        final greenStar = Icon(Icons.star, color: Colors.green[500]);
        const blackStar = Icon(Icons.star, color: Colors.black);

        final stars = Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            greenStar,
            greenStar,
            greenStar,
            blackStar,
            blackStar,
          ],
        );

        final ratings = Container(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:[
              stars,
              const Text(
                "170 Reviews",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Roboto",
                  letterSpacing: 0.5,
                  fontSize: 20,
                ),
              ),
            ]
          )

        );

        const descTextStyle = TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w800,
        fontFamily: 'Roboto',
        letterSpacing: 0.5,
        fontSize: 18,
        height: 2,
      );

      final iconList = DefaultTextStyle.merge(
        style: descTextStyle,
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:[
              Column(
                children:[
                  Icon(Icons.kitchen, color: Colors.green[500]),
                  const Text("PREP:"),
                  const Text("25 min"),
                ]
              ),
              Column(
                children:[
                  Icon(Icons.kitchen, color: Colors.green[500]),
                  const Text("COOK:"),
                  const Text("1hr"),
                ]
              ),
              Column(
                children:[
                  Icon(Icons.kitchen, color: Colors.green[500]),
                  const Text("FEEDS:"),
                  const Text("4-6"),
                ]
              ),
            ]
          )
        )
      );

      // final leftColumn = Container(
      //   padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
      //   child: Column(
      //     children: [

      //     ]
      //   )
      // );

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
          backgroundColor: Colors.blue,
        ),
        body:  
        Center(
          child: Column(
            children:[
              ratings,
              iconList
            ]
          )
        )
        
      ),
    );
  }
}