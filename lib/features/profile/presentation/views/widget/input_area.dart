import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/core/app_color.dart';
import 'package:smartcare/features/profile/presentation/Cubits/medicalassistant/medical_assistant_cubit.dart';
import 'package:smartcare/features/profile/presentation/Cubits/medicalassistant/medical_assistant_state.dart';

class InputArea extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;
  final VoidCallback onImageTap;

  const InputArea({
    super.key,
    required this.controller,
    required this.onSend,
    required this.onImageTap,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MedicalAssistantCubit, MedicalAssistantState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(blurRadius: 8, color: Colors.black.withOpacity(0.05)),
            ],
          ),
          child: Row(
            children: [
              IconButton(
                onPressed: onImageTap,
                icon: const Icon(
                  Icons.camera_alt_outlined,
                  color: AppColors.primaryblue,
                ),
              ),
              Expanded(
                child: TextField(
                  controller: controller,
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: "Type your message...",
                    filled: true,
                    fillColor: AppColors.lightGrey,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              ValueListenableBuilder<TextEditingValue>(
                valueListenable: controller,
                builder: (context, value, _) {
                  final isEmpty = value.text.trim().isEmpty;

                  return IconButton(
                    onPressed: isEmpty ? null : onSend,
                    icon: Icon(
                      Icons.send,
                      color: isEmpty ? Colors.grey : AppColors.primaryblue,
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

