import 'package:adhan/adhan.dart';

class TimeCalculation {
  TimeCalculation(this.prayerTimes);
  PrayerTimes prayerTimes;
  DateTime calculateStartOfNextPray(DateTime time) {
    return DateTime(
        time.year,
        time.month,
        time.day,
        prayerTimes.currentPrayer() == Prayer.isha
            ? prayerTimes.fajr.hour
            : prayerTimes.timeForPrayer(prayerTimes.nextPrayer()).hour,
        prayerTimes.currentPrayer() == Prayer.isha
            ? prayerTimes.fajr.minute
            : prayerTimes.timeForPrayer(prayerTimes.nextPrayer()).minute);
  }

  DateTime calculateStartOfCurrentPray(DateTime time) {
    return DateTime(
        time.year,
        time.month,
        time.day,
        prayerTimes.nextPrayer() == Prayer.fajr
            ? prayerTimes.isha.hour
            : prayerTimes.timeForPrayer(prayerTimes.currentPrayer()).hour,
        prayerTimes.nextPrayer() == Prayer.fajr
            ? prayerTimes.isha.minute
            : prayerTimes.timeForPrayer(prayerTimes.currentPrayer()).minute);
  }

  // we are here to know what is the next prayer time
  String nextPrayName() {
    if (prayerTimes.nextPrayer() == Prayer.isha ||
        prayerTimes.currentPrayer() == Prayer.maghrib) {
      return 'Isha';
    } else if (prayerTimes.nextPrayer() == Prayer.asr ||
        prayerTimes.currentPrayer() == Prayer.dhuhr) {
      return 'Asr';
    } else if (prayerTimes.nextPrayer() == Prayer.sunrise ||
        prayerTimes.currentPrayer() == Prayer.fajr) {
      return 'Sunrise';
    } else if (prayerTimes.nextPrayer() == Prayer.dhuhr ||
        prayerTimes.currentPrayer() == Prayer.sunrise) {
      return 'Dhuhr';
    } else if (prayerTimes.nextPrayer() == Prayer.maghrib ||
        prayerTimes.currentPrayer() == Prayer.asr) {
      return 'Maghrib';
    } else
      return 'Fajr';
  }
}
