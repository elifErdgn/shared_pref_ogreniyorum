import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<void> veriOku() async {
    var sp = await SharedPreferences.getInstance();
    String ad = sp.getString("ad") ?? "isim yok";
    int yas = sp.getInt("yas") ?? 99;
    double boy = sp.getDouble("boy") ?? 9.99;
    bool bekarMi = sp.getBool("bekarMi") ?? false;

    var arkadasListe = sp.getStringList("arkadasListe") ?? null;

    print("Ad: $ad");
    print("yas: $yas");
    print("boy: $boy");
    print("bekarMi: $bekarMi");

    /// yazdırmak istediğimiz bir liste olduğu için for döngüsünde yazdıramız gerekiyor.
    ///
    for (var a in arkadasListe!) {
      print("Arkadaş :$a");
    }
  }

  Future<void> veriKaydi() async {
    var sp = await SharedPreferences.getInstance();

    /// KEY - VALUE ilişkisi ile sutun adını ve eklediğimiz değeri belirtiyoruz ve bu kısımda tek tek veri ekleme gerçeklelşiyor.
    sp.setString("ad", "ahmet");
    sp.setInt("yas", 18);
    sp.setDouble("boy", 1.78);
    sp.setBool("bekarMi", true);


    var arkadasListe = <String>[];
    arkadasListe.add("Ece");
    arkadasListe.add("Ali");
    /// string türünde bir liste oluşturduk ve bu listeye verileri bu kısımda ekledik
    /// daha sonra da listeyi tamamı ile veritabanına aktardık
    sp.setStringList("arkadasListe", arkadasListe);
  }

  Future<void> veriSil() async {
    var sp = await SharedPreferences.getInstance();
    sp.remove("ad");
  }

  Future<void> veriGuncelle() async {
    var sp = await SharedPreferences.getInstance();
    sp.setInt("yas", 100);
  }

  @override
  void initState() {
    super.initState();

    ///veriSil();
    veriGuncelle();
    veriOku();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shared pref pratik"),
      ),
      body: Column(
        children: [
          /// KEY - VALUE ilişkisi ile basit verileri kalıcı depolayabiliriz.
          /// uygulama silinirse veriler de siliniyor

          InkWell(
            onTap: () {
              veriKaydi();
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              width: double.infinity,
              color: Colors.deepOrange,
              child: Center(
                child: Text("Veri kaydet"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
