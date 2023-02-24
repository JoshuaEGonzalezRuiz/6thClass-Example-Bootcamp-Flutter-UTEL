import 'package:flutter/material.dart';

Widget frameBuilder(BuildContext context, Widget child, int? frame,
    bool wasSynchronouslyLoaded) {
  if (wasSynchronouslyLoaded) {
    return child;
  }
  return AnimatedOpacity(
    opacity: frame == null ? 0 : 1,
    duration: const Duration(seconds: 1),
    curve: Curves.easeOut,
    child: child,
  );
}

Widget loadingBuilder(
    BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
  if (loadingProgress == null) {
    return child;
  }
  return Center(
    child: CircularProgressIndicator(
      value: loadingProgress.expectedTotalBytes != null
          ? loadingProgress.cumulativeBytesLoaded /
              loadingProgress.expectedTotalBytes!
          : null,
    ),
  );
}

Widget imageTemplate(ImageProvider imageProvider, double? imageWidth,
    double? imageHeight, BoxFit? boxFit) {
  return Image(
      width: imageWidth,
      height: imageHeight,
      fit: boxFit,
      frameBuilder: (BuildContext context, Widget child, int? frame,
          bool wasSynchronouslyLoaded) {
        return frameBuilder(context, child, frame, wasSynchronouslyLoaded);
      },
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        return loadingBuilder(context, child, loadingProgress);
      },
      errorBuilder:
          (BuildContext context, Object exception, StackTrace? stackTrace) {
        print("StackTrace: $stackTrace");
        return const Icon(Icons.error);
      },
      image: imageProvider);
}
