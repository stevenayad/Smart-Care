import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:smartcare/core/api/api_consumer.dart';
import 'package:smartcare/core/api/failure.dart';
import 'package:smartcare/features/profile/data/Model/medical_assistant_chat/medical_assistant_chat.dart';


class MedicalAssistantApiService {
  final ApiConsumer dio;

  MedicalAssistantApiService(this.dio);

  Future<Either<Failure, List<String>>> extractDrugInfo(File image) async {
    try {
      final formData = FormData.fromMap({
        "Image": await MultipartFile.fromFile(image.path),
      });

      final response = await dio.post(
        '/api/ai-medical-assistant/extract-drug-info',
        formData,
        true,
      );

      if (response != null && response['data'] != null) {
        final ingredients = List<String>.from(response['data']['active_ingredients'] ?? []);
        return Right(ingredients);
      } else {
        return Left(servivefailure("Failed to extract drug info"));
      }
    } on DioException catch (e) {
      return Left(servivefailure.fromDioError(e));
    } catch (e) {
      return Left(servivefailure("Unexpected error occurred"));
    }
  }

  Future<Either<Failure, MedicalAssistantChat>> sendMessage({
    String? message,
    List<String>? activeIngredients,
  }) async {
    try {
      String finalQuestion = "";
      if (activeIngredients != null && activeIngredients.isNotEmpty) {
        finalQuestion = "Explain these medicines: ${activeIngredients.join(', ')}";
      } else {
        finalQuestion = message ?? "";
      }

      if (finalQuestion.isEmpty) {
        return Left(servivefailure("Message cannot be empty"));
      }

      final formData = FormData.fromMap({
        "Question": finalQuestion,
        "ingredients": "general",
      });

      final response = await dio.post(
        '/api/ai-medical-assistant/chat',
        formData,
        true,
      );

      if (response != null) {
        return Right(MedicalAssistantChat.fromJson(response));
      } else {
        return Left(servivefailure("Unexpected response format"));
      }
    } on DioException catch (e) {
      return Left(servivefailure.fromDioError(e));
    } catch (e) {
      return Left(servivefailure("Unexpected error, please try again"));
    }
  }

  Future<Either<Failure, MedicalAssistantChat>> processImageAndAskAI(File image) async {
    final extractResult = await extractDrugInfo(image);
    
    return await extractResult.fold(
      (failure) async => Left(failure),
      (ingredients) async {
        if (ingredients.isEmpty) {
          return Left(servivefailure("No active ingredients found in the image"));
        }
        return await sendMessage(activeIngredients: ingredients);
      },
    );
  }
}

