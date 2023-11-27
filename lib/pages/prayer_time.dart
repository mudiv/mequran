import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../model/Data_tiem.dart';

class PrayerTime extends StatefulWidget {
  const PrayerTime({super.key});

  @override
  State<PrayerTime> createState() => _PrayerTimeState();
}

class _PrayerTimeState extends State<PrayerTime> {
  // ignore: non_constant_identifier_names
  Future<List<Map<String, dynamic>>> GetData() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return [];
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return [];
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return [];
    }


    final Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    String latitude = position.latitude.toString();
    String longitude = position.longitude.toString();

    var resp = await requestsData().getData(longitude, latitude);
    return resp;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xff180B37),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xff914cf6),
          title: const Text(
            "مواقيت الصلاة",
            style: TextStyle(fontFamily: "ar", color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: GetData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Color(0xff914cf6),
                ),
              );
            }
            if (snapshot.data!.isNotEmpty && snapshot.hasData) {
              String date = snapshot.data![0]["date"];
              String fajir = snapshot.data![0]["fajir"];
              String sunrise = snapshot.data![0]["sunrise"];
              String doher = snapshot.data![0]["doher"];
              String sunset = snapshot.data![0]["sunset"];
              String maghrib = snapshot.data![0]["maghrib"];
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset("Asset/image/Time.png"),
                  Text(
                    date,
                    style:
                        const TextStyle(fontFamily: "ar", color: Colors.white),
                  ),
                  SizedBox(
                    width: 350,
                  
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          fajir,
                          style: const TextStyle(
                              color: Colors.white,
                              fontFamily: "ar",
                              fontSize: 20),
                        ),
                        const Text(
                          "صلاه الصبح",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "ar",
                              fontSize: 20),
                        ),
                        Image.asset("Asset/image/cloud-computing 1.png"),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 350,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          sunrise,
                          style: const TextStyle(
                              color: Colors.white,
                              fontFamily: "ar",
                              fontSize: 20),
                        ),
                        const Text(
                          "شروق الشمس",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "ar",
                              fontSize: 20),
                        ),
                        Image.asset("Asset/image/cloudy-night.png"),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 350,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          doher,
                          style: const TextStyle(
                              color: Colors.white,
                              fontFamily: "ar",
                              fontSize: 20),
                        ),
                        const Text(
                          "صلاه الظهر",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "ar",
                              fontSize: 20),
                        ),
                        Image.asset(
                          "Asset/image/sun.png",
                          width: 35,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 350,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          sunset,
                          style: const TextStyle(
                              color: Colors.white,
                              fontFamily: "ar",
                              fontSize: 20),
                        ),
                        const Text(
                          "غروب الشمس",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "ar",
                              fontSize: 20),
                        ),
                        Image.asset("Asset/image/sunrise.png"),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 350,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          maghrib,
                          style: const TextStyle(
                              color: Colors.white,
                              fontFamily: "ar",
                              fontSize: 20),
                        ),
                        const Text(
                          "صلاه المغرب",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "ar",
                              fontSize: 20),
                        ),
                        Image.asset("Asset/image/cloud-computing 1.png"),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 150,
                  )
                ],
              );
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "Asset/image/location.png",
                    width: 100,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Center(
                      child: Text(
                    "نرجو تفويض الوصول إلى موقعك لتمكين الخدمة  !!",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontFamily: "ar", color: Colors.white),
                  ))
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
