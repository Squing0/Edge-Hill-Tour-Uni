import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class CompassPage extends StatelessWidget{
  const CompassPage({super.key});

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
        body: Center(
          child:SingleChildScrollView(
          child: 
          SizedBox(
            height: 900,
            child: Column(
            // mainAxisSize: MainAxisSize.max,
            children:[
               const CompassSection(),                
               const MainInfoSection(),  
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
      )
      
    );

  }
}

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
               const MainInfoSection(),  
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
        Image.asset("images/campusBirdsEye.jpg", fit: BoxFit.cover),
        // Center(
        //   child: SvgSection(image: "images/compass.svg"),
        //   )
      ]
    );
  }
}

class MainInfoSection extends StatelessWidget{
  const MainInfoSection({super.key});

  @override
  Widget build(BuildContext context){
    return SizedBox(
      height: 250,
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            AppBar(
              title: const Text("Catalyst"),
              backgroundColor: const Color.fromARGB(255, 206, 8, 255),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:[
                SizedBox(
                  height: 200,
                child: Image.asset("images/catalyst.jpg", fit: BoxFit.contain),
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
            const TextSection(description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate veli"),

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