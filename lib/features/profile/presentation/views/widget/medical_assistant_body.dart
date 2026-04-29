import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/core/app_color.dart';
import 'package:smartcare/core/app_theme.dart';
import 'package:smartcare/features/profile/presentation/Cubits/medical_assistant_controller/medical_assistant_controller_cubit.dart';
import 'package:smartcare/features/profile/presentation/Cubits/medicalassistant/medical_assistant_cubit.dart';
import 'package:smartcare/features/profile/presentation/Cubits/medicalassistant/medical_assistant_state.dart';
import 'package:smartcare/features/profile/presentation/views/widget/chat_Bubble.dart';
import 'package:smartcare/features/profile/presentation/views/widget/input_area.dart';
import 'package:smartcare/features/profile/presentation/views/widget/typing_indicator.dart';

class MedicalAssistantBody extends StatelessWidget {
  const MedicalAssistantBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MedicalAssistantControllerLogicbit>();

    return Scaffold(
      appBar: AppThemes.customAppBar(
        title: 'Medical Assistant',
        showBackButton: true,
        isDarkMode: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<MedicalAssistantCubit, MedicalAssistantState>(
              listener: (context, state) {
                cubit.scrollToBottom();
              },
              buildWhen: (prev, curr) => prev.messages != curr.messages,
              builder: (context, state) {
                return ListView.builder(
                  controller: cubit.scrollController,
                  padding: const EdgeInsets.all(16),
                  itemCount:
                      state.messages.length +
                      (state is MedicalAssistantLoading ? 1 : 0),
                  itemBuilder: (_, index) {
                    if (index == state.messages.length) {
                      //last messsage => TypingIndicator()
                      return const TypingIndicator();
                    }

                    return ChatBubble(message: state.messages[index]);
                  },
                );
              },
            ),
          ),

          InputArea(
            controller: cubit.controller,
            onSend: cubit.sendMessageFromController,
            onImageTap: () => cubit.pickAndSendImage(context),
          ),

        ],
      ),
    );
  }
}
