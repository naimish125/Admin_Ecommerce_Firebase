import 'package:firebase_core/firebase_core.dart';
import 'package:firebaselogin/utils/notification_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'Login/SignIn_Screen.dart';
import 'Login/SignUp_Screen.dart';
import 'data/add_data.dart';
import 'data/data_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await NotificationHelper.Helper.init();

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(name: '/', page: () => Login_Screen(),),
        GetPage(name: '/SingUp', page: () => SingUp_Screen(),),
        GetPage(name: '/add', page: () => AddScreen(),),
        GetPage(name: '/data', page: () => DataSee(),),
      ],
    ),
  );
}
