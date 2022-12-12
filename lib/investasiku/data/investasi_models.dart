class Investasi {
  Investasi(
     {required this.pk,
      required this.investmentName,
      required this.investmentType,
      required this.cagr_1Y,
      required this.drawdown_1Y,
      required this.aum,
      required this.expenseRatio,
      required this.minBuy});

  int pk;
  String investmentName;
  String investmentType;
  String cagr_1Y;
  String drawdown_1Y;
  String aum;
  String expenseRatio;
  int minBuy;

  factory Investasi.fromJson(Map<String, dynamic> json) => Investasi(
        pk: json["pk"],
        investmentName: json["fields"]["investment_name"],
        investmentType: json["fields"]["investment_type"],
        cagr_1Y: json["fields"]["cagr_1Y"],
        drawdown_1Y: json["fields"]["drawdown_1Y"],
        aum: json["fields"]["aum"],
        expenseRatio: json["fields"]["expense_ratio"],
        minBuy: json["fields"]["min_buy"],
      );

  Map<String, dynamic> toJson() => {
        "pk": pk,
        "investment_name": investmentName,
        "investment_type": investmentType,
        "cagr_1Y": cagr_1Y,
        "drawdown_1Y": drawdown_1Y,
        "aum": aum,
        "expense_ratio": expenseRatio,
        "min_buy": minBuy,
      };
}