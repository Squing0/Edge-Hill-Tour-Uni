import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';


class CompassPage extends StatelessWidget{
  const CompassPage({super.key});

  @override
  Widget build(BuildContext context){
    const title = "Compass Page";
    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Compass Page")
        ),
        body: Center(
          child: Column(
            children:[
              CompassSection(),          
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
    return Stack(
      children: <Widget>[
        ImageSection(image: "images/campusBirdsEye.jpg",),
        SvgSection(image: "iamges/compass.svg"),
      ]
    );
  }
}