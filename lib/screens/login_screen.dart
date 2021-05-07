import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:muslim_kid/constants.dart';
import 'package:muslim_kid/reUsablePadding.dart';
import 'package:muslim_kid/screens/loading_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  static bool showSpinner = false;
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = 'imran@gm.com', password = '123456';
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    height: 150.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextFormField(
                initialValue: '',
                inputFormatters: [
                  FilteringTextInputFormatter.deny(' '),
                ],
                textAlign: TextAlign.center,
                style: KTextFiledStyle,
                onChanged: (value) {
                  email = value;
                  value.trim();
                },
                decoration:
                    KInputDecoration.copyWith(hintText: 'Enter your email'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextFormField(
                initialValue: '',
                keyboardType: TextInputType.emailAddress,
                style: KTextFiledStyle,
                textAlign: TextAlign.center,
                obscureText: true,
                onChanged: (value) {
                  password = value;
                  value.trim();
                },
                decoration:
                    KInputDecoration.copyWith(hintText: 'Enter your password'),
              ),
              SizedBox(
                height: 24.0,
              ),
              ReUsablePadding(
                buttonFunction: () async {
                  setState(() {
                    LoginScreen.showSpinner = true;
                  });
                  try {
                    final newUser = await _auth.signInWithEmailAndPassword(
                        password: password.trim(), email: email.trim());
                    if (newUser != null) {
                      Navigator.pushNamed(context, LoadingScreen.id);
                    }
                    setState(() {
                      LoginScreen.showSpinner = false;
                    });
                  } catch (signUpError) {
                    setState(() {
                      AwesomeDialog(
                        context: context,
                        borderSide: BorderSide(color: Colors.green, width: 2),
                        dialogType: DialogType.ERROR,
                        width: 280,
                        buttonsBorderRadius:
                            BorderRadius.all(Radius.circular(2)),
                        headerAnimationLoop: false,
                        animType: AnimType.BOTTOMSLIDE,
                        title: 'Errr',
                        desc: 'Email or Password are not correct',
                        showCloseIcon: true,
                        btnCancelOnPress: () {},
                        btnOkOnPress: () {},
                      )..show();
                      LoginScreen.showSpinner = false;
                    });
                    if (signUpError is PlatformException) {
                      if (signUpError.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
                        /// `foo@bar.com` has already been registered.
                      }
                    }
                  }
                },
                buttonLabel: 'Login',
                buttonColor: Colors.lightBlueAccent,
              )
            ],
          ),
        ),
      ),
    );
  }
}
