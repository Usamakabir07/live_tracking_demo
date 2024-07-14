// To parse this JSON data, do
//
//     final coordinates = coordinatesFromJson(jsonString);

import 'dart:convert';

Coordinates coordinatesFromJson(String str) =>
    Coordinates.fromJson(json.decode(str));

String coordinatesToJson(Coordinates data) => json.encode(data.toJson());

class Coordinates {
  double latitude;
  double longitude;

  Coordinates({
    required this.latitude,
    required this.longitude,
  });

  factory Coordinates.fromJson(Map<String, dynamic> json) => Coordinates(
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
      };
}
