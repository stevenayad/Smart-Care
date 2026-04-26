import 'package:speech_to_text/speech_to_text.dart';

class SpeechService {
  final SpeechToText speech = SpeechToText();

  Future<bool> init() async {
    return await speech.initialize();
  }

  void start(Function(String) onResult) {
    speech.listen(
      onResult: (result) {
        onResult(result.recognizedWords);
      },
    );
  }

  void stop() {
    speech.stop();
  }
}