import 'package:flutter/material.dart';
import 'package:accordion/accordion.dart';


class SelectTourPage extends StatelessWidget{
  const SelectTourPage({super.key});

  @override
  Widget build(BuildContext context){
    const title = "Tour Selection";
    List<String> campusTourPlaces = ["Catalyst", "Arts Center", "Tech Hub", "Education Building", "Creative Edge"];
    List<String> accommodationPlaces = ["Forest Court", "Founders West", "Founders East", "Woodland Court", "Chancellors Court"];
    List<String> tourChoice = ["Campus Tour", "Accommodation Tour"];

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
          title: const Text("Tour Selection"),
          backgroundColor: const Color.fromARGB(255, 5, 142, 24),
        ),
        body: 
        // Center(
        //   child: Column(
        //     children:
        //     ListView(
        //       children: <Widget>[
        //         Container(
                  
        //         )
        //       ]
        //     ),
        //   ),
        //   )
        ListView(
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          children: <Widget>[
            // ListContainer(),
            // ListContainer(),
            // ListContainer(),
            // ListContainer(),
            Accordion(
              header: const Text("Accordion"),
              children:[
                CreateAccordionSection(campusTourPlaces, tourChoice[0]),
                CreateAccordionSection(accommodationPlaces, tourChoice[1]),
              ]
              
            ),
            DropdownMenu<String>(
              initialSelection: "",
              onSelected: (String? value){
                // setState((){
                //   dropdownValue = value!;
                // });
                // State still needs to be added here

              },
              dropdownMenuEntries: tourChoice.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),

            ),
            const Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 6.0, right: 6.0),
              child: const ElevatedButton(            
                onPressed: null,
                child: const Text(
                  "Confirm Tour Selection", 
                  style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
              ),
            ),
          ]
        ),
        
    )
    );
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
                Text(labelText, style: TextStyle(color: Colors.black)),
                Spacer(),
                CheckBoxExample(),
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
