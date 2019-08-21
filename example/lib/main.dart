import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_share/image_share.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('I am an example'),
        ),
        body: Center(
          child: RaisedButton(
            child: const Text('click me'),
            onPressed: () async {
              final File selected = await ImagePicker.pickImage(source: ImageSource.gallery);
              ImageShare.toInstagram(imageUrl: selected.path).share();
            },
          ),
        ),
      ),
    );
  }
}
