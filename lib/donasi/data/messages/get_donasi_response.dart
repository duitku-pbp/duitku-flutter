import 'package:duitku/donasi/data/models/donasi.dart';

class GetDonasiResponse {
  final List<Donasi> donasis;

  GetDonasiResponse({required this.donasis});

  factory GetDonasiResponse.fromJson(List<dynamic> json) => GetDonasiResponse(
        donasis: List<Donasi>.from(json.map((map) => Donasi.fromMap(map))),
      );

  List<Map<String, dynamic>> toJson() =>
      donasis.map((donasi) => donasi.toMap()).toList();
}