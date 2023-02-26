import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  Future<bool> oturumKontrol() async {
    var sp = await SharedPreferences.getInstance();

    String spKullaniciAdi =
        sp.getString("kullaniciadi") ?? "kullanıcı adı girilmemiş";
    String spSifre = sp.getString("sifre") ?? "sifre yok";

    if (spKullaniciAdi == "admin" && spSifre == "123") {
      return true;
    } else {
      return false;
    }
  }

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<bool>(
        future: oturumKontrol(),
        builder: (context,snapshot){
          if(snapshot.hasData){
              bool gecisIzni = snapshot.data!;
              return gecisIzni ? AnaSayfa() : LoginEkran();


          }else{
            return Container(

            );
          }
        },


      ),
    );
  }
}
