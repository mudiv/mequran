// ignore_for_file: file_names, camel_case_types
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'Datajson.dart';

class requestsData {
  Future<List<Map<String, dynamic>>> getData(String long, String lati) async {
    List<Map<String, dynamic>> dataList = [];
    var url = Uri.parse(
        "https://hq.alkafeel.net/Api/init/init.php?timezone=+3&long=$long&lati=$lati&v=jsonPrayerTimes");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      Timesprovider result = Timesprovider.fromJson(json.decode(response.body));
      dataList.add(result.toJson());
    }
    return dataList;
  }
}
