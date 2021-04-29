import 'dart:async';

import 'package:adhan/adhan.dart';
import 'package:muslim_kid/services/location.dart';
import 'package:muslim_kid/services/networking.dart';

const apiKey = 'e62f4e3a8b2f730157411b608c08fa22';
const openWeatherMapURL = 'https://api.pray.zone/v2/times/today.json';

class PrayModel {
  Future<dynamic> getCityWeather(String cityName) async {
    Location location = Location();
    await location.getCurrentLocation();
    NetworkHelper networkHelper = NetworkHelper(
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationPrays() async {
    Location location = Location();
    await location.getCurrentLocation();
    final myCoordinates = Coordinates(location.latitude, location.longitude);
    final params = CalculationMethod.turkey.getParameters();
    params.madhab = Madhab.shafi;
    final prayerTimes = PrayerTimes.today(myCoordinates, params);
    print('currentPrayer: ${prayerTimes.currentPrayer()}');
    print('nextPrayer: ${prayerTimes.nextPrayer()}');
    print('we are here');
    return prayerTimes;
  }
}
