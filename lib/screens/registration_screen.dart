import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:muslim_kid/screens/loading_screen.dart';

import '../constants.dart';
import '../reUsablePadding.dart';
import 'login_screen.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String email, password1 = '0', password2;
  final _auth = FirebaseAuth.instance;
  GlobalKey _toolTipKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ModalProgressHUD(
          inAsyncCall: LoginScreen.showSpinner,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Flexible(
                  child: Hero(
                    tag: 'logo',
                    child: Container(
                      height: 200.0,
                      child: Image.asset('images/logo.png'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 48.0,
                ),
                TextField(
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(' '),
                  ],
                  textAlign: TextAlign.center,
                  style: KTextFiledStyle,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    value.trim();
                    email = value;

                    //Do something with the user input.
                  },
                  decoration:
                      KInputDecoration.copyWith(hintText: 'Enter your email'),
                ),
                SizedBox(
                  height: 18.0,
                ),
                TextField(
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(' '),
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  style: KTextFiledStyle,
                  textAlign: TextAlign.center,
                  obscureText: true,
                  onChanged: (value) {
                    value.trim();
                    password1 = value;
                    setState(() {});
                    //Do something with the user input.
                  },
                  decoration: KInputDecoration.copyWith(
                      hintText: 'Enter your password'),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(' '),
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  style: KTextFiledStyle,
                  textAlign: TextAlign.center,
                  obscureText: true,
                  onChanged: (value) {
                    value.trim();
                    password2 = value;
                    setState(() {});
                    //Do something with the user input.
                  },
                  decoration: KInputDecoration.copyWith(
                      hintText: 'Confirm  your password'),
                ),
                SizedBox(
                  height: 24.0,
                ),
                password1 != password2
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: SizedBox(
                                child: Text(
                              'Enter your Email and password',
                              style: TextStyle(color: Colors.black54),
                            )),
                          ),
                          GestureDetector(
                              onTap: () {
                                final dynamic tooltip =
                                    _toolTipKey.currentState;
                                tooltip.ensureTooltipVisible();
                              },
                              child: Tooltip(
                                key: _toolTipKey,
                                preferBelow: false,
                                waitDuration: Duration(seconds: 2),
                                showDuration: Duration(seconds: 2),
                                message:
                                    ' 1. Enter unused email. \n 2. Password has to be at least 6 characters. \n 3. Retype the same password ',
                                child: Icon(
                                  Icons.info_outline,
                                  color: Colors.black54,
                                ),
                              )),
                        ],
                      )
                    : ReUsablePadding(
                        buttonFunction: () async {
                          setState(() {
                            LoginScreen.showSpinner = true;
                          });

                          try {
                            final newUser =
                                await _auth.createUserWithEmailAndPassword(
                                    email: email.trim(),
                                    password: password2.trim());
                            if (newUser != null) {
                              Navigator.pushNamed(context, LoadingScreen.id);
                            }
                            setState(() {
                              LoginScreen.showSpinner = false;
                            });
                          } catch (signUpError) {
                            setState(() {
                              LoginScreen.showSpinner = false;

                              AwesomeDialog(
                                context: context,
                                borderSide:
                                    BorderSide(color: Colors.green, width: 2),
                                dialogType: DialogType.ERROR,
                                width: 280,
                                buttonsBorderRadius:
                                    BorderRadius.all(Radius.circular(2)),
                                headerAnimationLoop: false,
                                animType: AnimType.BOTTOMSLIDE,
                                title: 'Error',
                                desc: 'An Error on data or User already exists',
                                showCloseIcon: true,
                                btnCancelOnPress: () {},
                                btnOkOnPress: () {},
                              )..show();
                            });
                            if (signUpError is PlatformException) {
                              if (signUpError.code ==
                                  'ERROR_EMAIL_ALREADY_IN_USE') {
                                /// `foo@bar.com` has already been registered.

                              }
                            }
                          }
                        },
                        buttonLabel: 'Register',
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
