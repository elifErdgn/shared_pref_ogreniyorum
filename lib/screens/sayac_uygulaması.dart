import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SayacUygulamasi extends StatefulWidget {
  const SayacUygulamasi({Key? key}) : super(key: key);

  @override
  State<SayacUygulamasi> createState() => _SayacUygulamasiState();
}

class _SayacUygulamasiState extends State<SayacUygulamasi> {
  int sayac = 0;

  Future<void> sayacKontrol() async {
    var sp = await SharedPreferences.getInstance();

    sayac = sp.getInt("sayac") ?? 0;

    setState(() {
      sayac = sayac + 1;
    });

    sp.setInt("sayac", sayac);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sayacKontrol();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SAYAÇ EKRANI"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Açılış Sayısı : $sayac",
              style: TextStyle(fontSize: 50),
            ),
          ],
        ),
      ),
    );
  }
}
