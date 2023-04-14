import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';
import 'package:contactus/contactus.dart';
import 'package:flutter/foundation.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginDemo(),
    );
  }
}

class LoginDemo extends StatefulWidget {
  @override
  _LoginDemoState createState() => _LoginDemoState();
}

class _LoginDemoState extends State<LoginDemo> {
  String emailAdresim = 'admin@gmail.com';
  String emailSifrem = 'Sifrem0!';
  TextEditingController emailController = TextEditingController();
  TextEditingController sifreController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  bool validateStructure(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 0.0),
              child: Center(
                child: Container(
                  margin: EdgeInsets.only(bottom: 0.0),
                  height: 300,
                  width: 200,
                  /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                  child: Image.asset(
                    'assets/images/logopink.png',
                  ),
                ),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: TextField(
                textAlign: TextAlign.left,
                controller: emailController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(color: Colors.pink),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'e-Mail',
                  hintText: 'admin@gmail.com',
                  hintStyle: TextStyle(color: Colors.pink),
                  labelStyle: TextStyle(
                    color: Colors.black38,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  textAlign: TextAlign.left,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(8),
                  ],
                  controller: sifreController,
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(color: Colors.pink),
                    ),
                    labelText: 'Şifre',
                    hintText: 'şifrenizi girin',
                    labelStyle: TextStyle(
                      color: Colors.black38,
                      fontSize: 20,
                    ),
                    hintStyle: TextStyle(color: Colors.pink),
                  ),
                )),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ForgetPass()),
                );
              },
              child: Text(
                'Şifrenizi mi unuttunuz?',
                style: TextStyle(color: Colors.pinkAccent, fontSize: 15),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 30,
              ),
              height: 50,
              width: 250,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                ),
                onPressed: () {
                  if (emailController.text.isEmpty &&
                      sifreController.text.isEmpty &&
                      validateStructure(sifreController.text) == true) {
                    print(emailController.text.isEmpty);
                    print(sifreController.text.isEmpty);
                    WarningAlertBox(
                      context: context,
                      title: 'Değer girdiğinizden emin olun!',
                      messageText: 'Email veya şifre alanları boş geçilemez!',
                      buttonText: 'Tamam',
                    );
                  } else if (emailAdresim == emailController.text &&
                      emailSifrem == sifreController.text &&
                      sifreController.text.length == 8 &&
                      validateStructure(sifreController.text) == true) {
                    SuccessAlertBox(
                      context: context,
                      title: 'Giriş başarılı!',
                      messageText:
                          'Kapat tuşuna bastığınızda yönlendirilmiş olacaksınız',
                      buttonText: 'Kapat',
                    );

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => SecondPage(title: '')));
                  } else if (validateStructure(sifreController.text) == false &&
                      emailController.text == 'admin@gmail.com') {
                    InfoAlertBox(
                      context: context,
                      title: 'Önemli!',
                      infoMessage:
                          'Şifreniz 8 haneli olup içerisinde mutlaka büyük harf, küçük harf, sayı ve özel karakter barındırmalıdır!',
                      buttonText: 'Tamam',
                    );
                  } else {
                    DangerAlertBox(
                      context: context,
                      title: 'Email veya şifreniz hatalı!',
                      messageText:
                          'Girdiğiniz değerleri kontrol edin ve yeniden deneyin!',
                      buttonText: 'Yeniden dene',
                    );
                  }
                },
                child: Text(
                  'Giriş',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignPage()));
              },
              child: Text(
                'Yeni misin? Hemen Kaydol!',
                style: TextStyle(
                  color: Colors.deepPurple,
                ),
              ),
            ),
            SizedBox(
              height: 130,
            ),
          ],
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  SecondPage({Key? key, required String title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.yellow, size: 30.0),
        titleTextStyle: TextStyle(
          fontSize: 22,
          color: Colors.yellow,
        ),
        centerTitle: true,
        title: Text(
          'Anasayfa',
          style: TextStyle(fontSize: 29),
        ),
        backgroundColor: Colors.pinkAccent,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/images/pngeggs.png'),
              ),
              accountEmail: Text(
                '203301136@ogr.selcuk.edu.tr',
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
              accountName: Text(
                'Veli Furkan Kaplan',
                style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.white,
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.pink,
              ),
            ),
            ListTile(
              splashColor: Color(0Xffece0fd),
              leading: const Icon(
                Icons.home,
                color: Colors.pink,
              ),
              title: const Text(
                'Anasayfa',
                style: TextStyle(fontSize: 24.0, color: Color(0xFF6200ee)),
              ),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => SecondPage(
                      title: 'Anasayfa',
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.fiber_new_sharp,
                color: Colors.pink,
              ),
              title: const Text(
                'Haberler',
                style: TextStyle(fontSize: 24.0, color: Color(0xFF6200ee)),
              ),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => HaberPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.article,
                color: Colors.pink,
              ),
              title: const Text(
                'Makaleler',
                style: TextStyle(fontSize: 24.0, color: Color(0xFF6200ee)),
              ),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => MakalePage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.people,
                color: Colors.pink,
              ),
              title: const Text(
                'Yazarlar',
                style: TextStyle(fontSize: 24.0, color: Color(0xFF6200ee)),
              ),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => YazarPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.chat_bubble_sharp,
                color: Colors.pink,
              ),
              title: const Text(
                'Hakkımızda',
                style: TextStyle(fontSize: 24.0, color: Color(0xFF6200ee)),
              ),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => HakkimizPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.chat,
                color: Colors.pink,
              ),
              title: const Text(
                'Bana Ulaşın',
                style: TextStyle(fontSize: 24.0, color: Colors.deepPurple),
              ),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => ContactView(),
                  ),
                );
              },
            ),
            AboutListTile(
              applicationName: "Lisans",
              applicationIcon: Icon(
                Icons.save,
                color: Colors.pink,
              ),
              applicationVersion: "1.0.0",
              child: Text(
                "App Bilgileri",
                style: TextStyle(fontSize: 24, color: Colors.deepPurple),
              ),
              icon: Icon(
                Icons.save,
                color: Colors.pink,
              ),
              applicationLegalese: null,
            )
          ],
        ),
      ),
      body: Center(
        child: Text(
          'Yenilikler çok yakında...',
          style: TextStyle(fontSize: 30),
          textAlign: TextAlign.center,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
          ),
        ],
        selectedItemColor: Colors.amber[800],
        onTap: (value) {
          SimpleAlertBox(
            title: 'Cok Yakında....',
            infoMessage: 'Cok Yakında',
            context: context,
            buttonText: 'Tamam',
          );
        },
      ),
    );
  }
}

