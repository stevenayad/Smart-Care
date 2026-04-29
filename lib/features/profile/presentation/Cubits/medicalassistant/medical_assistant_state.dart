import 'package:smartcare/features/profile/data/Model/medical_assistant_chat/chat_message.dart';
abstract class MedicalAssistantState {
  final List<ChatMessage> messages;

  MedicalAssistantState({required this.messages});
}

class MedicalAssistantInitial extends MedicalAssistantState {
  MedicalAssistantInitial() : super(messages: []);
}

class MedicalAssistantLoading extends MedicalAssistantState {
  MedicalAssistantLoading(List<ChatMessage> messages)
    : super(messages: messages);
}

class MedicalAssistantSuccess extends MedicalAssistantState {
  final String answer;
  MedicalAssistantSuccess(this.answer, List<ChatMessage> messages)
    : super(messages: messages);
}

class MedicalAssistantError extends MedicalAssistantState {
  final String error;
  MedicalAssistantError(this.error, List<ChatMessage> messages)
    : super(messages: messages);
}
