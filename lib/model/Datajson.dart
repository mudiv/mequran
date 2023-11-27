class Timesprovider {
  String? _fajir;
  String? _sunrise;
  String? _doher;
  String? _sunset;
  String? _maghrib;
  String? _date;
  String? _powerdby;

  Timesprovider(
      {String? fajir,
      String? sunrise,
      String? doher,
      String? sunset,
      String? maghrib,
      String? date,
      String? powerdby}) {
    if (fajir != null) {
      _fajir = fajir;
    }
    if (sunrise != null) {
      _sunrise = sunrise;
    }
    if (doher != null) {
      _doher = doher;
    }
    if (sunset != null) {
      _sunset = sunset;
    }
    if (maghrib != null) {
      _maghrib = maghrib;
    }
    if (date != null) {
      _date = date;
    }
    if (powerdby != null) {
      _powerdby = powerdby;
    }
  }

  Timesprovider.fromJson(Map<String, dynamic> json) {
    _fajir = json['fajir'];
    _sunrise = json['sunrise'];
    _doher = json['doher'];
    _sunset = json['sunset'];
    _maghrib = json['maghrib'];
    _date = json['date'];
    _powerdby = json['powerdby'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fajir'] = _fajir;
    data['sunrise'] = _sunrise;
    data['doher'] = _doher;
    data['sunset'] = _sunset;
    data['maghrib'] = _maghrib;
    data['date'] = _date;
    data['powerdby'] = _powerdby;
    return data;
  }
}
