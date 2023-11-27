// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';
import 'dart:math';
import 'package:al_quran/pages/Hadiths_Page.dart';
import 'package:al_quran/pages/ReadHadiths_Page.dart';
import 'package:al_quran/pages/settings_page.dart';
import 'package:al_quran/theme/them_provader.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:al_quran/pages/Read_Quran.dart';
import 'package:al_quran/pages/HomePage.dart';
import 'package:al_quran/pages/Read_aya.dart';
import 'package:al_quran/pages/SupplicationsPage.dart';
import 'package:al_quran/pages/prayerPage.dart';
import 'package:al_quran/pages/prayer_time.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: non_constant_identifier_names
Future<String> LoadData() async {
  // ignore: non_constant_identifier_names
  final JsonFile = await rootBundle.loadString("Asset/Data/adhkar.json");
  var jsonData = json.decode(JsonFile);
  Random random = Random();
  int randomIndex = random.nextInt(jsonData!["data"].length);
  String randomItem = jsonData!["data"][randomIndex].toString();

  return randomItem;
}

Future<void> _showNotification() async {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  LoadData().then((title) {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'الأذكار',
      'الأذكار',
      color: const Color(0xffDF98FA),
      ledColor: const Color(0xffDF98FA),
      playSound: false,
      ledOnMs: 1,
      ledOffMs: 1,
      icon: "mipmap/quran",
      importance: Importance.max,
      priority: Priority.high,
      styleInformation: BigTextStyleInformation(title),
    );
    NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    flutterLocalNotificationsPlugin.show(
      0,
      null,
      title,
      platformChannelSpecifics,
    );
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AndroidAlarmManager.initialize();
  final sharedPreferences = await SharedPreferences.getInstance();
  bool? b = sharedPreferences.getBool('shouldExecuteAlarm');
  if (b == null) {
    b = false;
    sharedPreferences.setBool('shouldExecuteAlarm', false);
  }
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppState(b!)),
        ChangeNotifierProvider(
            create: (context) => ThemProvider(sharedPreferences)),
      ],
      child: const MyApp(),
    ),
  );
  if (b) {
    await AndroidAlarmManager.periodic(
        const Duration(minutes: 20), 
        0,
        _showNotification,
        exact: true,
        wakeup: true);
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemProvider>(builder: (context, provider, child) {
      return MaterialApp(
        title: 'Quran',
        debugShowCheckedModeBanner: false,
        home: const MyHomePage(),
        theme: provider.themeData,
        // darkTheme: darkTheme,
        routes: {
          "/PrayerTime": (context) => const PrayerTime(),
          "/Supplications": (context) => const Supplications(),
          "/Prayer": (context) => const Prayer(),
          "/ReadQuran": (context) => const ReadQuran(),
          "/ReadAya": (context) => const ReadAya(),
          "/HadithsPage": (context) => const HadithsPage(),
          "/ReadHadithsPage": (context) => const ReadHadithsPage()
        },
      );
    });
  }
}
