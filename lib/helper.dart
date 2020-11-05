export 'package:flutter/material.dart';
export 'package:flutter/services.dart';
export 'package:provider/provider.dart';
export 'dart:async';
export 'dart:convert';
export 'package:fluttertoast/fluttertoast.dart';
export 'providers/auth.dart';
export 'providers/themes.dart';
export 'screens/home.dart';
export 'screens/authentication.dart';
import 'package:flutter/material.dart';

const kurl = 'https://12a8329dfa81.ngrok.io';

const String kAppName = 'Insta';

const List resourceHelper = [
  'resources/logo.png', //app logo
  'resources/google_logo.png', //google logo png
];

double screenH, screenW;

Future showMyDialog(context, String msg) async {
  return showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return AlertDialog(
        buttonPadding: EdgeInsets.all(15),
        title: Text('Important Notice!'),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              // Text(isDis),
              Text(msg),
            ],
          ),
        ),
        actions: [
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            padding: EdgeInsets.symmetric(
              horizontal: 30,
            ),
            child: Text(
              'Okay',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
            color: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
          ),
        ],
      );
    },
  );
}
