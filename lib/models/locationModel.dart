class Location{
  String name;
  double latitude;
  double longitude;
  String imageRef;
  String description;

  Location({required this.name, 
  required this.latitude, 
  required this.longitude, 
  required this.imageRef, 
  required this.description});

  Location.fromJson(Map<String, dynamic> json)
    : name = json["name"] as String,
      latitude = json["latitude"] as double,
      longitude = json["longitude"] as double,
      imageRef = json["imageRef"] as String,
      description = json["description"] as String;

  Map<String, dynamic> toJson() => {
    "name": name,
    "latitude": latitude,
    "longitude": longitude,
    "imageRef": imageRef,
    "description": description
  };
}