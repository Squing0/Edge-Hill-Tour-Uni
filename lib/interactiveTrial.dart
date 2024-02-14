import 'package:flutter/material.dart';

class MyApp4 extends StatelessWidget{
  const MyApp4({super.key});

  @override
  build(BuildContext context){
    return MaterialApp(
      home: Scaffold(
        body:
        Column(
          children:[
            const TextField(
              decoration: InputDecoration(
                hintText: "Enter a search term",
              )
            ),
            textForm()
          ]
        )
      )
    );
  }

  TextFormField textForm() {
    return TextFormField(
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: "Enter your username"
            )
          );
  }
}

class MyButton extends StatelessWidget{
  const MyButton({super.key});

  @override
  Widget build(BuildContext context){
    return GestureDetector(
              onTap: (){
                const snackBar = SnackBar(content: Text("Tap"));

                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },

              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.lightBlue,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text("My Button"),
              )
            );
  }
}