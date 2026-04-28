import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smartcare/features/profile/presentation/Cubits/medicalassistant/medical_assistant_cubit.dart';

part 'medical_assistant_controller_state.dart';

class MedicalAssistantControllerLogicbit
    extends Cubit<MedicalAssistantControllerState> {
  final TextEditingController controller = TextEditingController();
  final ScrollController scrollController =
      ScrollController(); //controller of listview
  final ImagePicker _picker = ImagePicker();

  final MedicalAssistantCubit chatCubit;
  MedicalAssistantControllerLogicbit({required this.chatCubit})
    : super(MedicalAssistantControllerInitial());

  void scrollToBottom() {
    if (!scrollController.hasClients) return;

    Future.delayed(const Duration(milliseconds: 100), () {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    });
  }

  void sendMessageFromController() {
    final text = controller.text.trim();
    if (text.isEmpty) return;
    controller.clear();
    chatCubit.sendMessage(text);
  }

  Future<void> pickAndSendImage(BuildContext context) async {
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () => Navigator.pop(context, ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: () => Navigator.pop(context, ImageSource.gallery),
            ),
          ],
        ),
      ),
    );

    if (source != null) {
      final XFile? image = await _picker.pickImage(source: source);
      if (image != null) {
        chatCubit.sendImage(File(image.path));
      }
    }
  }

  @override
  Future<void> close() {
    controller.dispose();
    scrollController.dispose();
    return super.close();
  }
}

