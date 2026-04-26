import 'dart:async';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'voice_state.dart';
import 'dart:io';

class VoiceCubit extends Cubit<VoiceState> {
  final RecorderController recorderController = RecorderController();
  Timer? _timer;
  int _seconds = 0;

  VoiceCubit() : super(VoiceInitial());

  Future<void> startRecording() async {
    try {
      final hasPermission = await recorderController.checkPermission();
      if (!hasPermission) {
        emit(const VoiceFailure(message: 'Permission denied'));
        return;
      }

      final directory = await getApplicationDocumentsDirectory();
      final path = '${directory.path}/recording_${DateTime.now().millisecondsSinceEpoch}.m4a';

      await recorderController.record(path: path);
      _seconds = 0;
      _startTimer();
      emit(VoiceRecording(duration: Duration(seconds: _seconds)));
    } catch (e) {
      emit(VoiceFailure(message: e.toString()));
    }
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _seconds++;
      if (state is VoiceRecording) {
        emit(VoiceRecording(duration: Duration(seconds: _seconds)));
      }
    });
  }

  Future<void> stopRecording() async {
    try {
      _timer?.cancel();
      final path = await recorderController.stop();
      if (path != null) {
        sendAudio(path);
      } else {
        emit(VoiceInitial());
      }
    } catch (e) {
      emit(VoiceFailure(message: e.toString()));
    }
  }

  Future<void> cancelRecording() async {
    try {
      _timer?.cancel();
      await recorderController.stop();
      emit(VoiceInitial());
    } catch (e) {
      emit(VoiceFailure(message: e.toString()));
    }
  }

  Future<void> sendAudio(String path) async {
    // Implement sending logic here (e.g., upload to server)
    // For now, we'll just emit success with the path
    emit(VoiceSuccess(path: path));
    
    // Optionally reset to initial after a short delay or stay in success
    // emit(VoiceInitial());
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    recorderController.dispose();
    return super.close();
  }
}
