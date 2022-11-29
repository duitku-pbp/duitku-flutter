import 'package:duitku/wallet/models/report.dart';

class GetReportResponse {
  final Report report;

  GetReportResponse({required this.report});

  factory GetReportResponse.fromJson(Map<String, dynamic> json) =>
      GetReportResponse(report: Report.fromMap(json));

  Map<String, dynamic> toJson() => report.toMap();
}
