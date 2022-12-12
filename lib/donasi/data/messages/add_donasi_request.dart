class AddDonasiRequest {
  String name;
  double amount;
  String target;


  AddDonasiRequest({
    required this.name,
    required this.amount,
    required this.target,

  });

  Map<String, dynamic> toJson() => {
        "name": name,
        "amount": amount,
        "target": target,

      };
}