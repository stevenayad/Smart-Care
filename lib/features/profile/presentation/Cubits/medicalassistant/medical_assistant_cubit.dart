import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/features/profile/data/Model/medical_assistant_chat/chat_message.dart';
import 'package:smartcare/features/profile/data/repo/medical_assistant_repository.dart';

import 'medical_assistant_state.dart';

class MedicalAssistantCubit extends Cubit<MedicalAssistantState> {
  final MedicalAssistantApiService service;

  MedicalAssistantCubit(this.service) : super(MedicalAssistantInitial());

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    final updatedMessages = List<ChatMessage>.from(state.messages)
      ..add(ChatMessage(text: text, type: MessageType.user));

    emit(MedicalAssistantLoading(updatedMessages));

    final result = await service.sendMessage(message: text);

    result.fold(
      (failure) {
        final errorMessage = ChatMessage(
          text: failure.errMessage,
          type: MessageType.ai,
        );

        final finalMessages = List<ChatMessage>.from(updatedMessages)
          ..add(errorMessage);

        emit(MedicalAssistantError(failure.errMessage, finalMessages));
      },
      (response) {
        final answer = response.data?.answer;

        if (answer != null && answer.isNotEmpty) {
          final aiMessage = ChatMessage(text: answer, type: MessageType.ai);

          final finalMessages = List<ChatMessage>.from(updatedMessages)
            ..add(aiMessage);

          emit(MedicalAssistantSuccess(answer, finalMessages));
        } else {
          final errorMessage = ChatMessage(
            text: 'Received empty response from AI',
            type: MessageType.ai,
          );

          final finalMessages = List<ChatMessage>.from(updatedMessages)
            ..add(errorMessage);
          emit(
            MedicalAssistantError(
              "Received empty response from AI",
              finalMessages,
            ),
          );
        }
      },
    );
  }

  Future<void> sendImage(File image) async {
    final updatedMessages = List<ChatMessage>.from(state.messages)
      ..add(ChatMessage(
        text: "Analyzing image for drug info...",
        type: MessageType.user,
        image: image,
      ));

    emit(MedicalAssistantLoading(updatedMessages));

    final result = await service.processImageAndAskAI(image);

    result.fold(
      (failure) {
        final errorMessage = ChatMessage(
          text: failure.errMessage,
          type: MessageType.ai,
        );

        final finalMessages = List<ChatMessage>.from(updatedMessages)
          ..add(errorMessage);

        emit(MedicalAssistantError(failure.errMessage, finalMessages));
      },
      (response) {
        final answer = response.data?.answer;

        if (answer != null && answer.isNotEmpty) {
          final aiMessage = ChatMessage(text: answer, type: MessageType.ai);

          final finalMessages = List<ChatMessage>.from(updatedMessages)
            ..add(aiMessage);

          emit(MedicalAssistantSuccess(answer, finalMessages));
        } else {
          final errorMessage = ChatMessage(
            text: 'Could not extract or explain medicines from this image.',
            type: MessageType.ai,
          );

          final finalMessages = List<ChatMessage>.from(updatedMessages)
            ..add(errorMessage);
          emit(
            MedicalAssistantError(
              "Empty AI response",
              finalMessages,
            ),
          );
        }
      },
    );
  }
}

