// To parse this JSON data, do
//
//     final WatchList = WatchListFromJson(jsonString);

import 'dart:convert';

import 'package:duitku/investasiku/data/fetchInvestasi.dart';
import 'package:duitku/investasiku/data/investasiModels.dart';

List<Portofolio> InvestasiFromJson(String str) =>
    List<Portofolio>.from(json.decode(str).map((x) => Portofolio.fromJson(x)));

String InvestasiToJson(List<Portofolio> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Portofolio {
  Portofolio(
     {required this.investment,
      required this.bought_value});

  int investment;
  int bought_value;

  factory Portofolio.fromJson(Map<String, dynamic> json) => Portofolio(
        investment: json["fields"]["investment"],
        bought_value: json["fields"]["bought_value"],
      );

  Map<String, dynamic> toJson() => {
        "investment": investment,
        "bought_value": bought_value,
      };
  factory Portofolio.fromMap(Map<String, dynamic> map) => Portofolio(
        investment: map["fields"]["investment"],
        bought_value: map["fields"]["bought_value"],
      );

  Map<String, dynamic> toMap() => {
        "investment": investment,
        "bought_value": bought_value,
      };
}