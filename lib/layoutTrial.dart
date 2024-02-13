import 'package:flutter/material.dart';

class MyApp2 extends StatelessWidget{
  const MyApp2({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: "Trial",
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Trial"),
        ),
        body: const Center(
          child: TitleSection(location: "Edge Hill", name: "Lyle"),
        )
      )
    );
  }
}

class TitleSection extends StatelessWidget{
  const TitleSection({
    super.key,
    required this.name,
    required this.location,
  });

  final String name;
  final String location;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*2*/
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  location,
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          /*3*/
          Icon(
            Icons.star,
            color: Colors.red[500],
          ),
          const Text('41'),
        ],
      ),
    );
  }
}