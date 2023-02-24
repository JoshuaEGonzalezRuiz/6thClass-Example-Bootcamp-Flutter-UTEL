import 'dart:convert';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart' as DesktopPlayer;
import 'package:just_audio/just_audio.dart' as WebPlayer;
import 'package:class_six_example/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AudiosWebPage extends StatefulWidget {
  const AudiosWebPage({super.key});

  @override
  State<AudiosWebPage> createState() => _AudiosWebPageState();
}

class _AudiosWebPageState extends State<AudiosWebPage> {
  TextEditingController artistNameController =
      TextEditingController(text: "Bruno Mars");
  String artistName = "Bruno Mars";
  String songUrl = "";
  DesktopPlayer.AudioPlayer desktopAudioPlayer = DesktopPlayer.AudioPlayer();
  WebPlayer.AudioPlayer webAudioPlayer = WebPlayer.AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Offline mode"),
          ],
        ),
        Flexible(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () async {
                  if (!kIsWeb) {
                    if (desktopAudioPlayer.state ==
                        DesktopPlayer.PlayerState.playing) {
                      setState(() {
                        desktopAudioPlayer.stop();
                      });
                    }

                    setState(() {
                      desktopAudioPlayer
                          .play(DesktopPlayer.AssetSource('/audios/audio.mp4'));
                    });
                  } else {
                    if (webAudioPlayer.playing) {
                      setState(() {
                        webAudioPlayer.stop();
                      });
                    }

                    await webAudioPlayer.setAsset('/audios/audio.mp4');

                    setState(() {
                      webAudioPlayer.play();
                    });
                  }
                },
                onLongPress: () {
                  stopPlaying();
                },
                child: const Text("Reproducir archivo desde Assets")),
            ElevatedButton(
                onPressed: () async {
                  if (!kIsWeb) {
                    if (desktopAudioPlayer.state ==
                        DesktopPlayer.PlayerState.playing) {
                      setState(() {
                        desktopAudioPlayer.stop();
                      });
                    }
                    if (kIsWeb) {
                      Uint8List? file = await getFileBytes();

                      setState(() {
                        desktopAudioPlayer.play(DesktopPlayer.DeviceFileSource(
                            File.fromRawPath(file!).path));
                      });
                    } else {
                      File? file = await getFile();

                      setState(() {
                        desktopAudioPlayer
                            .play(DesktopPlayer.DeviceFileSource(file!.path));
                      });
                    }
                  } else {
                    if (webAudioPlayer.playing) {
                      setState(() {
                        webAudioPlayer.stop();
                      });
                    }

                    Uint8List? file = await getFileBytes();

                    await webAudioPlayer
                        .setAudioSource(MyAudioBytesSource(file!));

                    setState(() {
                      webAudioPlayer.play();
                    });
                  }
                },
                onLongPress: () {
                  stopPlaying();
                },
                child: const Text("Reproducir archivo desde el dispositivo"))
          ],
        ))
      ],
    );
  }

  void stopPlaying() {
    if (!kIsWeb) {
      setState(() {
        desktopAudioPlayer.pause();
      });
    } else {
      setState(() {
        webAudioPlayer.pause();
      });
    }
  }
}
