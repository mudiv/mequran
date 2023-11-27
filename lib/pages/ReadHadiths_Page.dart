import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

class ReadHadithsPage extends StatefulWidget {
  const ReadHadithsPage({super.key});

  @override
  State<ReadHadithsPage> createState() => _ReadHadithsPageState();
}

class _ReadHadithsPageState extends State<ReadHadithsPage> {
  Map<String, dynamic>? jsonData;
  Future<Map<String, dynamic>?> LoadData(filename) async {
    final JsonFile = await rootBundle.loadString("Asset/Data/$filename.json");
    Map<String, dynamic>? jsonData = json.decode(JsonFile);
    return jsonData;
  }

  @override
  Widget build(BuildContext context) {
    final Map data = ModalRoute.of(context)?.settings.arguments as Map;
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
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: LoadData(data["file"]),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!["data"].length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            context: context,
                            builder: (BuildContext context) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  height: 450,
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 50,
                                        height: 2,
                                        color: const Color(0xff8789A3),
                                      ),
                                      const SizedBox(
                                        height: 40,
                                      ),
                                      Text(
                                        snapshot.data!["data"][index]["Sor"],
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                            fontSize: 20,
                                            fontFamily: "Quran"),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        snapshot.data!["data"][index]["aya"],
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                            fontSize: 25,
                                            fontFamily: "Quran"),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        width: double.infinity,
                        height: 200,
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Text(
                                  snapshot.data!["data"][index]["Sor"],
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      fontSize: 20,
                                      fontFamily: "Quran"),
                                ),
                              ),
                            ),
                            snapshot.data!["data"][index]["aya"].length > 150
                                ? Text(
                                    snapshot.data!["data"][index]["aya"]
                                            .substring(0, 150) +
                                        " . . . ",
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        fontSize: 20,
                                        fontFamily: "Quran"),
                                  )
                                : Text(
                                    snapshot.data!["data"][index]["aya"],
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        fontSize: 20,
                                        fontFamily: "Quran"),
                                  ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      width: 30,
                                      height: 30,
                                      decoration: const BoxDecoration(
                                          color: Color(0xff914cf6),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(6))),
                                      child: IconButton(
                                          onPressed: () {
                                            Clipboard.setData(ClipboardData(
                                                    text:
                                                        '${snapshot.data!["data"][index]["aya"]}\n\n • حمل التطبيق الان :\n https://play.google.com/store/apps/details?id=com.mequran.dev&pli=1'))
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
                                          icon: const Icon(
                                            Icons.copy,
                                            size: 16,
                                            color: Colors.white,
                                          )),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      width: 30,
                                      height: 30,
                                      decoration: const BoxDecoration(
                                          color: Color(0xff914cf6),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(6))),
                                      child: IconButton(
                                          onPressed: () async {
                                            await Share.shareWithResult(
                                                '${snapshot.data!["data"][index]["aya"]}\n\n • حمل التطبيق الان :\nhttps://play.google.com/store/apps/details?id=com.mequran.dev&pli=1');
                                          },
                                          icon: const Icon(
                                            Icons.share,
                                            size: 16,
                                            color: Colors.white,
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
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
      ),
    );
  }
}
