import 'dart:convert';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../utils.dart';

class AudiosPage extends StatefulWidget {
  const AudiosPage({super.key});

  @override
  State<AudiosPage> createState() => _AudiosPageState();
}

class _AudiosPageState extends State<AudiosPage> {
  TextEditingController artistNameController =
      TextEditingController(text: "Bruno Mars");
  String artistName = "Bruno Mars";
  String songUrl = "";
  AudioPlayer audioPlayer = AudioPlayer();
  bool online = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(online ? "Online mode" : "Offline mode"),
            Switch(
                value: online,
                onChanged: (value) => setState(() {
                      online = value;
                    }))
          ],
        ),
        !online
            ? Flexible(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        if (audioPlayer.state == PlayerState.playing) {
                          setState(() {
                            audioPlayer.stop();
                          });
                        }

                        setState(() {
                          audioPlayer
                              .play(AssetSource('assets/audios/audio.mp4'));
                        });
                      },
                      onLongPress: () {
                        setState(() {
                          audioPlayer.pause();
                        });
                      },
                      child: const Text("Assets sound")),
                  ElevatedButton(
                      onPressed: () async {
                        if (audioPlayer.state == PlayerState.playing) {
                          setState(() {
                            audioPlayer.stop();
                          });
                        }
                        File? file = await getFile();

                        setState(() {
                          audioPlayer.play(DeviceFileSource(file!.path));
                        });
                      },
                      onLongPress: () {
                        setState(() {
                          audioPlayer.pause();
                        });
                      },
                      child: const Text("Device file sound"))
                ],
              ))
            : Flexible(
                child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.all(20),
                      child: TextField(
                        controller: artistNameController,
                        onSubmitted: (newName) {
                          setState(() {
                            artistName = newName;
                          });
                        },
                      )),
                  Expanded(
                      child: FutureBuilder(
                          future: getArtistSongs(artistName),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                    ConnectionState.done &&
                                snapshot.hasData) {
                              return ListView.builder(
                                  itemCount: snapshot.data?.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () async {
                                        if (audioPlayer.state ==
                                                PlayerState.playing &&
                                            songUrl ==
                                                snapshot.data![index]
                                                    ["preview"]) {
                                          audioPlayer.pause();
                                          return;
                                        }

                                        if (audioPlayer.state !=
                                                PlayerState.playing &&
                                            songUrl ==
                                                snapshot.data![index]
                                                    ["preview"]) {
                                          audioPlayer.resume();
                                          return;
                                        }

                                        songUrl =
                                            snapshot.data![index]["preview"];

                                        audioPlayer.stop();
                                        audioPlayer.play(UrlSource(songUrl));
                                      },
                                      child: Container(
                                          margin: const EdgeInsets.all(10),
                                          padding: const EdgeInsets.all(10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Flexible(
                                                  fit: FlexFit.loose,
                                                  child: Image.network(snapshot
                                                          .data![index]["album"]
                                                      ["cover_small"])),
                                              const SizedBox(
                                                width: 25,
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                        child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          snapshot.data![index]
                                                              ["title"],
                                                          style: const TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 1,
                                                          softWrap: true,
                                                          textAlign:
                                                              TextAlign.start,
                                                        ),
                                                        Text(
                                                            snapshot.data![
                                                                        index]
                                                                    ["artist"]
                                                                ["name"],
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        12))
                                                      ],
                                                    ))
                                                  ],
                                                ),
                                              )
                                            ],
                                          )),
                                    );
                                  });
                            }

                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }))
                ],
              ))
      ],
    );
  }

  Future<List<Map<String, dynamic>>> getArtistSongs(String artistName) async {
    var client = http.Client();
    List<Map<String, dynamic>> dataList = [];

    try {
      var response = await client
          .get(Uri.https('api.deezer.com', 'search', {'q': artistName}));

      if (response.statusCode == 200) {
        var decodedResponse = jsonDecode(response.body) as Map<String, dynamic>;
        var data = decodedResponse["data"] as List<dynamic>;

        for (var element in data) {
          dataList.add(element as Map<String, dynamic>);
        }
        return dataList;
      } else {
        print('Request failed with status: ${response.statusCode}.');
        return dataList;
      }
    } catch (e) {
      print("Connection error: $e");
      client.close();
      return dataList;
    }
  }
}
