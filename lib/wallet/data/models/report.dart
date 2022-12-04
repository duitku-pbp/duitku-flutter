class Report {
  double income;
  double outcome;
  double netIncome;
  String period;

  Report({
    required this.income,
    required this.outcome,
    required this.netIncome,
    required this.period,
  });

  factory Report.fromMap(Map<String, dynamic> map) => Report(
        income: double.parse(map["income"].toString()),
        outcome: double.parse(map["outcome"].toString()),
        netIncome: double.parse(map["net_income"].toString()),
        period: map["period"],
      );

  Map<String, dynamic> toMap() => {
        "income": income,
        "outcome": outcome,
        "net_income": netIncome,
        "period": period,
      };
}
