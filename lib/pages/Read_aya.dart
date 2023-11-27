// ignore_for_file: unrelated_type_equality_checks, non_constant_identifier_names, file_names, annotate_overrides

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:just_audio/just_audio.dart';
import 'package:quran/quran.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReadAya extends StatefulWidget {
  const ReadAya({super.key});

  @override
  State<ReadAya> createState() => _ReadAyaState();
}

ShowLoading(context) {
  return showDialog(
    context: context,
    builder: (context) {
      return const AlertDialog(
        title: Text(
          "صدق الله العلي العظيم",
          textAlign: TextAlign.center,
          style: TextStyle(fontFamily: "Quran"),
        ),
        content: SizedBox(
          width: 50,
          height: 100,
          child: Column(
            children: [
              Text(
                "صدق الله العلي العظيم",
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: "Quran"),
              ),
            ],
          ),
        ),
      );
    },
  );
}

class _ReadAyaState extends State<ReadAya> with WidgetsBindingObserver {
  final InAppReview inAppReview = InAppReview.instance;

  String? reader;
  bool? playeraudio = false, ttb;
  final player = AudioPlayer();
  final AutoScrollController _scrollController = AutoScrollController();
  int Line = 0;
  void _scrollToIndex(int index) {
    _scrollController.scrollToIndex(index,
        preferPosition: AutoScrollPosition.begin);
  }

  void playSequentialAudio(int startNumber, int endNumber, ayaNumbers) async {
    String ayaNumber = ayaNumbers.toString().padLeft(3, "0");
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (!playeraudio!) {
      setState(() {
        playeraudio = true;
      });

      for (int i = startNumber; i <= endNumber && playeraudio!;) {
        String j = i.toString().padLeft(3, "0");

        final url = 'https://dwn.alkafeel.net/quran/$reader/$ayaNumber$j.mp3';
        await player.setUrl(url);
        await player.play();

        if (playeraudio!) {
          await Future.delayed(
              Duration(milliseconds: player.duration!.inMilliseconds),
              () async {
            if (playeraudio!) {
              i++;
              setState(() {
                Line++;
              });
              await prefs.setString('aya', "$Line");
              _scrollToIndex(Line);
            }
          });
        }

        if (i - 1 == endNumber) {
          setState(() {
            Line = 0;
          });
          _scrollToIndex(0);
          setState(() {
            playeraudio = false;
          });
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('aya', "0");
          if (await inAppReview.isAvailable()) {
            inAppReview.requestReview();
          }
        }
      }
    } else {
      setState(() {
        playeraudio = false;
      });

      await player.stop();
    }
  }

  SaveData(data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? Reader = prefs.getString('reader');
    await prefs.setString('name', data["name"]);
    String? Ay = prefs.getString('aya');
    await prefs.setString('sora', (data["number"] - 1).toString());

    if (Reader == null) {
      await prefs.setString('reader', 'altamar');
      setState(() {
        reader = "altamar";
      });
    } else {
      setState(() {
        reader = Reader;
      });
    }
    if (Ay == null) {
      await prefs.setString('aya', '0');
    } else {
      if (data["tt"]) {
        await Future.delayed(const Duration(milliseconds: 10), () {
          setState(() {
            Line += int.parse(Ay);
          });

          _scrollToIndex(int.parse(Ay));
        });
      }
    }
  }

