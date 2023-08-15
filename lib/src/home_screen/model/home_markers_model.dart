// To parse this JSON data, do
//
//     final markers = markersFromJson(jsonString);

import 'dart:convert';

List<Markers> markersFromJson(String str) =>
    List<Markers>.from(json.decode(str).map((x) => Markers.fromJson(x)));

String markersToJson(List<Markers> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Markers {
  UserDetails userDetails;
  DateTime datecreated;
  String description;
  List<String> fishes;
  List<double> location;
  String userid;

  Markers({
    required this.userDetails,
    required this.datecreated,
    required this.description,
    required this.fishes,
    required this.location,
    required this.userid,
  });

  factory Markers.fromJson(Map<String, dynamic> json) => Markers(
        userDetails: UserDetails.fromJson(json["userDetails"]),
        datecreated: DateTime.parse(json["datecreated"]),
        description: json["description"],
        fishes: List<String>.from(json["fishes"].map((x) => x)),
        location: List<double>.from(json["location"].map((x) => x.toDouble())),
        userid: json["userid"],
      );

  Map<String, dynamic> toJson() => {
        "userDetails": userDetails.toJson(),
        "datecreated": datecreated.toIso8601String(),
        "description": description,
        "fishes": List<dynamic>.from(fishes.map((x) => x)),
        "location": List<dynamic>.from(location.map((x) => x)),
        "userid": userid,
      };
}

class UserDetails {
  String password;
  String firstname;
  String devicename;
  String deviceId;
  String username;
  String lastname;

  UserDetails({
    required this.password,
    required this.firstname,
    required this.devicename,
    required this.deviceId,
    required this.username,
    required this.lastname,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
        password: json["password"],
        firstname: json["firstname"],
        devicename: json["devicename"],
        deviceId: json["deviceID"],
        username: json["username"],
        lastname: json["lastname"],
      );

  Map<String, dynamic> toJson() => {
        "password": password,
        "firstname": firstname,
        "devicename": devicename,
        "deviceID": deviceId,
        "username": username,
        "lastname": lastname,
      };
}
