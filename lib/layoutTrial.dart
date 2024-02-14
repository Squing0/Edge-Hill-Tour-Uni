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
          child: Column(
            children:[
              ImageSection(
                image: "images/lake.jpg",
              ),
              TitleSection(
                name: 'Oeschinen Lake Campground',
                location: 'Kandersteg, Switzerland',
              ),
              ButtonSection(),
              TextSection(description: 'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese Alps. Situated 1,578 meters above sea level, it is one of the larger Alpine Lakes. A gondola ride from Kandersteg, followed by a half-hour walk through pastures and pine forest, leads you to the lake, which warms to 20 degrees Celsius in the summer. Activities enjoyed here include rowing, and riding the summer toboggan run.',),
            ]
          )
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
          const FavouriteWidget(),
        ],
      ),
    );
  }
}

class ButtonSection extends StatelessWidget{
  const ButtonSection({super.key});

  @override
  Widget build(BuildContext context){
    final Color color = Theme.of(context).primaryColor;
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children:[
          ButtonWithText(
            color: color,
            icon: Icons.call,
            label: "CALL",
          ),
          ButtonWithText(
            color: color,
            icon: Icons.near_me,
            label: "ROUTE",
          ),
          ButtonWithText(
            color: color,
            icon: Icons.share,
            label: "SHARE",
          ),
        ]
      )
    );
  }
}

class ButtonWithText extends StatelessWidget{
  const ButtonWithText({
    super.key,
    required this.color,
    required this.icon,
    required this.label,
  });

  final Color color;
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context){
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children:[
        Icon(icon, color: color),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: color,
            )
          )
        )
      ]
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

class ImageSection extends StatelessWidget{
  const ImageSection({super.key, required this.image});

  final String image;

  @override
  Widget build(BuildContext context){
    return Image.asset(
      image,
      width: 612,
      height: 404,
      fit: BoxFit.cover,
    );
  }
}

class FavouriteWidget extends StatefulWidget{
  const FavouriteWidget({super.key});

  @override
  State<FavouriteWidget> createState() => _FavouriteWidgetState();
}

class _FavouriteWidgetState extends State<FavouriteWidget>{
  bool _isFavourited = true;
  int _favouriteCount = 41;

  void _toggleFavourite(){
    setState((){
      if(_isFavourited){
        _favouriteCount -= 1;
        _isFavourited = false;
      }
      else{
        _favouriteCount += 1;
        _isFavourited = true;
      }
    });
  }

  @override
  build(BuildContext context){
    return Row(
      mainAxisSize: MainAxisSize.min,
      children:[
        Container(
          padding: const EdgeInsets.all(0),
          child: IconButton(
            padding: const EdgeInsets.all(0),
            alignment: Alignment.centerRight,
            icon: (_isFavourited
            ? const Icon(Icons.star)
            : const Icon (Icons.star_border)),
            color: Colors.red[500],
            onPressed: _toggleFavourite,
          )
        ),
        SizedBox(
          width: 18,
          child: SizedBox(
            child: Text("$_favouriteCount"),
          )
        )
      ]
    );
  }
}