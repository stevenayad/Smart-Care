import 'package:equatable/equatable.dart';

abstract class VoiceState extends Equatable {
  const VoiceState();

  @override
  List<Object?> get props => [];
}

class VoiceInitial extends VoiceState {}

class VoiceRecording extends VoiceState {
  final Duration duration;
  const VoiceRecording({required this.duration});

  @override
  List<Object?> get props => [duration];
}

class VoiceSuccess extends VoiceState {
  final String path;
  const VoiceSuccess({required this.path});

  @override
  List<Object?> get props => [path];
}

class VoiceFailure extends VoiceState {
  final String message;
  const VoiceFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
