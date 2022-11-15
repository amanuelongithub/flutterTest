import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertest/screen/auth_screen.dart';
import 'package:fluttertest/screen/home_screen.dart';
import 'package:fluttertest/screen/login.dart';
import 'package:fluttertest/utils/colors..dart';
import 'package:get/get.dart';
import 'firebase_options.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

final navigatorKey = GlobalKey<NavigatorState>();

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'HandoSoft',
        backgroundColor: Colors.white,
      ),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(color: AppColors.maincolor);
          } else if (snapshot.hasError) {
            return Center(
                child: Text(
              '${snapshot.error}',
            ));
          } else if (snapshot.hasData) {
            return Container(
                // decoration: BoxDecoration(
                //     image: DecorationImage(
                //         image: AssetImage(
                //           "assets/img/screen_bg.jpg",
                //         ),
                //         fit: BoxFit.cover)),
                child: const HomePage());
          } else {
            return Container(
                // decoration: BoxDecoration(
                //     image: DecorationImage(
                //         image: AssetImage(
                //           "assets/img/screen_bg.jpg",
                //         ),
                //         fit: BoxFit.cover)),
                child: const AuthPage());
          }
        },
      ),
    );
  }
}
