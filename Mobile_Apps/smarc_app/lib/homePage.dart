import 'package:flutter_neumorphic/flutter_neumorphic.dart'; //Library UI untuk Button
import 'package:flutter_svg/flutter_svg.dart'; //Library untuk menampilkan vector image
import 'package:open_settings/open_settings.dart'; //Library untuk membuka settings smartphone
import 'package:smarc_app/videoStream.dart'; //menampilkan Widget Video
import 'package:firebase_database/firebase_database.dart'; //Library untuk akses Firebase RealTime Database
import 'package:fluttertoast/fluttertoast.dart'; //Library untuk menunjukan UI toast message

class homePage extends StatefulWidget {
  //Widget Dinamis
  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey =
      new GlobalKey<ScaffoldState>(); //akses terhadap objek Widget Dinamis
  late DatabaseReference _dbreff; //referensi Firebase RealTime Database

  @override
  void initState() {
    super.initState();
    _dbreff =
        FirebaseDatabase.instance.reference(); // memanggil referensi Firebase
  }

  _sendMessageInitial() {
    _dbreff.child("esp32").set({
      'motor': 0,
      'led': 0,
    });
  } //membuat awalan data pada 0

  _sendMessageForward() async {
    _dbreff.child("esp32").update({'motor': 1});
  } //mengirim perintah untuk maju

  _sendMessageBackward() async {
    _dbreff.child("esp32").update({'motor': 2});
  } //mengirim perintah untuk mundur

  _sendMessageRight() async {
    _dbreff.child("esp32").update({'motor': 3});
  } //mengirim perintah untuk belok kanan

  _sendMessageLeft() async {
    _dbreff.child("esp32").update({'motor': 4});
  } //mengirim perintah untuk belok kiri

  _sendMessageLedOn() async {
    _dbreff.child("esp32").update({'led': 1});
  } //mengirim perintah untuk menyalakan led

  _sendMessageLedOff() async {
    _dbreff.child("esp32").update({'led': 0});
  } //mengirim perintah untuk mematikan led

  _sendMessageBrake() async {
    _dbreff.child("esp32").update({'motor': 0});
  } //mengirim perintah untuk mematikan motor

  bool _isScreenOn = false; //inisiasi kondisi awal screen video off

