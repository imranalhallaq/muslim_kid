import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:muslim_kid/screens/Azan.dart';
import 'package:muslim_kid/services/prayTimes.dart';

class LoadingScreen extends StatefulWidget {
  static const String id = 'loading_screen';
  @override
  State<StatefulWidget> createState() {
    return _LoadingScreenState();
  }
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    var prayData = await PrayModel().getLocationPrays();

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AzanScreen(
        prayTimes: prayData,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}