class SignPage extends StatefulWidget {
  SignPage({Key? key}) : super(key: key);

  @override
  State<SignPage> createState() => _SignPageState();
}

class _SignPageState extends State<SignPage> {
  String adminkkadi = '123';
  String adminsifre = '123';
  String admintel = '123';

  TextEditingController userController = TextEditingController();
  TextEditingController telefonController = TextEditingController();
  TextEditingController sifreController = TextEditingController();
  TextEditingController confirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  child: Text(
                    'Kayıt Ol',
                    style: TextStyle(fontSize: 42, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 15),
                  child: Text(
                    'Bir hesap oluşturun. Bu ücretsizdir',
                    style: TextStyle(fontSize: 17, color: Colors.black38),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30, right: 30, left: 30),
                  child: TextFormField(
                    controller: userController,
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.blue,
                        fontWeight: FontWeight.w600),
                    /*onTap: () {
                      setState(() {
                        alinanKullanici = userName.text;
                      });
                      print(alinanKullanici);
                    },*/
                    decoration: InputDecoration(
                      focusColor: Colors.white,
                      //add prefix icon
                      prefixIcon: Icon(
                        Icons.person_outline_rounded,
                        color: Colors.grey,
                      ),

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.blue, width: 1.0),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      fillColor: Colors.grey,

                      hintText: "Kullanıcı Adı/Telefon",

                      //make hint text
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontFamily: "verdana_regular",
                        fontWeight: FontWeight.w400,
                      ),

