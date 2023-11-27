
import 'package:al_quran/pages/Home.dart';
import 'package:al_quran/pages/settings_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  String? a;
  int index = 1;
  Map<String, dynamic>? jsonData;
  List page = [const settings(), const Home()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        
        bottomNavigationBar: NavigationBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          indicatorColor: Theme.of(context).colorScheme.onBackground,
          selectedIndex: index,
          onDestinationSelected: (int val) {
            setState(() {
              index = val;
            });
          },
          destinations: const [
            NavigationDestination(
                selectedIcon: Icon(Icons.settings),
                icon: Icon(Icons.settings_outlined),
                label: "الاعدادات"),
            NavigationDestination(
                selectedIcon: Icon(Icons.home),
                icon: Icon(Icons.home_outlined),
                label: "الصفحة الرئيسية"),
          ],
        ),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            "القرآن الكريم",
            style: TextStyle(
                color: Color(0xff672CBC),
                fontWeight: FontWeight.bold,
                fontSize: 25,
                fontFamily: "ar"),
          ),
          centerTitle: true,
        ),
        body: page[index]);
  }
}
