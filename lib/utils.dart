import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:just_audio/just_audio.dart';

Future<Uint8List?> getFileBytes() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles();

  if (result != null) {
    if (result.files.single.bytes != null) {
      Uint8List file = result.files.single.bytes!;

      print(result.files.single.name);

      return file;
    } else {
      print("Bytes are null");
      return null;
    }
  } else {
    // User canceled the picker
    return null;
  }
}

Future<File?> getFile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles();

  if (result != null) {
    if (result.files.single.path != null) {
      File file = File(result.files.single.path!);

      print(result.files.single.name);

      return file;
    } else {
      print("Path is null");
      return null;
    }
  } else {
    // User canceled the picker
    return null;
  }
}

class MyAudioBytesSource extends StreamAudioSource {
  final Uint8List _audioBuffer;

  MyAudioBytesSource(this._audioBuffer) : super(tag: 'WebAudioSource');

  @override
  Future<StreamAudioResponse> request([int? start, int? end]) async {
    // Returning the stream audio response with the parameters
    return StreamAudioResponse(
      sourceLength: _audioBuffer.length,
      contentLength: (start ?? 0) - (end ?? _audioBuffer.length),
      offset: start ?? 0,
      stream: Stream.fromIterable([_audioBuffer.sublist(start ?? 0, end)]),
      contentType: 'audio/mp4',
    );
  }
}
