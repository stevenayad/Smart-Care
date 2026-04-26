import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';

class RecordService {
  final recorder = AudioRecorder();

  Future<String> _getPath() async {
    final dir = await getTemporaryDirectory();
    return '${dir.path}/audio_${DateTime.now().millisecondsSinceEpoch}.m4a';
  }

  Future<String?> start() async {
    final path = await _getPath();

    await recorder.start(
      const RecordConfig(
        encoder: AudioEncoder.aacLc,
        bitRate: 128000,
        sampleRate: 44100,
      ),
      path: path,
    );

    return path;
  }

  Future<String?> stop() async {
    return await recorder.stop();
  }
}