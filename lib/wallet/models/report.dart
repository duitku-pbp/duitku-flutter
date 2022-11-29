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
        income: map["income"],
        outcome: map["outcome"],
        netIncome: map["net_income"],
        period: map["period"],
      );

  Map<String, dynamic> toMap() => {
        "income": income,
        "outcome": outcome,
        "net_income": netIncome,
        "period": period,
      };
}
