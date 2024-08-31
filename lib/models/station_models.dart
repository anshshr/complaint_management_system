// To parse this JSON data, do
//
//     final station = stationFromJson(jsonString);

import 'dart:convert';

Station stationFromJson(String str) => Station.fromJson(json.decode(str));

String stationToJson(Station data) => json.encode(data.toJson());

class Station {
  final List<StationElement>? stations;

  Station({
    this.stations,
  });

  factory Station.fromJson(Map<String, dynamic> json) => Station(
        stations: json["stations"] == null
            ? []
            : List<StationElement>.from(
                json["stations"]!.map((x) => StationElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "stations": stations == null
            ? []
            : List<dynamic>.from(stations!.map((x) => x.toJson())),
      };
}

class StationElement {
  final String? stnCode;
  final String? stnName;
  final String? stnCity;

  StationElement({
    this.stnCode,
    this.stnName,
    this.stnCity,
  });

  factory StationElement.fromJson(Map<String, dynamic> json) => StationElement(
        stnCode: json["stnCode"],
        stnName: json["stnName"],
        stnCity: json["stnCity"],
      );

  Map<String, dynamic> toJson() => {
        "stnCode": stnCode,
        "stnName": stnName,
        "stnCity": stnCity,
      };
}
