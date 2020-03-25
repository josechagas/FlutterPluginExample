import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:learningflutterplugin/platform_info.dart';
import 'package:learningflutterplugin/text_view.dart';
import 'package:learningflutterplugin/indicator_seek_bar.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await PlatformInfo.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    } catch(e) {
      print(e);
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: <Widget>[
            SizedBox(height: 20,),
            Text('Running on: $_platformVersion\n'),
            SizedBox(
              height: 50,
            ),
            Container(
              margin: EdgeInsets.all(20),
              height: 100,
              child: TextView(
                text: '- Exemplificando a passagem de parametros na inicialização',
                onTextViewCreated: _onTextViewCreated,
              ),
            ),
            /*Platform.isIOS ? Container(
              margin: EdgeInsets.all(20),
              height: 100,
              child: UiKitView(//this is a teste show that it can be done only declaring on ios project
                viewType: 'teste/text_view',
              ),
            ) : SizedBox.shrink(),*/
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              height: 90,
              child: IndicatorSeekBar(
                min: 50,
                max: 200,
                progress: 80,
                tickCount: 6,
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onTextViewCreated(TextViewController controller) {
    print("Created");
    //controller.setText("Plugin com um TextView nativo android");
  }
}
