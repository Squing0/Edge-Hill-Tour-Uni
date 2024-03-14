import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/services.dart';
import 'package:edge_hill_tour/view_model/home/locationViewModel.dart';

class CompassPage extends StatefulWidget{
  const CompassPage({super.key, required this.fileName});

  final String fileName;

  @override
  State<CompassPage> createState() => _CompassPageState(fileName);
}



class _CompassPageState extends State<CompassPage> {
  String fileName2 = "";

   _CompassPageState(String fileName) {
    fileName2 = fileName;
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

            Map<String, dynamic> locationAtIndex = locations[3];
            
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
                                  CompassSection(),
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

  Future<List<dynamic>> loadJsonFile() async {
    String jsonString = await rootBundle.loadString("assets/" + fileName2 + ".json");
    return json.decode(jsonString);
  }
}


            // return Center(
            //   child:SingleChildScrollView(
            //   child: 
            //   SizedBox(
            //     height: 900,
            //     child: Column(
            //     // mainAxisSize: MainAxisSize.max,
            //     children:[
            //        const CompassSection(),                
            //        const MainInfoSection(),  
            //                    ElevatedButton(            
            //       onPressed: () =>  Navigator.pop(context),
            //       child: const Text(
            //         "Back to tour selection", 
            //         style: TextStyle(fontSize: 20, color: Colors.white),
            //         ),
            //     ),
            //     ]
            //   ),
            //   )
            //   )
            //   );

class CompassPageMain extends StatelessWidget{
    const CompassPageMain({super.key});

    @override
    Widget build(BuildContext context){
      return Scaffold(
        // resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text("Compass Page"),
          backgroundColor: const Color.fromARGB(255, 5, 142, 24),
        ),
        body: Center(
          child:SingleChildScrollView(
          child: 
          SizedBox(
            height: 900,
            child: Column(
            // mainAxisSize: MainAxisSize.max,
            children:[
               const CompassSection(),                
              //  const MainInfoSection(),  
               ElevatedButton(            
              onPressed: () =>  Navigator.pop(context),
              child: const Text(
                "Back to tour selection", 
                style: TextStyle(fontSize: 20, color: Colors.white),
                ),
            ),
            ]
          ),
          )
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

class SvgSection extends StatelessWidget{
  const SvgSection({super.key, required this.image});

  final String image;

  @override
  Widget build(BuildContext context){
    return SvgPicture.asset(
      image,
      height: 120, width: 120,
      fit: BoxFit.scaleDown,
      semanticsLabel: "Compass",
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
        // Center(
        //   child: SvgSection(image: "images/compass.svg"),
        //   )
      ]
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
                child: Image.asset("images/" + imageRef, fit: BoxFit.contain),
                ),
            // Icon(
            //   Icons.audio_file,
            //   color: Colors.green,
            //   size: 30,
            //   ),              
              ]
              
            ),
            const Padding(
              padding:    EdgeInsets.only(top: 19),
              child: Icon(
               Icons.audio_file,
              color: Colors.green,
               size: 30,
              )

            ),           
            TextSection(description: description),

            // ElevatedButton(            
            //   onPressed: () =>  Navigator.pop(context),
            //   child: const Text(
            //     "Back to tour selection", 
            //     style: TextStyle(fontSize: 20, color: Colors.white),
            //     ),
            // ),
            
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