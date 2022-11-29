class Wallet {
  int id;
  int ownerId;
  String name;
  String description;
  double balance;

  Wallet({
    required this.id,
    required this.ownerId,
    required this.name,
    required this.description,
    required this.balance,
  });

  factory Wallet.fromMap(Map<String, dynamic> map) => Wallet(
        id: map["id"],
        ownerId: map["owner_id"],
        name: map["name"],
        description: map["description"],
        balance: map["balance"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "owner_id": ownerId,
        "name": name,
        "description": description,
        "balance": balance,
      };
}
