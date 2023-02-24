//Para poder usar este bloque de código necesitas hacer lo siguiente:
//Ve al pubspec.yaml y comenta la línea 45 con un # y descomenta la 44 quitando el #
//Guarda tus cambios y realiza en la terminal un flutter clean y luego un flutter pub get
//En el archivo main.dart descomenta las líneas 1 y 8
//Comenta el código de los archivos videos_web.dart y videos_mobile.dart y descomenta el código de aquí.
//En el archivo home.dart descomenta el bloque de codigo que comprende la linea 40 - 43 y comenta la línea 39
//Comenta todo el código del archivo videos_mobile.dart

/* import 'dart:io';

import 'package:dart_vlc/dart_vlc.dart';
import 'package:flutter/material.dart';

import '../utils.dart';

class VideosDesktopPage extends StatefulWidget {
  const VideosDesktopPage({super.key});

  @override
  State<VideosDesktopPage> createState() => _VideosDesktopPageState();
}

class _VideosDesktopPageState extends State<VideosDesktopPage> {
  String assetsFile = "assets/videos/video.mp4";

  File? deviceFile;

  Player assetsFilePlayer = Player(id: 0);

  Player deviceFilePlayer = Player(id: 1);

  @override
  void initState() {
    assetsFilePlayer.add(Media.asset(assetsFile));
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
          SizedBox(
            height: 350,
            width: 500,
            child: GestureDetector(
              onTap: () {
                if (assetsFilePlayer.playback.isPlaying) {
                  setState(() {
                    assetsFilePlayer.pause();
                  });
                } else {
                  setState(() {
                    assetsFilePlayer.play();
                  });
                }
              },
              onDoubleTap: () {
                setState(() {
                  assetsFilePlayer.stop();
                });
              },
              child: Video(player: assetsFilePlayer),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          const Divider(),
          const Text("File video"),
          const Divider(),
          deviceFile != null
              ? SizedBox(
                  height: 350,
                  width: 500,
                  child: GestureDetector(
                    onTap: () {
                      if (deviceFilePlayer.playback.isPlaying) {
                        setState(() {
                          deviceFilePlayer.pause();
                        });
                      } else {
                        setState(() {
                          deviceFilePlayer.play();
                        });
                      }
                    },
                    onDoubleTap: () {
                      setState(() {
                        deviceFilePlayer.stop();
                      });
                    },
                    child: Video(player: deviceFilePlayer),
                  ))
              : ElevatedButton.icon(
                  onPressed: () async {
                    File? file = await getFile();

                    deviceFilePlayer.add(Media.file(file!));

                    setState(() {
                      deviceFile = file;
                    });
                  },
                  label: Text("Obtener archivo del dispositivo"),
                  icon: Icon(Icons.file_download)),
          const Divider(),
          const Text("Youtube video"),
          const Divider(),
          Text(
              "El reproductor de Youtube no está disponible en esta plataforma"),
          const SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }
}
 */