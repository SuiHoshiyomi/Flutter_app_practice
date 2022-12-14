import 'package:etherwallet/services_provider.dart';
import 'package:etherwallet/router.dart';
import 'package:etherwallet/services_provider.dart';
import 'package:etherwallet/services_provider.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:provider/single_child_widget.dart';

Future<void> main() async {
  // bootstrapping;
  WidgetsFlutterBinding.ensureInitialized();
  final stores = await createProviders();

  runApp(MainApp(stores));
}

class MainApp extends StatelessWidget {
  MainApp(this.stores, {Key? key}) : super(key: key);
  final List<SingleChildWidget> stores;
  // final FirebaseAnalytics analytics = FirebaseAnalytics();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: stores,
        child: MaterialApp(
          title: 'Flutter App',
          initialRoute: '/login',
          routes: getRoutes(context),
          // navigatorObservers: [
          //   FirebaseAnalyticsObserver(analytics: analytics),
          // ],
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
            buttonTheme: const ButtonThemeData(
              buttonColor: Colors.blue,
              textTheme: ButtonTextTheme.primary,
            ),
          ),
        ));
  }
}
