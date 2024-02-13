import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyApp3 extends StatelessWidget{
  const MyApp3({super.key});

  @override
  Widget build(BuildContext context){
    const title = "Basic List";

    // return MaterialApp(
    //   title: title,
    //   home: Scaffold(
    //     appBar: AppBar(
    //       title: const Text(title),
    //     ),
    //     body: ListView(
    //       children: const <Widget>[
    //         ListTile(
    //           leading: Icon(Icons.map),
    //           title: Text("Map"),
    //         ),
    //         ListTile(
    //           leading: Icon(Icons.photo_album),
    //           title: Text("Album"),
    //         ),
    //         ListTile(
    //           leading: Icon(Icons.phone),
    //           title: Text("Phone"),
    //         ),
    //       ]
    //     )
    //   )
    // );

    // return MaterialApp(
    //   title: "Horizontal List",
    //   home: Scaffold(
    //     appBar: AppBar(
    //       title: const Text("Vertical List"),
    //     ),
    //     body: Container(
    //       margin: const EdgeInsets.symmetric(horizontal: 20),
    //       height: 400,
    //       child: ListView(
    //         scrollDirection: Axis.vertical,
    //         children: <Widget>[
    //           Container(
    //             height: 160,
    //             color: Colors.red,
    //           ),
    //           Container(
    //             height: 160,
    //             color: Colors.blue,
    //           ),
    //           Container(
    //             height: 160,
    //             color: Colors.green,
    //           ),
    //           Container(
    //             height: 160,
    //             color: Colors.yellow,
    //           ),
    //           Container(
    //             height: 160,
    //             color: Colors.orange,
    //           ),
    //         ]
    //       )
    //     )
    //   )
    // );

    // return MaterialApp(
    //   title: title,
    //   home: Scaffold(
    //     appBar: AppBar(
    //       title: const Text(title),
    //     ),
    //     body: GridView.count(
    //       crossAxisCount: 4,
    //       scrollDirection: Axis.horizontal,
    //       children: List.generate(20, (index) {
    //         return Center(
    //         child: Text(
    //           "Item $index",
    //           style: Theme.of(context).textTheme.headlineSmall,
    //         )
    //       );
    //       })
    //     )
    //   )
    // );

      return MaterialApp(
      title: title,
      theme: ThemeData(
        useMaterial3: true,
        
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.purple,
          brightness: Brightness.dark,
          ),
        textTheme: TextTheme(
        displayLarge: const TextStyle(
          fontSize: 72,
          fontWeight: FontWeight.w400,
        ),
        titleLarge: GoogleFonts.oswald(
          fontSize: 30,
          fontStyle: FontStyle.italic,
        ),
        bodyMedium: GoogleFonts.merriweather(),
        displaySmall: GoogleFonts.pacifico(),
      ),
      ),
      
      home: Scaffold(
        appBar: AppBar(
          title: const Text(title),
        ),
        body: OrientationBuilder(
          builder: ((context, orientation) {
            return GridView.count(crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
            children: List.generate(100, (index){
              return Center(
                child: Text(
                  "Item $index",
                  style: Theme.of(context).textTheme.displayLarge,
                )
              );
            }));
          }),
          )
      )
    );
  }
}