                      //create lable
                      labelText: 'Kullanıcı Adı/Telefon',
                      //lable style
                      labelStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontFamily: "verdana_regular",
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20, left: 30, right: 30),
                  child: TextFormField(
                    controller: telefonController,
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.blue,
                        fontWeight: FontWeight.w600),
                    onChanged: (value) {},
                    decoration: InputDecoration(
                      focusColor: Colors.white,
                      //add prefix icon
                      prefixIcon: Icon(
                        Icons.mobile_screen_share,
                        color: Colors.grey,
                      ),

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.blue, width: 1.0),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      fillColor: Colors.grey,

                      hintText: "Telefon Numarası",

                      //make hint text
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontFamily: "verdana_regular",
                        fontWeight: FontWeight.w400,
                      ),

                      //create lable
                      labelText: 'Telefon Numarası',
                      //lable style
                      labelStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontFamily: "verdana_regular",
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20, right: 30, left: 30),
                  child: TextFormField(
                    controller: sifreController,
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.blue,
                        fontWeight: FontWeight.w600),
                    onChanged: (value) {},
                    decoration: InputDecoration(
                      focusColor: Colors.white,
                      //add prefix icon
                      prefixIcon: Icon(
                        Icons.password_outlined,
                        color: Colors.grey,
                      ),

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.blue, width: 1.0),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      fillColor: Colors.grey,

                      hintText: "Şifre",

                      //make hint text
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontFamily: "verdana_regular",
                        fontWeight: FontWeight.w400,
                      ),

                      //create lable
                      labelText: 'Şifre',
                      //lable style
                      labelStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontFamily: "verdana_regular",
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20, right: 30, left: 30),
                  child: TextFormField(
                    controller: confirmController,
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.blue,
                        fontWeight: FontWeight.w600),
                    onChanged: (value) {},
                    decoration: InputDecoration(
                      focusColor: Colors.white,
                      //add prefix icon
                      prefixIcon: Icon(
                        Icons.password_sharp,
                        color: Colors.grey,
                      ),

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.blue, width: 1.0),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      fillColor: Colors.grey,

                      hintText: "Şifrenizi tekrar girin",

                      //make hint text
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontFamily: "verdana_regular",
                        fontWeight: FontWeight.w400,
                      ),

                      //create lable
                      labelText: 'Şifreyi Doğrula',
                      //lable style
                      labelStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontFamily: "verdana_regular",
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30),
                  width: 300,
                  height: 50,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.pink),
                    ),
                    onPressed: () {
                      if (userController.text.isEmpty ||
                          sifreController.text.isEmpty ||
                          telefonController.text.isEmpty ||
                          confirmController.text.isEmpty) {
                        DangerAlertBox(
                          context: context,
                          title: 'Dikkat',
                          messageText: 'Bos alan bırakmayin',
                          buttonText: 'Tamam',
                        );
                      } else if (adminkkadi == userController.text &&
                          adminsifre == sifreController.text &&
                          admintel == telefonController.text &&
                          sifreController.text == confirmController.text) {
                        SuccessAlertBox(
                            title: 'Başarılı',
                            messageText: 'Başarıyla kayıt gerçekleştirildi',
                            context: context,
                            buttonText: 'Tamam');
                      } else if (adminkkadi == userController.text &&
                              adminsifre == sifreController.text ||
                          admintel == telefonController.text &&
                              sifreController.text != confirmController.text) {
                        DangerAlertBox(
                          context: context,
                          title: 'Dikkat!',
                          messageText: 'Parolaları dikkatle yeniden yazın!',
                          buttonText: 'Tamam',
                        );
                      } else {
                        DangerAlertBox(
                          context: context,
                          title: 'Hata!',
                          messageText:
                              'Girişleri belirtilen standartlara göre yapmadınız!',
                          buttonText: 'Tamam',
                        );
                      }
                    },
                    child: Text(
                      'Kayıt Ol',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontFamily: "verdana_regular",
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ForgetPass extends StatelessWidget {
  ForgetPass({Key? key}) : super(key: key);
  String forgetmail = '123';
  String forgettelefon = '123';
  TextEditingController forgetEmailController = TextEditingController();
  TextEditingController forgetTelefonController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  child: Text(
                    'Parola Sıfırlama',
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 12),
                  child: Text(
                    'Hesabınızı hemen kurtarın.',
                    style: TextStyle(fontSize: 17, color: Colors.black38),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30, right: 30, left: 30),
                  child: TextFormField(
                    controller: forgetEmailController,
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.blue,
                        fontWeight: FontWeight.w600),
                    /*onTap: () {
                      setState(() {
                        alinanKullanici = userName.text;
                      });
                      print(alinanKullanici);
                    },*/
                    decoration: InputDecoration(
                      focusColor: Colors.white,
                      //add prefix icon
                      prefixIcon: Icon(
                        Icons.person_outline_rounded,
                        color: Colors.grey,
                      ),

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.blue, width: 1.0),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      fillColor: Colors.grey,

                      hintText: "Kurtarmak istediğiniz hesabın e-postası",

                      //make hint text
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontFamily: "verdana_regular",
                        fontWeight: FontWeight.w400,
                      ),

                      //create lable
                      labelText: 'E-posta',
                      //lable style
                      labelStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontFamily: "verdana_regular",
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20, left: 30, right: 30),
                  child: TextFormField(
                    controller: forgetTelefonController,
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.blue,
                        fontWeight: FontWeight.w600),
                    onChanged: (value) {},
                    decoration: InputDecoration(
                      focusColor: Colors.white,
                      //add prefix icon
                      prefixIcon: Icon(
                        Icons.mobile_screen_share,
                        color: Colors.grey,
                      ),

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.blue, width: 1.0),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      fillColor: Colors.grey,

                      hintText: "Telefon Numaranız",

                      //make hint text
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontFamily: "verdana_regular",
                        fontWeight: FontWeight.w400,
                      ),

                      //create lable
                      labelText: 'Telefon Numarası',
                      //lable style
                      labelStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontFamily: "verdana_regular",
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30),
                  width: 300,
                  height: 50,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.pink),
                    ),
                    onPressed: () {
                      if (forgetmail == forgetEmailController.text &&
                          forgettelefon == forgetTelefonController.text) {
                        SuccessAlertBox(
                          title: 'Başarılı',
                          messageText:
                              'Parola sıfırlama bağlantısı mail adresinize gönderilmiştir.',
                          buttonText: 'Tamam',
                          context: context,
                        );
                      } else if (forgetTelefonController.text.isEmpty ||
                          forgetEmailController.text.isEmpty) {
                        WarningAlertBox(
                          context: context,
                          title: 'Boş bırakılan alan',
                          messageText:
                              'Lütfen istenen bilgileri doldurduğunuzdan emin olun!',
                          buttonText: 'Tamam',
                        );
                      } else {
                        InfoAlertBox(
                            context: context,
                            title: 'Sıfırlama Talebi',
                            infoMessage:
                                'Bilgileriniz sistemimizdeki bilgiler ile eşleşirse size bir sıfırlama bağlantısı göndereceğiz.');
                      }
                    },
                    child: Text(
                      'Parolayı Sıfırla',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontFamily: "verdana_regular",
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ContactView extends StatelessWidget {
  const ContactView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => SecondPage(title: ''),
              ),
            ),
          ),
        ),
        backgroundColor: Colors.pinkAccent,
        body: ContactUs(
          cardColor: Colors.white,
          textColor: Colors.teal.shade900,
          logo: const AssetImage('assets/images/myProfile.png'),
          email: '203301136@ogr.selcuk.edu.tr',
          companyName: 'Veli Furkan Kaplan',
          companyColor: Colors.teal.shade100,
          dividerThickness: 2,
          phoneNumber: '05555555555',
          website: 'selcuk.edu.tr',
          tagLine: 'Bilgisayar Mühendisliği Öğrencisi',
          taglineColor: Colors.teal.shade100,
          instagram: 'velifurkaan',
          facebookHandle: 'kullanmıyor',
          websiteText: 'Web Sitesi',
          phoneNumberText: 'Telefon Numarası',
          emailText: '203301136@ogr.selcuk.edu.tr',
        ),
      ),
    );
  }
}

