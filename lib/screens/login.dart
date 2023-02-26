import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginEkran extends StatefulWidget {
  const LoginEkran({Key? key}) : super(key: key);

  @override
  State<LoginEkran> createState() => _LoginEkranState();
}

class _LoginEkranState extends State<LoginEkran> {
  var tfKullaniciAdi = TextEditingController();
  var tfSifre = TextEditingController();

  var scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> girisKontrol() async {
    var ka = tfKullaniciAdi.text;
    var s = tfSifre.text;

    if (ka == "admin" && s == "123") {
      var sp = await SharedPreferences.getInstance();

      sp.setString("kullaniciadi", ka);
      sp.setString("sifre", s);

      Navigator.pushReplacement(
        // geri iconu artık pasif sistemden geldiği sayfayı kaldırdı.
          context,
          MaterialPageRoute(
            builder: (context) => AnaSayfa(),
          ));
    } else {
      print("Giriş Hatalı");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey, //sncakbarı kullanabilmek için gerekli
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: tfKullaniciAdi,
                decoration: InputDecoration(
                  hintText: "Kullanıcı Adı ",
                ),
              ),
              TextField(
                controller: tfSifre,
                decoration: InputDecoration(
                  hintText: "Sifre ",
                ),
              ),
              GestureDetector(
                onTap: girisKontrol,
                child: Container(
                  color: Colors.orange,
                  width: double.infinity,
                  height: 60,
                  child: Center(
                    child: Text("Giriş Yap"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AnaSayfa extends StatefulWidget {
  const AnaSayfa({Key? key}) : super(key: key);

  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {


   String? spKullaniciAdi;
   String? spSifre;
 


  Future<void> oturumBilgisiOku()async {

    var sp = await SharedPreferences.getInstance();

    setState(() {
      spKullaniciAdi = sp.getString("kullaniciadi") ?? "kullanıcı adı girilmemiş";
      spSifre = sp.getString("sifre") ?? "sifre oluşturulmamış";
    });

  }

  Future<void> cikisYap() async {

    var sp = await SharedPreferences.getInstance();

    sp.remove("kullaniciadi");
    sp.remove("sifre");

    Navigator.pushReplacement(
      // geri iconu artık pasif sistemden geldiği sayfayı kaldırdı.
        context,
        MaterialPageRoute(
          builder: (context) => LoginEkran(),
        ));


  }

  @override
  void initState() {
    super.initState();
    oturumBilgisiOku();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: cikisYap,
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Column(
        children: [
          Text(
            "Kullanıcı Adı :$spKullaniciAdi ",
            style: TextStyle(fontSize: 30),
          ),
          Text(
            "Şifre : $spSifre",
            style: TextStyle(fontSize: 30),
          ),
        ],
      ),
    );
  }
}
