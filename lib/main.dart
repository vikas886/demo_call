import 'package:ad_demo/home.dart';
import 'package:flutter/material.dart';
import 'package:admob_flutter/admob_flutter.dart';
import 'dart:io';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize without device test ids.
  Admob.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: MyHomePage(title: 'Flutter App'),
      home: MyHomePage(
        title: 'Video Call',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _nativeAdController = NativeAdmobController();
  static const _adUnitID = "ca-app-pub-3940256099942544/8135179316";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Run this before displaying any ad.
    request();
  }

  request() async {
    // Run this before displaying any ad.
    await Admob.requestTrackingAuthorization();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Meeting()));
              },
              child: Text(
                'Get Started',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.blue,
            ),
            Container(
              height: 60,
              width: double.infinity,
              child: AdmobBanner(
                adUnitId: _adUnitID,
                adSize: AdmobBannerSize.BANNER,
              ),
            ),
            Container(
              height: 300,
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(bottom: 20.0),
              child: NativeAdmob(
                // Your ad unit id
                adUnitID: _adUnitID,
                numberAds: 3,
                controller: _nativeAdController,
                type: NativeAdmobType.full,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
