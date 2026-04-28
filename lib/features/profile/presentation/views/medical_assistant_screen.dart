import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/core/api/api_consumer.dart';
import 'package:smartcare/core/api/dio_consumer.dart' show DioConsumer;
import 'package:smartcare/features/profile/data/repo/medical_assistant_repository.dart';
import 'package:smartcare/features/profile/presentation/Cubits/medical_assistant_controller/medical_assistant_controller_cubit.dart';
import 'package:smartcare/features/profile/presentation/Cubits/medicalassistant/medical_assistant_cubit.dart';
import 'package:smartcare/features/profile/presentation/views/widget/medical_assistant_body.dart';

class MedicalAssistantScreen extends StatelessWidget {
  const MedicalAssistantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => MedicalAssistantCubit(
            MedicalAssistantApiService(DioConsumer(Dio())),
          ),
        ),

        BlocProvider(
          create: (context) => MedicalAssistantControllerLogicbit(
            chatCubit: context.read<MedicalAssistantCubit>(),
          ),
        ),
      ],
      child: const MedicalAssistantBody(),
    );
  }
}
