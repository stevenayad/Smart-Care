import 'MedicalAssistantChatData.dart';

class MedicalAssistantChat {
  int? statusCode;
  bool? succeeded;
  String? message;
  dynamic errorsBag;
  MedicalAssistantChatData? data;

  MedicalAssistantChat({
    this.statusCode,
    this.succeeded,
    this.message,
    this.errorsBag,
    this.data,
  });

  factory MedicalAssistantChat.fromJson(Map<String, dynamic> json) {
    return MedicalAssistantChat(
      statusCode: json['statusCode'] as int?,
      succeeded: json['succeeded'] as bool?,
      message: json['message'] as String?,
      errorsBag: json['errorsBag'] as dynamic,
      data: json['data'] == null
          ? null
          : MedicalAssistantChatData.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
    'statusCode': statusCode,
    'succeeded': succeeded,
    'message': message,
    'errorsBag': errorsBag,
    'data': data?.toJson(),
  };
}
