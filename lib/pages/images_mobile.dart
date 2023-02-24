import 'dart:io';

import 'package:class_six_example/widgets/card.dart';
import 'package:class_six_example/widgets/imageBuilders.dart';
import 'package:flutter/material.dart';

class ImagesMobilePage extends StatefulWidget {
  const ImagesMobilePage({super.key});

  @override
  State<ImagesMobilePage> createState() => _ImagesMobilePageState();
}

class _ImagesMobilePageState extends State<ImagesMobilePage> {
  File deviceImage = File('/storage/sdcard0/Pictures/Gengar.jpg');
  File deviceImage2 = File('/storage/sdcard0/Pictures/Escandalosos.jpg');
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
          cardTemplate(
              imageTemplate(
                  FileImage(deviceImage), width, height, BoxFit.fitHeight),
              context),
          const SizedBox(
            height: 25,
          ),
          const Text("MemoryImage Widget"),
          const SizedBox(
            height: 25,
          ),
          cardTemplate(
              imageTemplate(MemoryImage(deviceImage2.readAsBytesSync()), width,
                  height, BoxFit.fitHeight),
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
          cardTemplate(
              Image.file(
                deviceImage,
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
          const Text("Image.memory Widget"),
          const SizedBox(
            height: 25,
          ),
          cardTemplate(
              Image.memory(
                deviceImage2.readAsBytesSync(),
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
