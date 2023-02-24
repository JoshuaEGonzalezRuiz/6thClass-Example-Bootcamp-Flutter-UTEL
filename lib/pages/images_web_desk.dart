import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import '../utils.dart';
import '../widgets/card.dart';
import '../widgets/imageBuilders.dart';

class ImagesPage extends StatefulWidget {
  const ImagesPage({Key? key}) : super(key: key);

  @override
  State<ImagesPage> createState() => _ImagesPageState();
}

class _ImagesPageState extends State<ImagesPage> {
  Uint8List? deviceImage;
  File? deviceFileImage;
  Uint8List? deviceImage1;
  File? deviceFileImage1;

  File? deviceImage2;
  File? deviceImage3;

  String unsplashUrl =
      "https://images.unsplash.com/photo-1675855473080-8c063ca5083c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=688&q=80";
  String assetsImage = 'assets/images/test_image.jpg';

  double width = 250;
  double height = 250;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Divider(),
          const Text("ImageProvider widgets", style: TextStyle(fontSize: 18)),
          Divider(),
          const SizedBox(
            height: 25,
          ),
          const Text("NetworkImage Widget"),
          const SizedBox(
            height: 25,
          ),
          cardTemplate(
              imageTemplate(NetworkImage(unsplashUrl), width, height, null),
              context),
          const SizedBox(
            height: 25,
          ),
          const Text("FileImage Widget"),
          const SizedBox(
            height: 25,
          ),
          Visibility(
              visible: !kIsWeb,
              replacement: cardTemplate(
                  const Text(
                      "En Flutter Web, cuando se quiere obtener una imagen desde la computadora, se recomienda usar el widget MemoryImage para mostrarla"),
                  context),
              child: cardTemplate(
                  deviceImage2 != null
                      ? imageTemplate(FileImage(deviceImage2!), width, height,
                          BoxFit.fitHeight)
                      : ElevatedButton.icon(
                          onPressed: () async {
                            File? file = await getFile();
                            setState(() {
                              deviceImage2 = file;
                            });
                          },
                          label: Text("Obtener archivo del dispositivo"),
                          icon: Icon(Icons.file_download)),
                  context)),
          const SizedBox(
            height: 25,
          ),
          const Text("MemoryImage Widget"),
          const SizedBox(
            height: 25,
          ),
          cardTemplate(
              deviceImage != null || deviceFileImage != null
                  ? imageTemplate(
                      MemoryImage(
                          deviceImage ?? deviceFileImage!.readAsBytesSync()),
                      width,
                      height,
                      BoxFit.fitHeight)
                  : ElevatedButton.icon(
                      onPressed: () async {
                        if (kIsWeb) {
                          Uint8List? file = await getFileBytes();
                          setState(() {
                            deviceImage = file;
                          });
                        } else {
                          File? file = await getFile();
                          setState(() {
                            deviceFileImage = file;
                          });
                        }
                      },
                      label: Text("Obtener archivo del dispositivo"),
                      icon: Icon(Icons.file_download)),
              context),
          const SizedBox(
            height: 25,
          ),
          const Text("AssetImage Widget"),
          const SizedBox(
            height: 25,
          ),
          cardTemplate(
              imageTemplate(
                  AssetImage(assetsImage), width, height, BoxFit.fitHeight),
              context),
          const SizedBox(
            height: 25,
          ),
          const Text("ResizeImage Widget"),
          const SizedBox(
            height: 25,
          ),
          cardTemplate(
              imageTemplate(
                  ResizeImage(
                      width: 180, height: 250, NetworkImage(unsplashUrl)),
                  null,
                  null,
                  null),
              context),
          const SizedBox(
            height: 25,
          ),
          const Divider(),
          const Text("Image widgets", style: TextStyle(fontSize: 18)),
          const Divider(),
          const SizedBox(
            height: 25,
          ),
          const Text("Image.network Widget"),
          const SizedBox(
            height: 25,
          ),
          cardTemplate(
              Image.network(
                unsplashUrl,
                width: width,
                height: height,
                frameBuilder: (BuildContext context, Widget child, int? frame,
                    bool wasSynchronouslyLoaded) {
                  return frameBuilder(
                      context, child, frame, wasSynchronouslyLoaded);
                },
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  return loadingBuilder(context, child, loadingProgress);
                },
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  return const Icon(Icons.error);
                },
              ),
              context),
          const SizedBox(
            height: 25,
          ),
          const Text("Image.file Widget"),
          const SizedBox(
            height: 25,
          ),
          Visibility(
              visible: !kIsWeb,
              replacement: cardTemplate(
                  const Text(
                      "En Flutter Web, cuando se quiere obtener una imagen desde la computadora, se recomienda usar el widget Image.memory para mostrarla"),
                  context),
              child: cardTemplate(
                  deviceImage3 != null
                      ? Image.file(
                          deviceImage3!,
                          width: width,
                          height: height,
                          frameBuilder: (BuildContext context, Widget child,
                              int? frame, bool wasSynchronouslyLoaded) {
                            return frameBuilder(
                                context, child, frame, wasSynchronouslyLoaded);
                          },
                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace? stackTrace) {
                            return const Icon(Icons.error);
                          },
                        )
                      : ElevatedButton.icon(
                          onPressed: () async {
                            File? file = await getFile();
                            setState(() {
                              deviceImage3 = file;
                            });
                          },
                          label: Text("Obtener archivo del dispositivo"),
                          icon: Icon(Icons.file_download)),
                  context)),
          const SizedBox(
            height: 25,
          ),
          const Text("Image.memory Widget"),
          const SizedBox(
            height: 25,
          ),
          cardTemplate(
              deviceImage1 != null || deviceFileImage1 != null
                  ? Image.memory(
                      deviceImage1 ?? deviceFileImage1!.readAsBytesSync(),
                      width: width,
                      height: height,
                      frameBuilder: (BuildContext context, Widget child,
                          int? frame, bool wasSynchronouslyLoaded) {
                        return frameBuilder(
                            context, child, frame, wasSynchronouslyLoaded);
                      },
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace? stackTrace) {
                        return const Icon(Icons.error);
                      },
                    )
                  : ElevatedButton.icon(
                      onPressed: () async {
                        if (kIsWeb) {
                          Uint8List? file = await getFileBytes();
                          setState(() {
                            deviceImage1 = file;
                          });
                        } else {
                          File? file = await getFile();
                          setState(() {
                            deviceFileImage1 = file;
                          });
                        }
                      },
                      label: Text("Obtener archivo del dispositivo"),
                      icon: Icon(Icons.file_download)),
              context),
          const SizedBox(
            height: 25,
          ),
          const Text("Image.asset Widget"),
          const SizedBox(
            height: 25,
          ),
          cardTemplate(
              Image.asset(
                assetsImage,
                width: width,
                height: height,
                frameBuilder: (BuildContext context, Widget child, int? frame,
                    bool wasSynchronouslyLoaded) {
                  return frameBuilder(
                      context, child, frame, wasSynchronouslyLoaded);
                },
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  return const Icon(Icons.error);
                },
              ),
              context),
          const SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }
}