  @override
  Widget build(BuildContext context) {
    //integrasi UI Dashboard dengan menambahkan widget controller, Button, dan juga Web View
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.lightBlue,
      body: Padding(
        padding: const EdgeInsets.only(
          right: 8,
          left: 8,
          top: 20,
          bottom: 5,
        ),
        child: Stack(
          alignment: Alignment.topRight,
          children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  color: Colors.white),
              child: Row(
                children: <Widget>[
                  controler(), //menampilkan & memanggil fungsi dari Widget Controller
                  SizedBox(
                    width: 5,
                  ),
                  Screen(
                      _isScreenOn), //menampilkan fungsi screen Web View dari kamera
                  SizedBox(width: 5),
                  fourbutton(), //menampilkan & memanggil fungsi dari Widget fourButton
                ],
              ),
            ),
            RawMaterialButton(
              fillColor: Colors.grey,
              shape: CircleBorder(),
              child: Image.asset("assets/SMARC.png"),
              onPressed: () {
                Fluttertoast.showToast( //menampilkan pesan saat button ditekan
                    msg: "Hi, I'm SMARC",
                    backgroundColor: Colors.grey,
                    gravity: ToastGravity.TOP,
                    toastLength: Toast.LENGTH_LONG);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget controler() {
    //membuat Widget controller
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Neumorphic(
          style: NeumorphicStyle(
              shape: NeumorphicShape.convex,
              boxShape: NeumorphicBoxShape.circle(),
              depth: 10,
              oppositeShadowLightSource: false,
              shadowLightColor: Colors.white,
              color: Colors.grey.withOpacity(0.7)),
          child: Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(shape: BoxShape.circle),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Neumorphic(
                  style: NeumorphicStyle(
                      shape: NeumorphicShape.convex,
                      boxShape: NeumorphicBoxShape.circle(),
                      depth: 10,
                      shadowLightColor: Colors.white,
                      color: Colors.grey.withOpacity(0.7)),
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(shape: BoxShape.circle),
                  ),
                ), //UI Controller
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      //Widget untuk Button, mendeteksi gerakan menekan tombol
                      onTap: () {
                        _sendMessageForward(); //Controller Button, mengirimkan sinyal maju ke database jika ditekan
                        //Sebuah fungsi yang akan dijalankan jika tombol dipencet 1x
                      },
                      child: Container(
                          height: 60,
                          width: 40,
                          decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(35),
                                  bottomRight: Radius.circular(35))),
                          child: SvgPicture.asset(
                            "assets/top.svg", //vector image untuk controller maju
                            fit: BoxFit.fill,
                          )),
                    ),
                    Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            _sendMessageLeft(); //Controller Button, mengirimkan sinyal kiri ke database jika ditekan
                          },
                          child: Container(
                            height: 40,
                            width: 60,
                            child: SvgPicture.asset(
                              "assets/left.svg", //vector image untuk controller kiri
                              fit: BoxFit.fill,
                            ),
                            decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(30),
                                    bottomRight: Radius.circular(30))),
                          ),
                        ),
                        Expanded(child: Container()),
                        GestureDetector(
                          onTap: () {
                            _sendMessageRight(); //Controller Button, mengirimkan sinyal kanan ke database jika ditekan
                          },
                          child: Container(
                            height: 40,
                            width: 60,
                            decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(30),
                                    topLeft: Radius.circular(30))),
                            child: SvgPicture.asset(
                              "assets/right.svg", //vector image untuk controller kanan
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        _sendMessageBackward(); //Controller Button, mengirimkan sinyal mundur ke database jika ditekan
                      },
                      child: Container(
                        height: 50,
                        width: 40,
                        decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30))),
                        child: SvgPicture.asset(
                          "assets/bottom.svg", //vector image untuk controller mundur
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: RaisedButton(
            onPressed: () {
              if (_isScreenOn == false) {//mengecek kondisi video streaming
                setState(() {
                  _isScreenOn = true; //jika button ditekan pada kondisi off maka akan berfungsi untuk menyalakan video streaming
                  _sendMessageInitial();//mengirim pesan ke firebase
                });
              } else {
                setState(() {
                  _isScreenOn = false; //sebaliknya jika ditekan pada kondisi on maka akan mematikan video streaming
                  _sendMessageInitial();//mengirim pesan ke firebase
                });
              }
            },
            child: _isScreenOn ? Text("stop") /*text pada kondisi video streaming on*/: Text("start"),//text pada kondisi off
            color: Colors.grey,
          ),
        )
      ],
    );
  }

  Widget fourbutton() {
    //membuat widget tombol untuk setting wifi, led, dan brake
    return Container(
      height: 150,
      width: 138,
      decoration: BoxDecoration(shape: BoxShape.circle),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Neumorphic(
            style: NeumorphicStyle(
                shape: NeumorphicShape.convex,
                boxShape: NeumorphicBoxShape.circle(),
                depth: 10,
                shadowLightColor: Colors.white,
                color: Colors.grey.withOpacity(0.7)),
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(shape: BoxShape.circle),
              child: IconButton(//berupa icon yang bisa berfungsi sebagai button
                icon: Icon(Icons.change_history),
                iconSize: 35,
                color: Colors.lightGreen,
                onPressed: () {
                  _sendMessageLedOn(); //untuk menyalakan led
                },
              ),
            ),
          ),
          Expanded(child: Container()),
          Row(
            children: <Widget>[
              Neumorphic(
                style: NeumorphicStyle(
                    shape: NeumorphicShape.convex,
                    boxShape: NeumorphicBoxShape.circle(),
                    depth: 10,
                    shadowLightColor: Colors.white,
                    color: Colors.grey.withOpacity(0.7)),
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  child: IconButton(
                    icon: Icon(Icons.crop_square),
                    iconSize: 35,
                    color: Colors.purple,
                    onPressed: () {
                      OpenSettings.openWIFISetting(); //untuk mengakses pengaturan WiFi pada perangkat
                    },
                  ),
                ),
              ),
              Expanded(child: Container()),
              Neumorphic(
                style: NeumorphicStyle(
                    shape: NeumorphicShape.convex,
                    boxShape: NeumorphicBoxShape.circle(),
                    depth: 10,
                    shadowLightColor: Colors.white,
                    color: Colors.grey.withOpacity(0.7)),
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  child: IconButton(
                    icon: Icon(Icons.panorama_fish_eye),
                    iconSize: 35,
                    color: Colors.pinkAccent,
                    onPressed: _sendMessageBrake(),//untuk braking/mematikan motor
                  ),
                ),
              )
            ],
          ),
          Expanded(child: Container()),
          Neumorphic(
            style: NeumorphicStyle(
                shape: NeumorphicShape.convex,
                boxShape: NeumorphicBoxShape.circle(),
                depth: 10,
                shadowLightColor: Colors.white,
                color: Colors.grey.withOpacity(0.7)),
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(shape: BoxShape.circle),
              child: IconButton(
                icon: Icon(Icons.close),
                iconSize: 35,
                color: Colors.blueAccent,
                onPressed: () {
                  _sendMessageLedOff();//untuk mematikan led
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
