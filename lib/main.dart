import 'package:auto_route/auto_route_annotations.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_package_plugin1/flutter_package_plugin1.dart';
import 'package:model_architecture/api/SampleCall.dart';
import 'package:model_architecture/constantPackage/language/languageEn.dart';
import 'package:model_architecture/providers/SampleProvider.dart';
import 'package:model_architecture/utils/Globals.dart';
import 'file:///D:/git%20main/flutter-modules/model_architecture/lib/api/api_service.dart';
import 'package:model_architecture/utils/languageDeligate.dart';
import 'package:provider/provider.dart';

import 'providers/DetailsScreenProvider.dart';
import 'screens/DetailScreen/DetailScreen.dart';
import 'screens/HomeScreen/HomeScreen.dart';
import 'utils/preference.dart';

// need to add async
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preference.load();
  int k=Calculator().addOne(2);
  print("number is $k");

  if (isPrimaryLanguageset() ==  false) {
  } else {}
  Globals.primaryLanguage = await getPrimaryLanguage();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => SampleProvider()),
        ChangeNotifierProvider(create: (ctx) => DetailScreenProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => HomeScreen(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/second': (context) => DetailScreen(),
      },
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
    );
  }
}

/*

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:google_pay/google_pay.dart';

void main() => runApp(MyApp());


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  String _googlePayToken = 'Unknown';

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
      platformVersion = await GooglePay.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    await GooglePay.initializeGooglePay("	pk_test_51IIZ9JCjAkxVNxfqPQhygzBLpnqmQnlTAuv3HaANtGaLuPX4n2DQNIycH5cTp7SeSXx9o187ZMJfGoRL4n3G7QZV00uhnDir08");

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
        body: Center(
          child: Column(
              children: <Widget>[
                Text('Running on: $_platformVersion\n'),
                Text('Google pay token: $_googlePayToken\n'),
                FlatButton(
                  child: Text("Google Pay Button"),
                  onPressed: onButtonPressed,
                )
              ]
          ),
        ),
      ),
    );
  }

  void onButtonPressed() async{
    setState((){_googlePayToken = "Fetching";});
    try {
      await GooglePay.openGooglePaySetup(
          price: "5.0",
          onGooglePaySuccess: onSuccess,
          onGooglePayFailure: onFailure,
          onGooglePayCanceled: onCancelled);
      setState((){_googlePayToken = "Done Fetching";});
    } on PlatformException catch (ex) {
      setState((){_googlePayToken = "Failed Fetching";});
    }

  }

  void onSuccess(String token){
    setState((){_googlePayToken = token;});
  }

  void onFailure(){
    setState((){_googlePayToken = "Failure";});
  }

  void onCancelled(){
    setState((){_googlePayToken = "Cancelled";});
  }
}*/
