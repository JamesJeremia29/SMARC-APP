import 'package:flutter_neumorphic/flutter_neumorphic.dart'; //library untuk UI screen
import 'package:webview_flutter/webview_flutter.dart'; //library untuk tampilan web

class Screen extends StatefulWidget {
  final bool _isScreenOn; 
  Screen(this._isScreenOn); //untuk menyatakan kondisi on/off video streaming
  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  @override
  Widget build(BuildContext context) {
    return Neumorphic(
        style: NeumorphicStyle(
            shape: NeumorphicShape.flat,
            depth: -3,
            surfaceIntensity: 10,
            shadowDarkColor: Colors.black,
            border: NeumorphicBorder(
              color: Color(0x33000000),
              width: 2,
            )),
        child: widget._isScreenOn //mengecek apakah status on/true
            ? Container( //tampilan UI jika kondisi on
                height: 240,
                width: 320,
                child: WebView(
                  initialUrl: "http://192.168.100.87/", //fungsi Web View untuk akses url dari esp32 cam
                ))
            : Container( //tampilan UI jika kondisi off
                height: 240,
                width: 320,
              ));
  }
}
