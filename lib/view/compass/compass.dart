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
          seedColor: Color.fromARGB(255, 81, 0, 255),
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
  const ImageSection({super.key, required this.image});

  final String image;

  @override
  Widget build(BuildContext context){
    return Image.asset(
      image,
      // width: 612,
      // height: 404,
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
        ImageSection(image: "images/campusBirdsEye.jpg"),
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
            ImageSection(
              image: "images/catalyst.jpg"
            )
          ]
        )
      )
    );
  }
}