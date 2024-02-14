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
        appBar: AppBar(
          title: const Text("Compass Page")
        ),
        body: const Center(
          child: Column(
            children:[
              CompassSection(),    
              MainInfoSection(),      
            ]
          ),
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
      fit: BoxFit.contain,
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
    return const Stack(
      children: <Widget>[
        ImageSection(image: "images/campusBirdsEye.jpg", height: 380),
        Center(
          child: SvgSection(image: "images/compass.svg"),
          )
      ]
    );
  }
}

class MainInfoSection extends StatelessWidget{
  const MainInfoSection({super.key});

  @override
  Widget build(BuildContext context){
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            AppBar(
              title: const Text("Catalyst"),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:[
                ImageSection(
              image: "images/catalyst.jpg",
              height: 170,
            ),
            Icon(
              Icons.audio_file,
              color: Colors.green,
              size: 30,
              ),              
              ]
              
            ),
            TextSection(description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate veli"),
            
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
      padding: const EdgeInsets.all(32),
      child: Text(
        description,
        softWrap: true,
        
      )
    );

  }
}