import 'dart:io';
import 'dart:ui';

import 'package:fl_project/controllers/database_controller.dart';
import 'package:fl_project/ui/app_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:window_manager/window_manager.dart';

void main() async {


  if (Platform.isWindows) {
    WidgetsFlutterBinding.ensureInitialized();
    await windowManager.ensureInitialized();
    windowManager.waitUntilReadyToShow().then((_) async {
      await windowManager.setTitleBarStyle(TitleBarStyle.normal);
      await windowManager.setTitle("Test App");
      await windowManager.setSize(Size(900, 500));
      await windowManager.center();
      await windowManager.show();
    });
    sqfliteFfiInit();
  }
  databaseFactory = databaseFactoryFfi;
  injectDependency();

  runApp(const MyApp());
}
class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
  };
}
injectDependency() {
  final DatabaseController _dataController = Get.put(DatabaseController());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      scrollBehavior: MyCustomScrollBehavior(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AppScreen(),
    );
  }
}
