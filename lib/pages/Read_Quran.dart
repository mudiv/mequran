// ignore_for_file: non_constant_identifier_names, duplicate_ignore, file_names, unrelated_type_equality_checks, unused_element

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReadQuran extends StatefulWidget {
  const ReadQuran({super.key});

  @override
  State<ReadQuran> createState() => _ReadQuranState();
}

class _ReadQuranState extends State<ReadQuran> {
  String? name, ayaNum, soraNum;
  final AutoScrollController _scrollController = AutoScrollController();
  Map<String, dynamic>? jsonData;
  // ignore: non_constant_identifier_names
  Future<Map<String, dynamic>?> LoadData3() async {
    final JsonFile = await rootBundle.loadString("Asset/Data/dataQuran.json");
    jsonData = json.decode(JsonFile);

    return jsonData;
  }

  void _scrollToIndex(int index) {
    _scrollController.scrollToIndex(index,
        preferPosition: AutoScrollPosition.begin);
  }

  RsaveData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString('name');
    if (name != Null) {
      ayaNum = prefs.getString('aya');
      soraNum = prefs.getString('sora');
    }
  }

  @override
  void initState() {
    RsaveData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xff914cf6),
          title: const Text(
            "القرآن الكريم",
            style: TextStyle(fontFamily: "ar", color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: LoadData3(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                controller: _scrollController,
                itemCount: snapshot.data["data"].length,
                itemBuilder: (context, index) {
                  return AutoScrollTag(
                    controller: _scrollController,
                    index: index,
                    key: ValueKey(index),
                    child: Column(
                      children: [
                        index < 1
                            ? name != null
                                ? InkWell(
                                    onTap: () => Navigator.pushNamed(
                                      context,
                                      '/ReadAya',
                                      arguments: {
                                        "soar": snapshot.data!['data']
                                            [int.parse(soraNum!)]["soar"],
                                        "name": snapshot.data!['data']
                                            [int.parse(soraNum!)]["name"],
                                        "number": snapshot.data!['data']
                                            [int.parse(soraNum!)]["number"],
                                        "tt": true
                                      },
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: Container(
                                        clipBehavior: Clip.antiAlias,
                                        width: double.infinity,
                                        height: 131,
                                        decoration: const BoxDecoration(
                                          gradient: LinearGradient(
                                              end: Alignment.topRight,
                                              colors: [
                                                Color(0xffDF98FA),
                                                Color(0xff9055FF),
                                              ]),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                        ),
                                        child: Stack(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(15),
                                              child: Row(
                                                children: [
                                                  Align(
                                                    alignment: const Alignment(
                                                        0.9, -0.7),
                                                    child: SvgPicture.asset(
                                                        "Asset/image/Vector.svg"),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  const Align(
                                                    alignment:
                                                        Alignment(0.9, -0.9),
                                                    child: Text(
                                                      "اكمل القراءة",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 17,
                                                          fontFamily: "ar"),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(15),
                                              child: Align(
                                                alignment:
                                                    const Alignment(1, 0.2),
                                                child: Text(
                                                  name!,
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 27,
                                                      fontFamily: "Quran"),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(15),
                                              child: Align(
                                                alignment:
                                                    const Alignment(1, 1.3),
                                                child: Text(
                                                  "اية : ${int.parse(ayaNum!) + 1}",
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 27,
                                                      fontFamily: "Quran"),
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment:
                                                  const Alignment(-1.2, 10),
                                              child: SvgPicture.asset(
                                                  "Asset/image/1.svg"),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                : const SizedBox(
                                    height: 10,
                                  )
                            : const SizedBox(),
                        InkWell(
                          onTap: () => Navigator.pushNamed(
                            context,
                            '/ReadAya',
                            arguments: {
                              "soar": snapshot.data!['data'][index]["soar"],
                              "name": snapshot.data!['data'][index]["name"],
                              "number": snapshot.data!['data'][index]["number"],
                              "tt": false
                            },
                          ),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Text(
                                    snapshot.data["data"][index]["number"]
                                        .toString(),
                                    style: const TextStyle(
                                        color: Color(0xff863ED5),
                                        fontSize: 15,
                                        fontFamily: "Quran"),
                                  ),
                                  SvgPicture.asset(
                                    "Asset/image/Qr.svg",
                                    width: 40,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot.data["data"][index]["name"],
                                    style: const TextStyle(
                                        color: Color(0xff863ED5),
                                        fontSize: 23,
                                        fontFamily: "Quran"),
                                  ),
                                  Text(
                                    "${snapshot.data["data"][index]["soar"].length} آية",
                                    style: const TextStyle(
                                        color: Color(0xff8789A3),
                                        fontSize: 18,
                                        fontFamily: "Quran"),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 1,
                        ),
                        const Divider()
                      ],
                    ),
                  );
                },
              );
            }
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xff9055FF),
              ),
            );
          },
        ),
      ),
    );
  }
}
