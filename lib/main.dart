//import 'package:androidflutter/views/device_info.dart';
//import 'package:androidflutter/views/home.dart';
import 'package:androidflutter/views/splash_view.dart';
//import 'package:androidflutter/views/dropdown_view.dart';
//import 'package:androidflutter/views/login_page.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Android Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
      /*routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        //'/': (context) => const PageLogin(),
        //'/': (context) => const DropdownPage(),
        //'/': (context) => const DeviceInfoPage(),
        //'/': (context) => const PageHome(),
      },*/
    );
  }
}