class HaberPage extends StatelessWidget {
  const HaberPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.yellow, size: 30.0),
        titleTextStyle: TextStyle(
          fontSize: 22,
          color: Colors.yellow,
        ),
        centerTitle: true,
        title: Text(
          'Haberler',
          style: TextStyle(fontSize: 29),
        ),
        backgroundColor: Colors.pinkAccent,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/images/pngeggs.png'),
              ),
              accountEmail: Text(
                '203301136@ogr.selcuk.edu.tr',
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
              accountName: Text(
                'Veli Furkan Kaplan',
                style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.white,
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.pink,
              ),
            ),
            ListTile(
              splashColor: Color(0Xffece0fd),
              leading: const Icon(
                Icons.home,
                color: Colors.pink,
              ),
              title: const Text(
                'Anasayfa',
                style: TextStyle(fontSize: 24.0, color: Color(0xFF6200ee)),
              ),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => SecondPage(
                      title: 'Anasayfa',
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.fiber_new_sharp,
                color: Colors.pink,
              ),
              title: const Text(
                'Haberler',
                style: TextStyle(fontSize: 24.0, color: Color(0xFF6200ee)),
              ),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => HaberPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.article,
                color: Colors.pink,
              ),
              title: const Text(
                'Makaleler',
                style: TextStyle(fontSize: 24.0, color: Color(0xFF6200ee)),
              ),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => MakalePage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.people,
                color: Colors.pink,
              ),
              title: const Text(
                'Yazarlar',
                style: TextStyle(fontSize: 24.0, color: Color(0xFF6200ee)),
              ),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => YazarPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.chat_bubble_sharp,
                color: Colors.pink,
              ),
              title: const Text(
                'Hakkımızda',
                style: TextStyle(fontSize: 24.0, color: Color(0xFF6200ee)),
              ),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => HakkimizPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.chat,
                color: Colors.pink,
              ),
              title: const Text(
                'Bana Ulaşın',
                style: TextStyle(fontSize: 24.0, color: Colors.deepPurple),
              ),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => ContactView(),
                  ),
                );
              },
            ),
            AboutListTile(
              applicationName: "Lisans",
              applicationIcon: Icon(
                Icons.save,
                color: Colors.pink,
              ),
              applicationVersion: "1.0.0",
              child: Text(
                "App Bilgileri",
                style: TextStyle(fontSize: 24, color: Colors.deepPurple),
              ),
              icon: Icon(
                Icons.save,
                color: Colors.pink,
              ),
              applicationLegalese: null,
            )
          ],
        ),
      ),
      body: Center(
        child: Text(
          'Yenilikler çok yakında...',
          style: TextStyle(fontSize: 30),
          textAlign: TextAlign.center,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
          ),
        ],
        selectedItemColor: Colors.amber[800],
        onTap: (value) {
          SimpleAlertBox(
            title: 'Cok Yakında....',
            infoMessage: 'Cok Yakında',
            context: context,
            buttonText: 'Tamam',
          );
        },
      ),
    );
  }
}

