part of 'semanticsearch_cubit.dart';

sealed class SemanticsearchState extends Equatable {
  const SemanticsearchState();

  @override
  List<Object> get props => [];
}

final class SemanticsearchInitial extends SemanticsearchState {}

final class Semanticsearchloading extends SemanticsearchState {}

final class SemanticsearchSuccess extends SemanticsearchState {
  final SemanticModel semanticModel;
  SemanticsearchSuccess({required this.semanticModel});
}

final class SemanticsearchFailure extends SemanticsearchState {
  final String errMessage;
  SemanticsearchFailure({required this.errMessage});
}

final class VoiceSemanticsearchSuccess extends SemanticsearchState {
  final List<VoiceSemanticDatum> voiceSemanticSearch;
  VoiceSemanticsearchSuccess({required this.voiceSemanticSearch});
}

final class VoiceSemanticsearchFailure extends SemanticsearchState {
  final String errMessage;
  VoiceSemanticsearchFailure({required this.errMessage});
}
