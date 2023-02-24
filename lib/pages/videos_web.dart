//Para poder usar este bloque de código necesitas hacer lo siguiente:
//Ve al pubspec.yaml y comenta la línea 44 con un # y descomenta la 45 quitando el #
//Guarda tus cambios y realiza en la terminal un flutter clean y luego un flutter pub get
//En el archivo main.dart comenta las líneas 1 y 8
//Comenta el código del archivo videos_desktop.dart y descomenta el código de aquí.
//En el archivo home.dart comenta el bloque de codigo que comprende la linea 40 - 42 y descomenta la línea 39
//Descomenta el código del archiv videos_mobile.dart

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class VideosWebPage extends StatefulWidget {
  const VideosWebPage({super.key});

  @override
  State<VideosWebPage> createState() => _VideosWebPageState();
}

class _VideosWebPageState extends State<VideosWebPage> {
  String assetsFile = "assets/videos/video.mp4";

  YoutubePlayerController? youtubePlayerController;

  VideoPlayerController? assetsFileController;

  bool isPlaying = false;

  @override
  void initState() {
    youtubePlayerController = YoutubePlayerController.fromVideoId(
      videoId: 'V6ankcHn85k',
      autoPlay: false,
      params: const YoutubePlayerParams(showFullscreenButton: true),
    );

    assetsFileController = VideoPlayerController.asset(assetsFile)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 25,
          ),
          const Divider(),
          const Text("Assets video"),
          const Divider(),
          assetsFileController!.value.isInitialized
              ? Column(
                  children: [
                    SizedBox(
                      height: 350,
                      width: 500,
                      child: AspectRatio(
                        aspectRatio: assetsFileController!.value.aspectRatio,
                        child: VideoPlayer(assetsFileController!),
                      ),
                    ),
                    ElevatedButton.icon(
                        onPressed: () {
                          if (assetsFileController!.value.isPlaying) {
                            assetsFileController!.pause();
                          } else {
                            assetsFileController!.play();
                          }

                          setState(() {
                            isPlaying = !isPlaying;
                          });
                        },
                        icon: isPlaying
                            ? Icon(Icons.pause)
                            : Icon(Icons.play_arrow),
                        label: isPlaying ? Text("Pause") : Text("Play"))
                  ],
                )
              : const SizedBox.shrink(),
          const SizedBox(
            height: 25,
          ),
          const Divider(),
          const Text("File video"),
          const Divider(),
          Text("Esta funcion no está disponible en esta plataforma"),
          const Divider(),
          const Text("Youtube video"),
          const Divider(),
          youtubePlayerController != null
              ? SizedBox(
                  height: 350,
                  width: 500,
                  child: YoutubePlayer(
                    controller: youtubePlayerController!,
                    aspectRatio: 19 / 9,
                  ),
                )
              : Text(
                  "El reproductor de Youtube no está disponible en esta plataforma"),
          const SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }
}
