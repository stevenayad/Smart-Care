import 'package:smartcare/features/profile/data/Model/condration_model/MedicalWarningData.dart';

class MedicalWarningResponse {
  final int statusCode;
  final bool succeeded;
  final String message;
  final dynamic errorsBag;
  final List<MedicalWarningData> data;

  MedicalWarningResponse({
    required this.statusCode,
    required this.succeeded,
    required this.message,
    required this.errorsBag,
    required this.data,
  });

  factory MedicalWarningResponse.fromJson(Map<String, dynamic> json) {
    return MedicalWarningResponse(
      statusCode: json['statusCode'],
      succeeded: json['succeeded'],
      message: json['message'],
      errorsBag: json['errorsBag'],
      data: (json['data'] as List)
          .map((e) => MedicalWarningData.fromJson(e))
          .toList(),
    );
  }
}
