import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class Supplications extends StatefulWidget {
  const Supplications({super.key});

  @override
  State<Supplications> createState() => _SupplicationsState();
}

class _SupplicationsState extends State<Supplications> {


  Map<String, dynamic>? jsonData;

  Future<Map<String, dynamic>?> LoadData2() async {
    final JsonFile = await rootBundle.loadString("Asset/Data/dataDon2.json");
    jsonData = json.decode(JsonFile);
    return jsonData;
  }

  Future<Map<String, dynamic>?> LoadData3() async {
    final JsonFile = await rootBundle.loadString("Asset/Data/dataDoa3.json");
    jsonData = json.decode(JsonFile);
    
    return jsonData;
  }

  Future<Map<String, dynamic>?> LoadData() async {
    final JsonFile = await rootBundle.loadString("Asset/Data/dataDoa.json");
    Map<String, dynamic>? jsonData = json.decode(JsonFile);
    return jsonData;
  }


  @override
  void dispose() {
   
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: const Color(0xff914cf6),
            bottom: const TabBar(
              indicatorWeight: 3,
              indicatorColor: Color(0xffDF98FA),
              tabs: [
                Tab(
                  child: Text(
                    "أدعية الايام",
                    style: TextStyle(fontFamily: "Quran",fontSize: 15),
                  ),
                ),
                Tab(
                  child: Text(
                    "تعقيبات الصلاة",
                    style: TextStyle(fontFamily: "Quran",fontSize: 15),
                  ),
                ),
                Tab(
                  child: Text(
                    "الأدعية العامة",
                    style: TextStyle(fontFamily: "Quran",fontSize: 15),
                  ),
                ),
              ],
            ),
            title: const Text(
              "الأدعية و الأذكار",
              style: TextStyle(fontFamily: "ar", color: Colors.white),
            ),
            centerTitle: true,
          ),
          body: TabBarView(
            children: [
              FutureBuilder(
                future: LoadData(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data["data"].length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(5),
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, '/Prayer',
                                      arguments: {
                                        "voiceID": snapshot.data!['data'][index]
                                            ["voiceID"],
                                        "name": snapshot.data!['data'][index]
                                            ["name"],
                                        "text": snapshot.data!['data'][index]
                                            ["text"],
                                        "id": snapshot.data!['data'][index]
                                            ["id"]
                                      });
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 50,
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                        end: Alignment.centerRight,
                                        colors: [
                                          Color(0xff9055FF),
                                          Color(0xffDF98FA),
                                        ]),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  child: Center(
                                      child: Text(
                                    snapshot.data!['data'][index]["name"]
                                        .toString(),
                                    style: const TextStyle(
                                        fontFamily: "Quran",
                                        color: Colors.white,
                                        fontSize: 25),
                                  )),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    );
                  }
                  return const Center(
                      child: CircularProgressIndicator(
                    color: Color(0xff9055FF),
                  ));
                },
              ),
              FutureBuilder(
                future: LoadData2(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data["data"].length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(5),
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    '/Prayer',
                                    arguments: {
                                      "voiceID": snapshot.data!['data'][index]
                                            ["voiceID"],
                                      "name": snapshot.data!['data'][index]
                                          ["name"],
                                      "text": snapshot.data!['data'][index]
                                          ["text"],
                                      "id": snapshot.data!['data'][index]["id"]
                                    },
                                  );
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 50,
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                        end: Alignment.centerRight,
                                        colors: [
                                          Color(0xff9055FF),
                                          Color(0xffDF98FA),
                                        ]),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  child: Center(
                                      child: Text(
                                    snapshot.data!['data'][index]["name"]
                                        .toString(),
                                    style: const TextStyle(
                                        fontFamily: "Quran",
                                        color: Colors.white,
                                        fontSize: 25),
                                  )),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    );
                  }
                  return const Center(
                      child: CircularProgressIndicator(
                    color: Color(0xff9055FF),
                  ));
                },
              ),
              FutureBuilder(
                future: LoadData3(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data["data"].length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(5),
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, '/Prayer',
                                      arguments: {
                                        "voiceID": snapshot.data!['data'][index]
                                            ["voiceID"],
                                        "name": snapshot.data!['data'][index]
                                            ["name"],
                                        "text": snapshot.data!['data'][index]
                                            ["text"],
                                        "id": snapshot.data!['data'][index]
                                            ["id"]
                                      });
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 50,
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                        end: Alignment.centerRight,
                                        colors: [
                                          Color(0xff9055FF),
                                          Color(0xffDF98FA),
                                        ]),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  child: Center(
                                      child: Text(
                                    snapshot.data!['data'][index]["name"]
                                        .toString(),
                                    style: const TextStyle(
                                        fontFamily: "Quran",
                                        color: Colors.white,
                                        fontSize: 25),
                                  )),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    );
                  }
                  return const Center(
                      child: CircularProgressIndicator(
                    color: Color(0xff9055FF),
                  ));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
