import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:muslim_kid/reUsablePadding.dart';
import 'package:muslim_kid/screens/registration_screen.dart';
import 'package:muslim_kid/services/notification.dart';
import 'package:provider/provider.dart';
import 'login_screen.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;
  AnimationController controller1;
  Animation animation1;
  double status;
  void goToRegister() {
    Navigator.pushNamed(context, RegistrationScreen.id);
  }

  @override
  void initState() {
    Firebase.initializeApp();
    controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(controller);
    animation1 = CurvedAnimation(parent: controller, curve: Curves.easeInCirc);
    controller.forward();
    // animation.addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     controller.reverse(from: 1);
    //   } else if (status == AnimationStatus.dismissed) {
    //     controller.forward();
    //   }
    // });

    controller.addListener(() {
      setState(() {});
      print(controller.value);
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  RegistrationScreen registrationScreen = RegistrationScreen();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: animation.value,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Consumer<NotificationService>(
            builder: (context, model, _) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Hero(
                      tag: 'logo',
                      child: Container(
                        padding: EdgeInsets.only(left: 20),
                        child: Image.asset('images/logo.png'),
                        height: controller.value * 70,
                      ),
                    ),
                    AnimatedTextKit(
                      onTap: () {},
                      animatedTexts: <AnimatedText>[
                        TyperAnimatedText('Muslim Kid',
                            speed: const Duration(milliseconds: 200),
                            textStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w900,
                                fontSize: 40))
                      ],
                      displayFullTextOnTap: true,
                      stopPauseOnTap: true,
                      pause: Duration(milliseconds: 2200),
                      totalRepeatCount: 2,
                      repeatForever: false,
                    ),
                  ],
                ),
                SizedBox(
                  height: 48.0,
                ),
                ReUsablePadding(
                  buttonLabel: 'Login',
                  buttonFunction: () async {
                    Navigator.pushNamed(context, LoginScreen.id);
                  },
                  buttonColor: Colors.lightBlueAccent,
                ),
                ReUsablePadding(
                  buttonLabel: 'Register',
                  buttonFunction: () {
                    Firebase.initializeApp();
                    Navigator.pushNamed(context, RegistrationScreen.id);
                  },
                  buttonColor: Colors.blue,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
