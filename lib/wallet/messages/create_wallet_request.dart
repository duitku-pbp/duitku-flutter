class CreateWalletRequest {
  String name;
  double initialBalance;
  String description;

  CreateWalletRequest({
    required this.name,
    required this.initialBalance,
    this.description = "",
  });

  Map<String, dynamic> toJson() => {
        "name": name,
        "initial-balance": initialBalance,
        "description": description,
      };
}
