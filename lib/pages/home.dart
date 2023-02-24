import 'package:flutter/foundation.dart';

import 'package:class_six_example/pages/images_web_desk.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

import 'audios_web_desk.dart';
import 'images_mobile.dart';
import 'audios.dart';
import 'videos_mobile.dart';
import 'videos_web.dart';
import 'videos_desktop.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> destinations = const [
    NavigationDestination(icon: Icon(Icons.image), label: "Images"),
    NavigationDestination(icon: Icon(Icons.audio_file), label: "Audios"),
    NavigationDestination(icon: Icon(Icons.video_file), label: "Videos"),
  ];
  List pages = [
    !kIsWeb &&
            defaultTargetPlatform != TargetPlatform.linux &&
            defaultTargetPlatform != TargetPlatform.windows
        ? const ImagesMobilePage()
        : const ImagesPage(),
    !kIsWeb &&
            defaultTargetPlatform != TargetPlatform.linux &&
            defaultTargetPlatform != TargetPlatform.windows
        ? const AudiosPage()
        : const AudiosWebPage(),
    kIsWeb ? const VideosWebPage() : const VideosMobilePage()
    /* defaultTargetPlatform == TargetPlatform.linux ||
            defaultTargetPlatform == TargetPlatform.windows
        ? const VideosDesktopPage()
        : SizedBox.shrink() */
  ];
  int destinationIndex = 0;

  PermissionStatus _permissionStatus = PermissionStatus.denied;

  @override
  void initState() {
    if (!kIsWeb &&
        defaultTargetPlatform != TargetPlatform.linux &&
        defaultTargetPlatform != TargetPlatform.windows) {
      checkPermissions();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("U Class 6"),
      ),
      body: Center(
        child: kIsWeb ||
                defaultTargetPlatform == TargetPlatform.linux ||
                defaultTargetPlatform == TargetPlatform.windows
            ? pages.elementAt(destinationIndex)
            : _permissionStatus.isGranted
                ? pages.elementAt(destinationIndex)
                : const CircularProgressIndicator(),
      ),
      //pages.elementAt(destinationIndex),
      bottomNavigationBar: NavigationBar(
        destinations: destinations,
        selectedIndex: destinationIndex,
        onDestinationSelected: (value) {
          setState(() {
            destinationIndex = value;
          });
        },
      ),
    );
  }

  void checkPermissions() async {
    PermissionStatus permissionStatus = await Permission.storage.status;
    if (permissionStatus.isDenied) {
      // We didn't ask for permission yet or the permission has been denied before but not permanently.
      print("Permission denied");
      permissionStatus = await Permission.storage.request();
    }

    if (permissionStatus.isPermanentlyDenied) {
      await openAppSettings();
      return SystemNavigator.pop();
    }

    if (permissionStatus.isGranted) {
      setState(() {
        _permissionStatus = permissionStatus;
      });

      return;
    }

    return checkPermissions();
  }
}
