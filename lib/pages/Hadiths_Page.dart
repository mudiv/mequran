import 'package:flutter/material.dart';

class HadithsPage extends StatefulWidget {
  const HadithsPage({super.key});

  @override
  State<HadithsPage> createState() => _HadithsPageState();
} 

class _HadithsPageState extends State<HadithsPage> {
  List listname = [
    {"anme": "رسول الله(ص)", "file": "Prophet_Muhammad"},
    {"anme": "الإمام الحسن(ع)", "file": "Al-Hassan"},
    {"anme": "الإمام الحسين(ع)", "file": "AI-Hussein"},
    {"anme": "الإمام علي السجاد(ع)", "file": "alsajaad"},
    {"anme": "الإمام محمد الباقر(ع)", "file": "Al-Baqir"},
    {"anme": "الإمام جعفر الصادق(ع)", "file": "alsaadiq"},
    {"anme": "الإمام موسى الكاظم(ع)", "file": "Al-Kazem"},
    {"anme": "الإمام علي الرضا(ع)", "file": "alrida"},
    {"anme": "الإمام محمد الجواد(ع)", "file": "aljawad"},
    {"anme": "الإمام علي الهادي(ع)", "file": "alhadi"},
    {"anme": "الإمام الحسن العسكري(ع)", "file": "aleaskariu"},
  ];
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: const Color(0xff914cf6),
            title: const Text(
              "أحاديث",
              style: TextStyle(fontFamily: "ar", color: Colors.white),
            ),
            centerTitle: true,
          ),
          body: ListView.builder(
            itemCount: listname.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/ReadHadithsPage',
                        arguments: {
                          "name": listname[index]["anme"],
                          "file": listname[index]["file"]
                        },
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
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
                          listname[index]["anme"],
                          style: const TextStyle(
                              fontFamily: "Quran",
                              color: Colors.white,
                              fontSize: 25),
                        )),
                      ),
                    ),
                  ),
                ],
              );
            },
          )),
    );
  }
}