class MakalePage extends StatelessWidget {
  const MakalePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.yellow, size: 30.0),
        titleTextStyle: TextStyle(
          fontSize: 22,
          color: Colors.yellow,
        ),
        centerTitle: true,
        title: Text(
          'Makaleler',
          style: TextStyle(fontSize: 29),
        ),
        backgroundColor: Colors.pinkAccent,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/images/pngeggs.png'),
              ),
              accountEmail: Text(
                '203301136@ogr.selcuk.edu.tr',
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
              accountName: Text(
                'Veli Furkan Kaplan',
                style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.white,
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.pink,
              ),
            ),
            ListTile(
              splashColor: Color(0Xffece0fd),
              leading: const Icon(
                Icons.home,
                color: Colors.pink,
              ),
              title: const Text(
                'Anasayfa',
                style: TextStyle(fontSize: 24.0, color: Color(0xFF6200ee)),
              ),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => SecondPage(
                      title: 'Anasayfa',
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.fiber_new_sharp,
                color: Colors.pink,
              ),
              title: const Text(
                'Haberler',
                style: TextStyle(fontSize: 24.0, color: Color(0xFF6200ee)),
              ),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => HaberPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.article,
                color: Colors.pink,
              ),
              title: const Text(
                'Makaleler',
                style: TextStyle(fontSize: 24.0, color: Color(0xFF6200ee)),
              ),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => MakalePage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.people,
                color: Colors.pink,
              ),
              title: const Text(
                'Yazarlar',
                style: TextStyle(fontSize: 24.0, color: Color(0xFF6200ee)),
              ),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => YazarPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.chat_bubble_sharp,
                color: Colors.pink,
              ),
              title: const Text(
                'Hakkımızda',
                style: TextStyle(fontSize: 24.0, color: Color(0xFF6200ee)),
              ),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => HakkimizPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.chat,
                color: Colors.pink,
              ),
              title: const Text(
                'Bana Ulaşın',
                style: TextStyle(fontSize: 24.0, color: Colors.deepPurple),
              ),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => ContactView(),
                  ),
                );
              },
            ),
            AboutListTile(
              applicationName: "Lisans",
              applicationIcon: Icon(
                Icons.save,
                color: Colors.pink,
              ),
              applicationVersion: "1.0.0",
              child: Text(
                "App Bilgileri",
                style: TextStyle(fontSize: 24, color: Colors.deepPurple),
              ),
              icon: Icon(
                Icons.save,
                color: Colors.pink,
              ),
              applicationLegalese: null,
            )
          ],
        ),
      ),
      body: Center(
        child: Text(
          'Yenilikler çok yakında...',
          style: TextStyle(fontSize: 30),
          textAlign: TextAlign.center,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
          ),
        ],
        selectedItemColor: Colors.amber[800],
        onTap: (value) {
          SimpleAlertBox(
            title: 'Cok Yakında....',
            infoMessage: 'Cok Yakında',
            context: context,
            buttonText: 'Tamam',
          );
        },
      ),
    );
  }
}

