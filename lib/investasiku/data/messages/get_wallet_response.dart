import 'package:duitku/investasiku/data/portofolio_models.dart';

class GetPortofolioResponse {
  final List<Portofolio> portofolio;

  GetPortofolioResponse({required this.portofolio});

  factory GetPortofolioResponse.fromJson(List<dynamic> json) => GetPortofolioResponse(
        portofolio: List<Portofolio>.from(json.map((map) => Portofolio.fromMap(map))),
      );

  List<Map<String, dynamic>> toJson() =>
      portofolio.map((wallet) => wallet.toMap()).toList();
}