import 'package:flutter/material.dart';
import 'package:edge_hill_tour/view/compass/compass.dart';
import 'package:url_launcher/url_launcher.dart';

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
    home: const SelectTourMain(),
    );
  }
}

class SelectTourMain extends StatefulWidget{
    const SelectTourMain({super.key});

  @override
  State<SelectTourMain> createState() => _SelectTourMainState();
}

class _SelectTourMainState extends State<SelectTourMain> {
    int selectedIndex = 0;

    final List<String> campusTourPlaces = ["Catalyst", "Arts Center", "Tech Hub", "Education Building", "Creative Edge"];
    final List<String> accommodationPlaces = ["Forest Court", "Founders West", "Founders East", "Woodland Court", "Chancellors Court"];
    final List<String> tourChoice = ["", "Main-Tour", "Accommodation"];
    Uri url = Uri.parse("https://www.edgehill.ac.uk");

    @override
    Widget build(BuildContext context){
      return Scaffold(
        appBar: AppBar(
          title: const Text("Edge Hill Tour", style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.w700)),
          backgroundColor: const Color.fromARGB(255, 28, 27, 31),
          centerTitle: true,
        ),
        body: 
        ListView(
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          children: <Widget>[         
           Container(
          height: 300,
          alignment: Alignment.center,
          child: const Column(children: [
            ]) ,
          ),
            Padding(
              padding: const EdgeInsets.only(top: 1.0, left: 6.0, right: 6.0, bottom: 20.0),
              child: ElevatedButton(            
                onPressed: () {
                if (selectedIndex > 0) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          CompassPage(fileName: tourChoice[selectedIndex]),
                    ),
                  );
                } 
              },
                child: const Text(
                  "Select Tour", 
                  style: TextStyle(fontSize: 45, color: Colors.white),
                  ),
              ),
            ),
            Container(
            alignment: Alignment.center,
            child:
            DropdownMenu<String>(            
              initialSelection: "",
              onSelected: (String? value){
                setState(() {
                selectedIndex = tourChoice.indexOf(value!);
              });
              },
              dropdownMenuEntries: tourChoice.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),

            ),
            ),
             Padding(
               padding: const EdgeInsets.only(top: 180),
               child: Expanded(
                 child: Align(
                   alignment: Alignment.bottomCenter,
                   child: ElevatedButton(
                     onPressed: () => _launchUrl(),
                     child: const Text(
                       "Edge Hill Site",
                       style: TextStyle(
                         fontStyle: FontStyle.italic,
                         color: Color.fromARGB(255, 239, 239, 239),
                         fontSize: 25,
                       ),
                     ),
                   ),
                 ),
               ),
             )         
          ]
        ),       
    );
    }

      _launchUrl() async{
    if(!await launchUrl(url)){
      throw Exception('Could not launch $url');
    }
  }
}