class HakkimizPage extends StatelessWidget {
  const HakkimizPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.yellow, size: 30.0),
        titleTextStyle: TextStyle(
          fontSize: 22,
          color: Colors.yellow,
        ),
        centerTitle: true,
        title: Text(
          'Hakkimizda',
          style: TextStyle(fontSize: 29),
        ),
        backgroundColor: Colors.pinkAccent,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/images/pngeggs.png'),
              ),
              accountEmail: Text(
                '203301136@ogr.selcuk.edu.tr',
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
              accountName: Text(
                'Veli Furkan Kaplan',
                style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.white,
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.pink,
              ),
            ),
            ListTile(
              splashColor: Color(0Xffece0fd),
              leading: const Icon(
                Icons.home,
                color: Colors.pink,
              ),
              title: const Text(
                'Anasayfa',
                style: TextStyle(fontSize: 24.0, color: Color(0xFF6200ee)),
              ),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => SecondPage(
                      title: 'Anasayfa',
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.fiber_new_sharp,
                color: Colors.pink,
              ),
              title: const Text(
                'Haberler',
                style: TextStyle(fontSize: 24.0, color: Color(0xFF6200ee)),
              ),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => HaberPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.article,
                color: Colors.pink,
              ),
              title: const Text(
                'Makaleler',
                style: TextStyle(fontSize: 24.0, color: Color(0xFF6200ee)),
              ),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => MakalePage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.people,
                color: Colors.pink,
              ),
              title: const Text(
                'Yazarlar',
                style: TextStyle(fontSize: 24.0, color: Color(0xFF6200ee)),
              ),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => YazarPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.chat_bubble_sharp,
                color: Colors.pink,
              ),
              title: const Text(
                'Hakkımızda',
                style: TextStyle(fontSize: 24.0, color: Color(0xFF6200ee)),
              ),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => HakkimizPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.chat,
                color: Colors.pink,
              ),
              title: const Text(
                'Bana Ulaşın',
                style: TextStyle(fontSize: 24.0, color: Colors.deepPurple),
              ),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => ContactView(),
                  ),
                );
              },
            ),
            AboutListTile(
              applicationName: "Lisans",
              applicationIcon: Icon(
                Icons.save,
                color: Colors.pink,
              ),
              applicationVersion: "1.0.0",
              child: Text(
                "App Bilgileri",
                style: TextStyle(fontSize: 24, color: Colors.deepPurple),
              ),
              icon: Icon(
                Icons.save,
                color: Colors.pink,
              ),
              applicationLegalese: null,
            )
          ],
        ),
      ),
      body: Center(
        child: Text(
          'Yenilikler çok yakında...',
          style: TextStyle(fontSize: 30),
          textAlign: TextAlign.center,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
          ),
        ],
        selectedItemColor: Colors.amber[800],
        onTap: (value) {
          SimpleAlertBox(
            title: 'Cok Yakında....',
            infoMessage: 'Cok Yakında',
            context: context,
            buttonText: 'Tamam',
          );
        },
      ),
    );
  }
}

