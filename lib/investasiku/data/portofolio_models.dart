// To parse this JSON data, do
//
//     final WatchList = WatchListFromJson(jsonString);

class Portofolio {
  Portofolio(
     {required this.investment,
      required this.boughtValue});

  int investment;
  int boughtValue;

  factory Portofolio.fromJson(Map<String, dynamic> json) => Portofolio(
        investment: json["fields"]["investment"],
        boughtValue: json["fields"]["bought_value"],
      );

  Map<String, dynamic> toJson() => {
        "investment": investment,
        "bought_value": boughtValue,
      };
  factory Portofolio.fromMap(Map<String, dynamic> map) => Portofolio(
        investment: map["fields"]["investment"],
        boughtValue: map["fields"]["bought_value"],
      );

  Map<String, dynamic> toMap() => {
        "investment": investment,
        "bought_value": boughtValue,
      };
}