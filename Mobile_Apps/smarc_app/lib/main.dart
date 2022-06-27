import 'package:flutter/material.dart'; //library UI flutter
import "package:flutter/services.dart";
import 'package:firebase_core/firebase_core.dart'; //library untuk akses firebase
import 'package:smarc_app/splashScreen.dart'; //library untuk navigasi splash screen

void main() {
  WidgetsFlutterBinding.ensureInitialized(); //inisiasi penggunaan Widget
  Firebase.initializeApp(); //inisiasi penggunaan Firebase instance
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight
  ]).then((_) =>
      runApp(new MyApp())); /*membuat orientasi aplikasi pada mode landscape*/
}

class MyApp extends StatelessWidget {
  //Widget statis
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SMARC',
      theme: ThemeData.dark(),
      home: Splash(), //navigasi Splash Screen
    );
  }
}
