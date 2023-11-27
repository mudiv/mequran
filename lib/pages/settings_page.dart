// ignore_for_file: camel_case_types

import 'package:al_quran/theme/them_provader.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:switcher_button/switcher_button.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class AppState with ChangeNotifier {
  bool shouldExecuteAlarm;
  AppState(this.shouldExecuteAlarm);
  void updateShouldExecuteAlarm(bool newValue) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    bool? b = sharedPreferences.getBool('shouldExecuteAlarm');
    if (b != null) {
      shouldExecuteAlarm = b;
    } else {
      sharedPreferences.setBool('shouldExecuteAlarm', false);
      shouldExecuteAlarm = false;
    }

    notifyListeners();
  }
}

class settings extends StatefulWidget {
  const settings({super.key});

  @override
  State<settings> createState() => _settingsState();
}

class _settingsState extends State<settings> {
  bool status = false;

  Future<void> assess() async {
    final Uri url = Uri.parse(
        'https://play.google.com/store/apps/details?id=com.mequran.dev');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> developer() async {
    final Uri url =
        Uri.parse('https://instagram.com/_v_go?utm_medium=copy_link');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final Brightness brightness = Theme.of(context).brightness;
    final appState = Provider.of<AppState>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              height: 80,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  border: Border.all(color: const Color(0xffB2BABB), width: 1)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SwitcherButton(
                    size:70,
                    onColor: Colors.black87,
                    offColor: Colors.white,
                    value: brightness == Brightness.light ? true : false,
                    onChange: (value) {
                      Provider.of<ThemProvider>(context, listen: false)
                          .toggleTheme();
                    },
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "الوضع الداكن",
                        textAlign: TextAlign.right,
                        style: TextStyle(fontFamily: "ar", fontSize: 13),
                      ),
                      Text(
                        "تشغيل وضع الداكن",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontFamily: "ar",
                            fontSize: 10,
                            color: Color(0xFF696E6F),
                            wordSpacing: 2),
                      )
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              height: 80,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  border: Border.all(color: const Color(0xffB2BABB), width: 1)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SwitcherButton(
                    size:70,
                    onColor: const Color(0xFFEDE7F5),
                    offColor: const Color(0xFFB59ED6),
                    value: !appState.shouldExecuteAlarm,
                    onChange: (value) async {
                      final sharedPreferences =
                          await SharedPreferences.getInstance();
                      if (value) {
                        AndroidAlarmManager.cancel(0);
                        setState(() {
                          appState.shouldExecuteAlarm = false;
                        });
                        sharedPreferences.setBool('shouldExecuteAlarm', false);
                      } else {
                        setState(() {
                          appState.shouldExecuteAlarm = true;
                        });
                        sharedPreferences.setBool('shouldExecuteAlarm', true);
                      }
                    },
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "الإشعارات",
                        textAlign: TextAlign.right,
                        style: TextStyle(fontFamily: "ar", fontSize: 13),
                      ),
                      Text(
                        "تفعيل الإشعارات الأذكار كل ساعة",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontFamily: "ar",
                            fontSize: 10,
                            color: Color(0xFF696E6F),
                            wordSpacing: 2),
                      )
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                assess();
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                height: 80,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    border:
                        Border.all(color: const Color(0xffB2BABB), width: 1)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.yellow[600],
                      size: 30,
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "قيم التطبيق",
                          textAlign: TextAlign.right,
                          style: TextStyle(fontFamily: "ar", fontSize: 13),
                        ),
                        Text(
                          "قيم التطبيق على كوكل بلي",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontFamily: "ar",
                              fontSize: 10,
                              color: Color(0xFF696E6F),
                              wordSpacing: 2),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () async {
                await Share.shareWithResult(
                    "تطبيق القرآن الكريم ( من دون الانترنيت )\nيحتوي على أحاديث اهل بيت رسول الله (ص)  و على الأدعية والاذكار، ، أوقات الصلاة في جميع البلدان. \n\n• حمل الآن :\nhttps://play.google.com/store/apps/details?id=com.mequran.dev&pli=1");
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                height: 80,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    border:
                        Border.all(color: const Color(0xffB2BABB), width: 1)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.share_sharp,
                      color: Colors.yellow[600],
                      size: 30,
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "شارك التطبيق",
                          textAlign: TextAlign.right,
                          style: TextStyle(fontFamily: "ar", fontSize: 13),
                        ),
                        Text(
                          "شارك التطبيق لتكن صدقة جارية لك",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontFamily: "ar",
                              fontSize: 10,
                              color: Color(0xFF696E6F),
                              wordSpacing: 2),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              "عن التطبيق",
              textAlign: TextAlign.right,
              style: TextStyle(
                  fontFamily: "ar", fontSize: 10, color: Color(0xffB2BABB)),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              height: 120,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  border: Border.all(color: const Color(0xffB2BABB), width: 1)),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "التطبيق",
                    textAlign: TextAlign.right,
                    style: TextStyle(fontFamily: "ar", fontSize: 13),
                  ),
                  Text(
                    "تطبيق مجاني وغير ربحي (يعمل بدون اتصال بالإنترنت) لئجر وثواب. نسئلكم الادعاء لوالديه",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontFamily: "ar",
                        fontSize: 12,
                        color: Color(0xFF696E6F),
                        wordSpacing: 2),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                developer();
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                height: 90,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    border:
                        Border.all(color: const Color(0xffB2BABB), width: 1)),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "المطور",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontFamily: "ar",
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      "تم تطوير وتصميمه بواسطة المهندس منتظر حليم احمد .",
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontFamily: "ar",
                        fontSize: 12,
                        color: Color(0xFF696E6F),
                        wordSpacing: 2,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
