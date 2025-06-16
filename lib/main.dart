import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_feed/routes/app_pages.dart';

import 'modules/auth/controllers/auth_controller.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();
  Get.put(AuthController());
  runApp( MyApp());
}


class MyApp extends StatelessWidget {
  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      getPages: AppPages.routes,
    );
  }
}