class YazarPage extends StatelessWidget {
  const YazarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.yellow, size: 30.0),
        titleTextStyle: TextStyle(
          fontSize: 22,
          color: Colors.yellow,
        ),
        centerTitle: true,
        title: Text(
          'Yazarlar',
          style: TextStyle(fontSize: 29),
        ),
        backgroundColor: Colors.pinkAccent,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/images/pngeggs.png'),
              ),
              accountEmail: Text(
                '203301136@ogr.selcuk.edu.tr',
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
              accountName: Text(
                'Veli Furkan Kaplan',
                style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.white,
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.pink,
              ),
            ),
            ListTile(
              splashColor: Color(0Xffece0fd),
              leading: const Icon(
                Icons.home,
                color: Colors.pink,
              ),
              title: const Text(
                'Anasayfa',
                style: TextStyle(fontSize: 24.0, color: Color(0xFF6200ee)),
              ),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => SecondPage(
                      title: 'Anasayfa',
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.fiber_new_sharp,
                color: Colors.pink,
              ),
              title: const Text(
                'Haberler',
                style: TextStyle(fontSize: 24.0, color: Color(0xFF6200ee)),
              ),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => HaberPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.article,
                color: Colors.pink,
              ),
              title: const Text(
                'Makaleler',
                style: TextStyle(fontSize: 24.0, color: Color(0xFF6200ee)),
              ),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => MakalePage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.people,
                color: Colors.pink,
              ),
              title: const Text(
                'Yazarlar',
                style: TextStyle(fontSize: 24.0, color: Color(0xFF6200ee)),
              ),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => YazarPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.chat_bubble_sharp,
                color: Colors.pink,
              ),
              title: const Text(
                'Hakkımızda',
                style: TextStyle(fontSize: 24.0, color: Color(0xFF6200ee)),
              ),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => HakkimizPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.chat,
                color: Colors.pink,
              ),
              title: const Text(
                'Bana Ulaşın',
                style: TextStyle(fontSize: 24.0, color: Colors.deepPurple),
              ),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => ContactView(),
                  ),
                );
              },
            ),
            AboutListTile(
              applicationName: "Lisans",
              applicationIcon: Icon(
                Icons.save,
                color: Colors.pink,
              ),
              applicationVersion: "1.0.0",
              child: Text(
                "App Bilgileri",
                style: TextStyle(fontSize: 24, color: Colors.deepPurple),
              ),
              icon: Icon(
                Icons.save,
                color: Colors.pink,
              ),
              applicationLegalese: null,
            )
          ],
        ),
      ),
      body: Center(
        child: Text(
          'Yenilikler çok yakında...',
          style: TextStyle(fontSize: 30),
          textAlign: TextAlign.center,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
          ),
        ],
        selectedItemColor: Colors.amber[800],
        onTap: (value) {
          SimpleAlertBox(
            title: 'Cok Yakında....',
            infoMessage: 'Cok Yakında',
            context: context,
            buttonText: 'Tamam',
          );
        },
      ),
    );
  }
}
