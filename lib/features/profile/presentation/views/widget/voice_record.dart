import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/features/profile/presentation/Cubits/voice_cubit/voice_cubit.dart';
import 'package:smartcare/features/profile/presentation/views/widget/voice_record_view.dart';

class VoiceRecorderWidget extends StatelessWidget {
  final Function(String path)? onAudioRecorded;
  final Function(String text)? onTextRecognized;

  const VoiceRecorderWidget({
    super.key,
    this.onAudioRecorded,
    this.onTextRecognized,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VoiceCubit(),
      child: VoiceRecordView(
        onAudioRecorded: onAudioRecorded,
        onTextRecognized: onTextRecognized,
      ),
    );
  }
}
