class Donasi {
    Donasi({
        required this.name,
        required this.amount,
        required this.target,
    });

    String name;
    int amount;
    String target;

    factory Donasi.fromMap(Map<String, dynamic> map) => Donasi(
        name: map["fields"]["name"],
        amount: map["fields"]["amount"],
        target: map["fields"]["target"],
    );

    Map<String, dynamic> toMap() => {
        "name": name,
        "amount": amount,
        "target": target,
    };
}
