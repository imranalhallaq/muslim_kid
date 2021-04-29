import 'package:flutter/material.dart';

class ReUsablePadding extends StatelessWidget {
  ReUsablePadding({this.buttonLabel, this.buttonColor, this.buttonFunction});
  final Color buttonColor;
  final String buttonLabel;
  final Function buttonFunction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: buttonColor,
        borderRadius: BorderRadius.circular(30.0),
        child: ElevatedButton(
          onPressed: buttonFunction,
          style: ElevatedButton.styleFrom(
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0),
              ),
              minimumSize: Size(
                200.0,
                42.0,
              )),
          child: Text(
            buttonLabel,
            style: TextStyle(color: Colors.white),
            //  'Log In',
          ),
        ),
      ),
    );
  }
}
