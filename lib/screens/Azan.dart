import 'package:adhan/adhan.dart';
import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';
import 'package:muslim_kid/services/TimeCalculation.dart';
import 'package:muslim_kid/services/notification.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class AzanScreen extends StatefulWidget {
  static const String id = 'Azan';
  AzanScreen({this.prayTimes});
  final PrayerTimes prayTimes;

  @override
  _AzanScreenState createState() => _AzanScreenState();
}

class _AzanScreenState extends State<AzanScreen> {
  final _today = new HijriCalendar.now();
  @override
  void initState() {
    Provider.of<NotificationService>(context, listen: false).initialize();

    super.initState();
  }

  DateTime dateTimePrayers(var prayerHour, var prayerMinute) {
    return DateTime(DateTime.now().year, DateTime.now().month,
        DateTime.now().day, prayerHour, prayerMinute);
  }

  final Color color1 = Color(0xFF8000e8);

  final Color color2 = Color(0xFF34009b);

  final Color color3 = Color(0xFF8133d4);

  final date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final TimeCalculation timeCalculation = TimeCalculation(widget.prayTimes);
    DateTime _currentTime = DateTime.now();
    final startOfNextPray =
        timeCalculation.calculateStartOfNextPray(_currentTime);
    final remaining = startOfNextPray.difference(_currentTime);
    int allTime = startOfNextPray
        .difference(timeCalculation.calculateStartOfCurrentPray(_currentTime))
        .inMinutes;

    print('alltime =$allTime');
    final hours = remaining.inHours - remaining.inDays * 24;
    final minutes = remaining.inMinutes - remaining.inHours * 60;
    int remainingMinutes;
    if (widget.prayTimes.currentPrayer() == Prayer.isha) {
      remainingMinutes = hours * 60 + minutes + 1440;
      allTime += 1440;
    } else if (widget.prayTimes.currentPrayer() == Prayer.none) {
      remainingMinutes = hours * 60 + minutes;
      allTime += 1440;
    } else
      remainingMinutes = hours * 60 + minutes;

    double forBarStatus = (allTime - remainingMinutes.toDouble()) / allTime;

    double firstDo = forBarStatus * 255;

    int barColor = (firstDo.toInt());

    return Consumer<NotificationService>(
      builder: (context, modal, _) => Scaffold(
          body: Container(
        padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.pink.shade300, Colors.pink.shade700])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      Icon(Icons.menu, color: Colors.white)
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Pray time alarm",
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                  // Text(
                  //   "",
                  //   style: TextStyle(color: Colors.white, fontSize: 15),
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: 25,
                          ),
                          _iconText(
                              Icon(
                                Icons.location_on,
                                color: Colors.white,
                                size: 15,
                              ),
                              'tr',
                              "Current Location"),
                          SizedBox(
                            height: 15,
                          ),
                          _iconText(
                              Icon(
                                Icons.calendar_today,
                                color: Colors.white,
                                size: 15,
                              ),
                              '${_today.hDay}/${_today.hMonth}/ ${_today.hYear}',
                              "Date in Hijri"),
                          SizedBox(
                            height: 25,
                          ),
                        ],
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircularPercentIndicator(
                            percent: forBarStatus,
                            radius: 150,
                            animation: true,
                            progressColor:
                                Color.fromARGB(barColor, barColor, 0, 0),
                            backgroundColor: Colors.white,
                            animateFromLastPercent: true,
                            lineWidth: 25,
                            center: Text(timeCalculation.nextPrayName()),
                          ),
                        ),
                      ),
                    ],
                  ),

                  _prayerTimes("Fajr",
                      '${widget.prayTimes.fajr.hour}:${widget.prayTimes.fajr.minute}'),
                  SizedBox(
                    height: 15,
                  ),
                  _prayerTimes("Sunrise",
                      '${widget.prayTimes.sunrise.hour}:${widget.prayTimes.sunrise.minute}'),
                  SizedBox(
                    height: 15,
                  ),
                  _prayerTimes(
                      DateFormat('EEEE').format(date) == 'Friday'
                          ? 'Juma'
                          : 'Dhuhur',
                      '${widget.prayTimes.dhuhr.hour}:${widget.prayTimes.dhuhr.minute}'),
                  SizedBox(
                    height: 15,
                  ),
                  _prayerTimes(
                    "Asr",
                    '${widget.prayTimes.asr.hour}:${widget.prayTimes.asr.minute}',
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  _prayerTimes("Maghrib",
                      '${widget.prayTimes.maghrib.hour}:${widget.prayTimes.maghrib.minute}'),
                  SizedBox(
                    height: 15,
                  ),
                  _prayerTimes("Isha",
                      '${widget.prayTimes.isha.hour}:${widget.prayTimes.isha.minute}'),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        child: Text("Cancel",
                            style: TextStyle(
                                color: color2, fontWeight: FontWeight.bold)),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          modal.scheduledNotification(
                              'aldtuhr',
                              DateTime(
                                  DateTime.now().year,
                                  DateTime.now().month,
                                  DateTime.now().day,
                                  widget.prayTimes.dhuhr.hour,
                                  widget.prayTimes.dhuhr.minute));
                          print('Start');
                          print(widget.prayTimes.fajr.hour);
                          print(widget.prayTimes.fajr.minute);
                          print(
                              '${dateTimePrayers(widget.prayTimes.fajr.hour, widget.prayTimes.fajr.minute)} WOW');

                          setState(() {});
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.pinkAccent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        child: Text("Save",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }

  Widget _iconText(Icon icon, String title, String subTitle) {
    double h = 30;
    double w = 30;
    Container left = Container(
      width: w,
      height: h,
      decoration: BoxDecoration(
          color: Colors.pink.shade300,
          borderRadius: BorderRadius.circular(w / 2)),
      child: icon,
    );

    Column right = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(title, style: TextStyle(color: Colors.white)),
        Text(subTitle, style: TextStyle(color: Colors.white, fontSize: 10)),
      ],
    );

    return Row(
      children: <Widget>[
        left,
        SizedBox(
          width: 10,
        ),
        right
      ],
    );
  }

  Widget _prayerTimes(String name, String time, {Function function}) {
    return GestureDetector(
      onTap: function,
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.pinkAccent, borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              name,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            Row(
              children: <Widget>[
                Text(
                  time,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(Icons.alarm, color: Colors.white)
              ],
            )
          ],
        ),
      ),
    );
  }
}
