import 'package:flutter/material.dart'; //library UI Flutter
import 'package:smarc_app/homePage.dart'; //navigasi ke Dashboard UI

class Splash extends StatefulWidget {
  //Widget dinamis
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() =>
      _SplashState(); //membuat kondisi untuk bisa menampilkan SplashScreen
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _navigatetoHome(); //memanggil fungsi untuk navigasi ke Dashboard UI
  }

  _navigatetoHome() async {
    await Future.delayed(Duration(milliseconds: 1500), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => homePage()));
  } //navigasi ke Dashboard UI setelah 1.5 detik menampilkan layar Splash Screen

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        alignment: Alignment.center, //membuat posisi objek di tengah
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, //membuat posisi objek di tengah
          children: [
            SizedBox(
              height: 125,
            ), // membuat jarak kosong pada tampilan
            Text(
              "SMARC",
              style: TextStyle(
                fontSize: 48,
                color: Colors.white,
                fontFamily: 'arcade',
              ),
            ), // menampilkan teks dengan format tertentu
            SizedBox(height: 10),
            Text(
              "Smart RC CAR",
              style: TextStyle(
                  fontFamily: 'retro',
                  fontSize: 20,
                  fontWeight: FontWeight.w300),
            ),
            SizedBox(height: 100),
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Theresa Tiffany",
                  style: TextStyle(
                      fontFamily: 'retro', fontSize: 24, color: Colors.white70),
                ),
                Text(
                  "James Jeremia",
                  style: TextStyle(
                      fontFamily: 'retro', fontSize: 24, color: Colors.white70),
                )
              ],
            ))
          ],
        ),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              Colors.lightBlue,
              Colors.lightGreen
            ])), //membuat background gradien
      ),
    );
  }
}