  RsaveData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (!ttb!) {
      await prefs.setString('aya', '0');
    }
  }

  @override
  void initState() {
    RsaveData();
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final Map data = ModalRoute.of(context)?.settings.arguments as Map;
      SaveData(data);
    });
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    player.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Map data = ModalRoute.of(context)?.settings.arguments as Map;
    ttb = data["tt"];
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xff914cf6),
          title: Text(
            data["name"],
            style: const TextStyle(fontFamily: "ar", color: Colors.white),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  playSequentialAudio(
                      Line + 1, data["soar"].length, data["number"]);
                },
                icon: playeraudio == true
                    ? const Icon(Icons.pause_rounded)
                    : const Icon(Icons.play_arrow)),
            IconButton(
                onPressed: () {
                  showModalBottomSheet(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      backgroundColor: Colors.white,
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                            height: 450,
                            decoration: const BoxDecoration(
                                color: Color(0xff3e3e42),
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(15),
                                    topLeft: Radius.circular(15))),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Container(
                                    width: 50,
                                    height: 2,
                                    color: const Color(0xff8789A3),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Column(
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          final SharedPreferences prefs =
                                              await SharedPreferences
                                                  .getInstance();
                                          await prefs
                                              .setString(
                                                  'reader', 'haiderghalbi')
                                              .then((value) {
                                            setState(() {
                                              reader = "haiderghalbi";
                                            });
                                            Navigator.of(context).pop();
                                          });
                                        },
                                        child: const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              "القارئ حيدر الغالبي",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontFamily: "ar"),
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Icon(
                                              Icons.volume_up_rounded,
                                              color: Colors.white,
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          final SharedPreferences prefs =
                                              await SharedPreferences
                                                  .getInstance();
                                          await prefs
                                              .setString('reader', 'altamar')
                                              .then((value) {
                                            setState(() {
                                              reader = "altamar";
                                            });
                                            Navigator.of(context).pop();
                                          });
                                        },
                                        child: const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              "القارئ ميثم التمار",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontFamily: "ar"),
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Icon(
                                              Icons.volume_up_rounded,
                                              color: Colors.white,
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          final SharedPreferences prefs =
                                              await SharedPreferences
                                                  .getInstance();
                                          await prefs
                                              .setString('reader', 'ahmadneana')
                                              .then((value) {
                                            setState(() {
                                              reader = "ahmadneana";
                                            });
                                            Navigator.of(context).pop();
                                          });
                                        },
                                        child: const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              "القارئ احمد نعينع",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontFamily: "ar"),
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Icon(
                                              Icons.volume_up_rounded,
                                              color: Colors.white,
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          final SharedPreferences prefs =
                                              await SharedPreferences
                                                  .getInstance();
                                          await prefs
                                              .setString(
                                                  'reader', 'aameralkadhimi')
                                              .then((value) {
                                            setState(() {
                                              reader = "aameralkadhimi";
                                            });
                                            Navigator.of(context).pop();
                                          });
                                        },
                                        child: const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              "القارئ عامر الكاظمي",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontFamily: "ar"),
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Icon(
                                              Icons.volume_up_rounded,
                                              color: Colors.white,
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          final SharedPreferences prefs =
                                              await SharedPreferences
                                                  .getInstance();
                                          await prefs
                                              .setString('reader', 'karim')
                                              .then((value) {
                                            setState(() {
                                              reader = "karim";
                                            });
                                            Navigator.of(context).pop();
                                          });
                                        },
                                        child: const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              "القارئ كريم منصوري",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontFamily: "ar"),
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Icon(
                                              Icons.volume_up_rounded,
                                              color: Colors.white,
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          final SharedPreferences prefs =
                                              await SharedPreferences
                                                  .getInstance();
                                          await prefs
                                              .setString(
                                                  'reader', 'arefalkadhimi')
                                              .then((value) {
                                            setState(() {
                                              reader = "arefalkadhimi";
                                            });
                                            Navigator.of(context).pop();
                                          });
                                        },
                                        child: const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              "القارئ رافع العامري",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontFamily: "ar"),
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Icon(
                                              Icons.volume_up_rounded,
                                              color: Colors.white,
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          final SharedPreferences prefs =
                                              await SharedPreferences
                                                  .getInstance();
                                          await prefs
                                              .setString('reader', 'namh')
                                              .then((value) {
                                            setState(() {
                                              reader = "namh";
                                            });
                                            Navigator.of(context).pop();
                                          });
                                        },
                                        child: const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              "القارئ نعمة الحسان",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontFamily: "ar"),
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Icon(
                                              Icons.volume_up_rounded,
                                              color: Colors.white,
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          final SharedPreferences prefs =
                                              await SharedPreferences
                                                  .getInstance();
                                          await prefs
                                              .setString('reader', 'addel')
                                              .then((value) {
                                            setState(() {
                                              reader = "addel";
                                            });
                                            Navigator.of(context).pop();
                                          });
                                        },
                                        child: const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              "القارئ عادل الكربلائي",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontFamily: "ar"),
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Icon(
                                              Icons.volume_up_rounded,
                                              color: Colors.white,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ));
                      });
                },
                icon: const Icon(Icons.list_alt_outlined)),
          ],
          centerTitle: true,
        ),
        body: ListView.builder(
          controller: _scrollController,
          itemCount: data["soar"].length,
          itemBuilder: (context, index) {
            return AutoScrollTag(
              controller: _scrollController,
              index: index,
              key: ValueKey(index),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  index < 1
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              width: 370,
                              height: 250,
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0xffDF98FA),
                                    Color(0xff9055FF),
                                  ],
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    data["name"],
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 30,
                                        fontFamily: "Quran"),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    width: 200,
                                    height: 0.7,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "آياتها",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontFamily: "Quran"),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Container(
                                        width: 5,
                                        height: 5,
                                        decoration: const BoxDecoration(
                                            color: Color(0xffFFFFFF),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        data["soar"].length.toString(),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontFamily: "Quran"),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      const Text(
                                        "اية",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontFamily: "Quran"),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  data["number"] == 9
                                      ? const Text("")
                                      : SvgPicture.asset(
                                          "Asset/image/Alpsmala.svg"),
                                ],
                              ),
                            ),
                          ),
                        )
                      : const SizedBox(),
                  const SizedBox(
                    height: 5,
                  ),
                  InkWell(
                    onLongPress: () {
                      showModalBottomSheet(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        backgroundColor: Colors.white,
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                              height: 150,
                              decoration: const BoxDecoration(
                                  color: Color(0xff3e3e42),
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(15),
                                      topLeft: Radius.circular(15))),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Container(
                                      width: 50,
                                      height: 2,
                                      color: const Color(0xff8789A3),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Column(
                                      children: [
                                        InkWell(
                                          onTap: () async {
                                            await Share.shareWithResult(
                                                '${data["soar"][index]["aya"]}\n\n • حمل التطبيق الان :\n https://play.google.com/store/apps/details?id=com.mequran.dev&pli=1');
                                          },
                                          child: const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                "مشاركة الآية القرآنية",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                    fontFamily: "ar"),
                                              ),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              Icon(
                                                Icons.share,
                                                color: Colors.white,
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Clipboard.setData(ClipboardData(
                                                    text:
                                                        '${data["soar"][index]["aya"]}\n\n • حمل التطبيق الان :\n https://play.google.com/store/apps/details?id=com.mequran.dev&pli=1'))
                                                .then((value) {
                                          
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content:
                                                      Text("تم نسخ النص بنجاح"),
                                                  duration:
                                                      Duration(seconds: 2),
                                                ),
                                              );
                                            });
                                          },
                                          child: const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                "نسخ الآية القرآنية",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                    fontFamily: "ar"),
                                              ),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              Icon(
                                                Icons.copy,
                                                color: Colors.white,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ));
                        },
                      );
                    },
                    onTap: () async {
                      if (!player.playing) {
                        setState(() {
                          playeraudio = false;
                        });
                        setState(
                          () {
                            Line = index;
                          },
                        );
                      }
                      final SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.setString('aya', "$index");
                    },
                    child: Container(
                      width: double.infinity,
                      color: index == Line
                          ? Theme.of(context).colorScheme.onPrimary
                          : index % 2 == 0
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.outline,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: data["soar"][index]["aya"],
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    fontSize: 25,
                                    fontFamily: "Quran"),
                              ),
                              const TextSpan(text: "  "),
                              TextSpan(
                                text: getVerseEndSymbol(
                                    int.parse(
                                        data["soar"][index]["naumberaya"]),
                                    arabicNumeral: true),
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 197, 52, 255),
                                  fontSize: 25,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
