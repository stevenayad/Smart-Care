import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/features/profile/presentation/Cubits/voice_cubit/voice_cubit.dart';
import 'package:smartcare/features/profile/presentation/Cubits/voice_cubit/voice_state.dart';

class VoiceRecordView extends StatefulWidget {
  final Function(String path)? onAudioRecorded;
  final Function(String text)? onTextRecognized;

  const VoiceRecordView({
    super.key,
    this.onAudioRecorded,
    this.onTextRecognized,
  });

  @override
  State<VoiceRecordView> createState() => _VoiceRecordViewState();
}

class _VoiceRecordViewState extends State<VoiceRecordView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.4).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<VoiceCubit>();

    return BlocConsumer<VoiceCubit, VoiceState>(
      listener: (context, state) {
        if (state is VoiceRecording) {
          _animationController.forward();
        } else {
          _animationController.reverse();
        }

        if (state is VoiceSuccess) {
          widget.onAudioRecorded?.call(state.path);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Voice message sent successfully!'),
              backgroundColor: Colors.green,
            ),
          );
        }

        if (state is VoiceFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      builder: (context, state) {
        final isRecording = state is VoiceRecording;
        final duration = state is VoiceRecording
            ? state.duration
            : Duration.zero;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: isRecording ? Colors.grey.shade100 : Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// TEXT / RECORDING UI
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                transitionBuilder: (child, animation) =>
                    FadeTransition(opacity: animation, child: child),
                child: isRecording
                    ? Row(
                        key: const ValueKey("recording"),
                        children: [
                          const Icon(Icons.mic, color: Colors.red, size: 20),
                          const SizedBox(width: 6),
                          Text(
                            _formatDuration(duration),
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(width: 10),

                          /// WAVEFORM (isolated rebuild)
                          SizedBox(
                            width: 120,
                            child: BlocBuilder<VoiceCubit, VoiceState>(
                              buildWhen: (prev, curr) => curr is VoiceRecording,
                              builder: (context, state) {
                                return AudioWaveforms(
                                  size: const Size(double.infinity, 28),
                                  recorderController: cubit.recorderController,
                                  waveStyle: const WaveStyle(
                                    waveColor: Colors.blueAccent,
                                    spacing: 5,
                                    showMiddleLine: false,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      )
                    : const Text(
                        "Hold to record",
                        key: ValueKey("idle"),
                        style: TextStyle(color: Colors.grey),
                      ),
              ),

              const SizedBox(width: 10),

              /// BUTTON
              GestureDetector(
                onLongPressStart: (_) {
                  cubit.startRecording();
                },
                onLongPressEnd: (_) {
                  if (isRecording) {
                    cubit.stopRecording();
                  }
                },
                onHorizontalDragUpdate: (details) {
                  if (isRecording && details.delta.dx < -8) {
                    cubit.cancelRecording();
                  }
                },
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isRecording ? Colors.red : Colors.blue,
                      borderRadius: BorderRadius.circular(
                        isRecording ? 16 : 50,
                      ),
                    ),
                    child: const Icon(Icons.mic, color: Colors.white, size: 26),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
