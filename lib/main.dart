import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:poc_excel_to_json/dashboard/dashboard_binding.dart';
import 'package:poc_excel_to_json/dashboard/dashboard_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "POC",
      initialRoute: "/",
      locale: const Locale('en', 'US'),
      initialBinding: DashboardBinding(),
      home: const DashboardView(),
    );
  }
}
