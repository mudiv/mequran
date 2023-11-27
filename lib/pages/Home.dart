import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/Data_tiem.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? a;
  String formattedTime = '';
  late Timer _timer;

  gitData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? date = prefs.getString('date');

    if (date == null) {
      var resp = await requestsData().getData("33", "32");
      prefs.setString('date', resp[0]["date"]);
      setState(() {
        a = resp[0]["date"];
      });
    } else {
      setState(() {
        a = date;
      });
      var resp = await requestsData().getData("33", "32");

      if (resp[0]["date"].toString() != date) {
        prefs.setString('date', resp[0]["date"]);
      }
    }
  }

  @override
  void initState() {
    gitData();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final now = DateTime.now();

      final formatted = DateFormat('hh:mm').format(now).toString();

      setState(() {
        formattedTime = formatted;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
              clipBehavior: Clip.antiAlias,
              width: double.infinity,
              height: 131,
              decoration: const BoxDecoration(
                gradient: LinearGradient(end: Alignment.topRight, colors: [
                  Color(0xff9055FF),
                  Color(0xffDF98FA),
                ]),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: const Alignment(0.9, 0),
                    child: Text(
                      formattedTime,
                      style: const TextStyle(
                          color: Colors.white, fontSize: 35, fontFamily: "ar"),
                    ),
                  ),
                  Align(
                    alignment: const Alignment(0.9, 1),
                    child: Text(
                      a ?? "",
                      style: const TextStyle(
                          color: Colors.white, fontSize: 17, fontFamily: "ar"),
                    ),
                  ),
                  Align(
                    alignment: const Alignment(-1.2, 10),
                    child: SvgPicture.asset("Asset/image/1.svg"),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, "/PrayerTime");
                    },
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      width: 180,
                      height: 100,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            end: Alignment.centerRight,
                            colors: [
                              Color(0xff9055FF),
                              Color(0xffDF98FA),
                            ]),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        border: Border.all(
                            color: const Color(0xff9055FF),
                            width: 2,
                            strokeAlign: 1),
                      ),
                      child: Stack(
                        children: [
                          Transform.scale(
                              scale: 2,
                              child: SvgPicture.asset(
                                "Asset/image/4.svg",
                              )),
                          Container(
                            color: Colors.white.withOpacity(0.4),
                          ),
                          const Center(
                              child: Text(
                            "أوقات الصلاه",
                            style: TextStyle(
                                fontFamily: "ar",
                                color: Color(0xFF6411FF),
                                fontSize: 25),
                          ))
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () => Navigator.pushNamed(context, "/ReadQuran"),
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      width: 180,
                      height: 100,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0xff9055FF),
                              Color(0xffDF98FA),
                            ]),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        border: Border.all(
                            color: const Color(0xff9055FF),
                            width: 2,
                            strokeAlign: 1),
                      ),
                      child: Stack(
                        children: [
                          Transform.scale(
                              scale: 2,
                              child: SvgPicture.asset(
                                "Asset/image/8.svg",
                              )),
                          Container(
                            color: Colors.white.withOpacity(0.4),
                          ),
                          const Center(
                              child: Text(
                            "القرآن الكريم",
                            style: TextStyle(
                                fontFamily: "ar",
                                color: Color(0xFF6411FF),
                                fontSize: 25),
                          ))
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, "/Supplications");
                    },
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      width: 180,
                      height: 100,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            end: Alignment.centerRight,
                            colors: [
                              Color(0xff9055FF),
                              Color(0xffDF98FA),
                            ]),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        border: Border.all(
                            color: const Color(0xff9055FF),
                            width: 2,
                            strokeAlign: 1),
                      ),
                      child: Stack(
                        children: [
                          Transform.scale(
                              scale: 2,
                              child: SvgPicture.asset(
                                "Asset/image/3.svg",
                              )),
                          Container(
                            color: Colors.white.withOpacity(0.4),
                          ),
                          const Center(
                            child: Text(
                              "الأدعية و الأذكار",
                              style: TextStyle(
                                  fontFamily: "ar",
                                  color: Color(0xFF6411FF),
                                  fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () => Navigator.pushNamed(context, "/HadithsPage"),
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      width: 180,
                      height: 100,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0xff9055FF),
                              Color(0xffDF98FA),
                            ]),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        border: Border.all(
                            color: const Color(0xff9055FF),
                            width: 2,
                            strokeAlign: 1),
                      ),
                      child: Stack(
                        children: [
                          Transform.scale(
                              scale: 2,
                              child: SvgPicture.asset(
                                "Asset/image/6.svg",
                              )),
                          Container(
                            color: Colors.white.withOpacity(0.4),
                          ),
                          const Center(
                            child: Text(
                              "أحاديث",
                              style: TextStyle(
                                fontFamily: "ar",
                                color: Color(0xFF6411FF),
                                fontSize: 25,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
