import 'dart:convert';

List<Investasi> InvestasiFromJson(String str) =>
    List<Investasi>.from(json.decode(str).map((x) => Investasi.fromJson(x)));

String InvestasiToJson(List<Investasi> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Investasi {
  Investasi(
     {required this.pk,
      required this.investment_name,
      required this.investment_type,
      required this.cagr_1Y,
      required this.drawdown_1Y,
      required this.aum,
      required this.expense_ratio,
      required this.min_buy});

  int pk;
  String investment_name;
  String investment_type;
  String cagr_1Y;
  String drawdown_1Y;
  String aum;
  String expense_ratio;
  int min_buy;

  factory Investasi.fromJson(Map<String, dynamic> json) => Investasi(
        pk: json["pk"],
        investment_name: json["fields"]["investment_name"],
        investment_type: json["fields"]["investment_type"],
        cagr_1Y: json["fields"]["cagr_1Y"],
        drawdown_1Y: json["fields"]["drawdown_1Y"],
        aum: json["fields"]["aum"],
        expense_ratio: json["fields"]["expense_ratio"],
        min_buy: json["fields"]["min_buy"],
      );

  Map<String, dynamic> toJson() => {
        "pk": pk,
        "investment_name": investment_name,
        "investment_type": investment_type,
        "cagr_1Y": cagr_1Y,
        "drawdown_1Y": drawdown_1Y,
        "aum": aum,
        "expense_ratio": expense_ratio,
        "min_buy": min_buy,
      };
}