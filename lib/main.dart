import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:muslim_kid/screens/Azan.dart';
import 'package:muslim_kid/screens/loading_screen.dart';
import 'package:muslim_kid/screens/login_screen.dart';
import 'package:muslim_kid/screens/registration_screen.dart';
import 'package:muslim_kid/screens/welcome_screen.dart';
import 'package:muslim_kid/services/notification.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('app_icon');
  final IOSInitializationSettings initializationSettingsIOS =
      IOSInitializationSettings(onDidReceiveLocalNotification: null);
  final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: null);
  runApp(MyApp());
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => NotificationService())],
      child: MaterialApp(
        initialRoute: '4',
        routes: {
          LoginScreen.id: (context) => LoginScreen(),
          LoadingScreen.id: (context) => LoadingScreen(),
          AzanScreen.id: (context) => AzanScreen(),
          RegistrationScreen.id: (context) => RegistrationScreen(),
          WelcomeScreen.id: (context) => WelcomeScreen()
        },
        theme: ThemeData.dark(),
        home: LoadingScreen(),
      ),
    );
  }
}
