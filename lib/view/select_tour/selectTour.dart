import 'package:flutter/material.dart';
import 'package:accordion/accordion.dart';
import 'package:edge_hill_tour/view/compass/compass.dart';


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

    @override
    Widget build(BuildContext context){
      return Scaffold(
        appBar: AppBar(
          title: const Text("Edge Hill Tour", style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.w700)),
          backgroundColor: Color.fromARGB(255, 28, 27, 31),
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
                // onPressed:() => Navigator.push(context, MaterialPageRoute(builder: (context) => CompassPage(fileName: tourChoice[selectedIndex]))),
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
            )
            
            
          ]
        ),
        
    );
    }
}

  AccordionSection CreateAccordionSection(List<String> campusTourPlaces, String accordionName) {
    return AccordionSection(
            isOpen: false,
            header: Text(accordionName),
            content: Column(
              children: [
                ...List.generate(
                  campusTourPlaces.length,
                  (index) => CreateAccordionRow(campusTourPlaces[index]),
                )
            ]),
          );
  }

  

  Row CreateAccordionRow(String labelText) {
    return Row(
              children:[
                Text(labelText, style: const TextStyle(color: Colors.black)),
                const Spacer(),
                const CheckBoxExample(),
                ]
              );
  }

    Container ListContainer() {
    return Container(
            height: 50,
            color: Colors.amber[500],
            child: const Row
            (
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
              children: <Widget>[
                Text("Catalyst"),
                Spacer(), // Works but doesn't feel right
                // Text("Item2"),
                CheckBoxExample(),  // Code taken directly from flutter site 
              ],
            ),
          );
  }

class CheckBoxExample extends StatefulWidget{
  const CheckBoxExample({super.key});

  @override
  State<CheckBoxExample> createState() => _CheckboxExampleState();
}

class _CheckboxExampleState extends State<CheckBoxExample> {
  bool isChecked = true;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.red;
    }

    return Checkbox(
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value!;
        });
      },
    );
  }
}

