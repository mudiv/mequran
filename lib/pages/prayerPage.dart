// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class Prayer extends StatefulWidget {
  const Prayer({super.key});

  @override
  State<Prayer> createState() => _PrayerState();
}

class _PrayerState extends State<Prayer> with WidgetsBindingObserver {
  bool? playeraudio = false;
  final player = AudioPlayer();
  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    player.dispose();
    super.dispose();
  }

  void playYouTubeAudio(String ID) async {
    if (!playeraudio!) {
      if (player.playing) {
        player.stop();
      }
      setState(() {
        playeraudio = true;
      });
      var ytExplode = YoutubeExplode();

      final streamManifest =
          await ytExplode.videos.streamsClient.getManifest(ID);
      final audioStreamInfo = streamManifest.audioOnly.withHighestBitrate();
      String audioDownloadUrl = audioStreamInfo.url.toString();

      await player.setUrl(audioDownloadUrl);
      player.play();
    } else {
      setState(() {
        playeraudio = false;
      });
      await player.pause();
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map data = ModalRoute.of(context)?.settings.arguments as Map;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () async {
                  playYouTubeAudio(data["voiceID"].toString());
                },
                icon: data["voiceID"] == null
                    ? const Text("")
                    : playeraudio == true
                        ? const Icon(Icons.pause_rounded)
                        : const Icon(Icons.play_arrow))
          ],
          title: Text(
            data["name"].toString(),
            style: const TextStyle(fontFamily: "ar", color: Colors.white),
          ),
          backgroundColor: const Color(0xff914cf6),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Column(
              children: [
                const SizedBox(
                  height: 5,
                ),
                Text(
                  data["text"].toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: "Quran",
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 28),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
